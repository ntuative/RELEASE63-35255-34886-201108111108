package com.sulake.core.runtime
{
    import com.sulake.core.utils.LibraryLoaderQueue;
    import flash.events.IEventDispatcher;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.core.Core;
    import flash.utils.getTimer;
    import flash.events.Event;
    import com.sulake.core.utils.profiler.ProfilerViewer;
    import flash.display.DisplayObjectContainer;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.utils.LibraryLoader;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.net.URLRequest;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.runtime.events.LibraryProgressEvent;
    import flash.utils.getQualifiedClassName;

    public final class CoreComponentContext extends ComponentContext implements ICore
    {

        private static const var_2625:uint = 3;
        private static const var_434:String = "asset-libraries";
        private static const var_435:String = "library";
        private static const var_436:String = "service-libraries";
        private static const var_437:String = "library";
        private static const var_438:String = "component-libraries";
        private static const var_439:String = "library";
        private static const var_431:String = "error_data";
        private static const var_432:String = "error_cat";
        private static const var_433:String = "error_desc";

        private var var_2626:LibraryLoaderQueue;
        private var var_2627:IEventDispatcher;
        private var var_2628:uint;
        private var var_2629:Function;
        private var var_2624:Profiler;
        private var var_2622:Array;
        private var var_2623:Array;
        private var _lastUpdateTimeMs:uint;
        private var var_2492:uint = 0;

        public function CoreComponentContext(param1:DisplayObjectContainer, param2:uint)
        {
            super(this, Component.COMPONENT_FLAG_CONTEXT, new AssetLibraryCollection("_core_assets"));
            this.var_2492 = param2;
            _debug = ((param2 & Core.CORE_SETUP_DEBUG) == Core.CORE_SETUP_DEBUG);
            this.var_2622 = new Array();
            this.var_2623 = new Array();
            var_430 = param1;
            var _loc3_:uint;
            while (_loc3_ < CoreComponentContext.var_2625)
            {
                this.var_2622.push(new Array());
                this.var_2623.push(0);
                _loc3_++;
            };
            this._lastUpdateTimeMs = getTimer();
            attachComponent(this, [new IIDCore()]);
            var_430.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            switch ((param2 & Core.var_75))
            {
                case Core.var_72:
                    debug("Core; using simple frame update handler");
                    this.var_2629 = this.simpleFrameUpdateHandler;
                    return;
                case Core.var_33:
                    debug("Core; using complex frame update handler");
                    this.var_2629 = this.complexFrameUpdateHandler;
                    return;
                case Core.var_73:
                    debug("Core; using profiler frame update handler");
                    this.var_2629 = this.profilerFrameUpdateHandler;
                    this.var_2624 = new Profiler(this);
                    attachComponent(this.var_2624, [new IIDProfiler()]);
                    var_430.addChild(new ProfilerViewer(this.var_2624));
                    return;
                case Core.var_74:
                    debug("Core; using experimental frame update handler");
                    this.var_2629 = this.experimentalFrameUpdateHandler;
                    return;
                case Core.CORE_SETUP_DEBUG:
                    debug("Core; using debug frame update handler");
                    this.var_2629 = this.debugFrameUpdateHandler;
                    return;
            };
        }

        public function getNumberOfFilesPending():uint
        {
            return (this.var_2626.length);
        }

        public function getNumberOfFilesLoaded():uint
        {
            return (this.var_2628 - this.getNumberOfFilesPending());
        }

        public function initialize():void
        {
            events.dispatchEvent(new Event(Component.COMPONENT_EVENT_RUNNING));
            Logger.log(toXMLString());
        }

        override public function dispose():void
        {
            var length:uint;
            var receivers:Array;
            var receiver:* = undefined;
            var i:uint;
            if (!disposed)
            {
                debug("Disposing core");
                try
                {
                    i = 0;
                    while (i < CoreComponentContext.var_2625)
                    {
                        receivers = (this.var_2622[i] as Array);
                        length = receivers.length;
                        while (length-- > 0)
                        {
                            receiver = receivers.pop();
                            if ((receiver is UpdateDelegate))
                            {
                                UpdateDelegate(receiver).dispose();
                            };
                        };
                        i++;
                    };
                }
                catch(e:Error)
                {
                };
                if (var_430)
                {
                    var_430.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                    var_430 = null;
                };
                if (this.var_2626 != null)
                {
                    this.var_2626.dispose();
                    this.var_2626 = null;
                };
                super.dispose();
            };
        }

        override public function error(param1:String, param2:Boolean, param3:int=-1, param4:Error=null):void
        {
            if (param4)
            {
                ErrorReportStorage.setParameter(var_431, String(param4.getStackTrace()));
            };
            ErrorReportStorage.setParameter(var_432, String(param3));
            ErrorReportStorage.setParameter(var_433, param1);
            super.error(param1, param2, param3, param4);
            if (param2)
            {
                this.dispose();
            };
        }

        public function readConfigDocument(config:XML, loadingEventDelegate:IEventDispatcher=null):void
        {
            var node:XML;
            var list:XMLList;
            var item:XML;
            var url:String;
            var loader:LibraryLoader;
            var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
            debug("Parsing config document");
            this.var_2627 = loadingEventDelegate;
            if (this.var_2626 == null)
            {
                this.var_2626 = new LibraryLoaderQueue(_debug);
            };
            try
            {
                node = config.child(var_434)[0];
                if (node != null)
                {
                    list = node.child(var_435);
                    for each (item in list)
                    {
                        url = item.attribute("url").toString();
                        loader = new LibraryLoader(context, true, _debug);
                        assets.loadFromFile(loader, true);
                        loader.load(new URLRequest(url));
                        this.var_2626.push(loader);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.updateLoadingProcess);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.errorInLoadingProcess);
                        this.var_2628++;
                    };
                };
            }
            catch(e:Error)
            {
                error("Failed to parse asset libraries from config xml!", true, Core.var_35, e);
            };
            try
            {
                node = config.child(var_436)[0];
                if (node != null)
                {
                    list = node.child(var_437);
                    for each (item in list)
                    {
                        url = item.attribute("url").toString();
                        loader = new LibraryLoader(context, true, _debug);
                        loader.load(new URLRequest(url));
                        this.var_2626.push(loader);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.updateLoadingProcess);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.errorInLoadingProcess);
                        this.var_2628++;
                    };
                };
            }
            catch(e:Error)
            {
                error("Failed to parse interfaces from config xml!", true, Core.var_35, e);
            };
            try
            {
                node = config.child(var_438)[0];
                if (node != null)
                {
                    list = node.child(var_439);
                    for each (item in list)
                    {
                        url = item.attribute("url").toString();
                        loader = new LibraryLoader(context, true, _debug);
                        loader.load(new URLRequest(url));
                        this.var_2626.push(loader);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.updateLoadingProcess);
                        loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.errorInLoadingProcess);
                        this.var_2628++;
                    };
                };
            }
            catch(e:Error)
            {
                error("Failed to parse components from config xml!", true, Core.var_35, e);
            };
            if (!disposed)
            {
                this.updateLoadingProcess();
            };
        }

        private function errorInLoadingProcess(param1:LibraryLoaderEvent=null):void
        {
            var _loc2_:LibraryLoader = LibraryLoader(param1.target);
            this.error(((((('Failed to download library "' + _loc2_.url) + '" HTTP status ') + param1.status) + ": ") + _loc2_.getLastErrorMessage()), true, Core.var_76);
            if (!disposed)
            {
                this.updateLoadingProcess(param1);
            };
        }

        private function finalizeLoadingEventDelegate():void
        {
            if (this.var_2627)
            {
                this.var_2627.dispatchEvent(new Event(Event.COMPLETE));
            };
        }

        private function updateLoadingProgress(param1:LibraryLoaderEvent=null):void
        {
            var _loc2_:LibraryLoader;
            if (this.var_2627)
            {
                _loc2_ = (param1.target as LibraryLoader);
                this.var_2627.dispatchEvent(new LibraryProgressEvent(_loc2_.url, param1.bytesLoaded, param1.bytesTotal, _loc2_.elapsedTime));
            };
        }

        private function updateLoadingProcess(param1:LibraryLoaderEvent=null):void
        {
            var _loc2_:LibraryLoader;
            var _loc3_:String;
            if (param1 != null)
            {
                if (((param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE) || (param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR)))
                {
                    _loc2_ = (param1.target as LibraryLoader);
                    _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.updateLoadingProcess);
                    _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.errorInLoadingProcess);
                    _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this.updateLoadingProgress);
                    _loc3_ = _loc2_.url;
                    debug(((('Loading library "' + _loc3_) + '" ') + ((param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE) ? "ready" : ("failed\n" + _loc2_.getLastErrorMessage()))));
                    _loc2_.dispose();
                    if (!disposed)
                    {
                        if (this.var_2627)
                        {
                            this.var_2627.dispatchEvent(new LibraryProgressEvent(_loc2_.url, (this.var_2628 - this.var_2626.length), this.var_2628, _loc2_.elapsedTime));
                        };
                    };
                };
            };
            if (!disposed)
            {
                if (this.var_2626.length == 0)
                {
                    this.finalizeLoadingEventDelegate();
                    debug("All libraries loaded, Core is now running");
                };
            };
        }

        override public function registerUpdateReceiver(param1:IUpdateReceiver, param2:uint):void
        {
            this.removeUpdateReceiver(param1);
            param2 = ((param2 >= CoreComponentContext.var_2625) ? (CoreComponentContext.var_2625 - 1) : param2);
            var _loc3_:int = ((this.var_2624) ? Core.var_73 : (this.var_2492 & Core.var_75));
            if (_loc3_ == Core.var_74)
            {
                this.var_2622[param2].push(new UpdateDelegate(param1, this, param2));
            }
            else
            {
                this.var_2622[param2].push(param1);
            };
        }

        override public function removeUpdateReceiver(param1:IUpdateReceiver):void
        {
            var _loc2_:int;
            var _loc3_:Array;
            var _loc6_:UpdateDelegate;
            if (disposed)
            {
                return;
            };
            var _loc4_:int = ((this.var_2624) ? Core.var_73 : (this.var_2492 & Core.var_75));
            var _loc5_:uint;
            while (_loc5_ < CoreComponentContext.var_2625)
            {
                _loc3_ = (this.var_2622[_loc5_] as Array);
                if (_loc4_ == Core.var_74)
                {
                    for each (_loc6_ in _loc3_)
                    {
                        if (_loc6_.receiver == param1)
                        {
                            _loc6_.dispose();
                            return;
                        };
                    };
                }
                else
                {
                    _loc2_ = _loc3_.indexOf(param1);
                    if (_loc2_ > -1)
                    {
                        _loc3_[_loc2_] = null;
                        return;
                    };
                };
                _loc5_++;
            };
        }

        private function onEnterFrame(param1:Event):void
        {
            var _loc2_:uint = getTimer();
            this.var_2629(_loc2_, (_loc2_ - this._lastUpdateTimeMs));
            this._lastUpdateTimeMs = _loc2_;
        }

        private function simpleFrameUpdateHandler(msCurrentTime:uint, msSinceLastUpdate:uint):void
        {
            var priority:uint;
            var receivers:Array;
            var receiver:IUpdateReceiver;
            var length:uint;
            var index:uint;
            priority = 0;
            while (priority < CoreComponentContext.var_2625)
            {
                this.var_2623[priority] = 0;
                receivers = this.var_2622[priority];
                index = 0;
                length = receivers.length;
                while (index != length)
                {
                    receiver = IUpdateReceiver(receivers[index]);
                    if (((receiver == null) || (receiver.disposed)))
                    {
                        receivers.splice(index, 1);
                        length--;
                    }
                    else
                    {
                        try
                        {
                            receiver.update(msSinceLastUpdate);
                        }
                        catch(e:Error)
                        {
                            error(((('Error in update receiver "' + getQualifiedClassName(receiver)) + '": ') + e.message), true, e.errorID, e);
                            return;
                        };
                        index++;
                    };
                };
                priority++;
            };
        }

        private function complexFrameUpdateHandler(msCurrentTime:uint, msSinceLastUpdate:uint):void
        {
            var priority:uint;
            var receivers:Array;
            var receiver:IUpdateReceiver;
            var length:uint;
            var index:uint;
            var skip:Boolean;
            var t:uint;
            var proceed:Boolean = true;
            var maxTimePerFrame:uint = uint((1000 / var_430.stage.frameRate));
            priority = 0;
            while (priority < CoreComponentContext.var_2625)
            {
                t = getTimer();
                skip = false;
                if ((t - msCurrentTime) > maxTimePerFrame)
                {
                    if (this.var_2623[priority] < priority)
                    {
                        this.var_2623[priority]++;
                        skip = true;
                    };
                };
                if (!skip)
                {
                    this.var_2623[priority] = 0;
                    receivers = this.var_2622[priority];
                    index = 0;
                    length = receivers.length;
                    while (((!(index == length)) && (proceed)))
                    {
                        receiver = IUpdateReceiver(receivers[index]);
                        if (((receiver == null) || (receiver.disposed)))
                        {
                            receivers.splice(index, 1);
                            length--;
                        }
                        else
                        {
                            try
                            {
                                receiver.update(msSinceLastUpdate);
                            }
                            catch(e:Error)
                            {
                                error(((('Error in update receiver "' + getQualifiedClassName(receiver)) + '": ') + e.message), true, e.errorID, e);
                                proceed = false;
                            };
                            index++;
                        };
                    };
                };
                priority++;
            };
        }

        private function profilerFrameUpdateHandler(msCurrentTime:uint, msSinceLastUpdate:uint):void
        {
            var priority:uint;
            var receivers:Array;
            var receiver:IUpdateReceiver;
            var length:uint;
            var index:uint;
            this.var_2624.start();
            priority = 0;
            while (priority < CoreComponentContext.var_2625)
            {
                this.var_2623[priority] = 0;
                receivers = this.var_2622[priority];
                index = 0;
                length = receivers.length;
                while (index != length)
                {
                    receiver = IUpdateReceiver(receivers[index]);
                    if (((receiver == null) || (receiver.disposed)))
                    {
                        receivers.splice(index, 1);
                        length--;
                    }
                    else
                    {
                        try
                        {
                            this.var_2624.update(receiver, msSinceLastUpdate);
                        }
                        catch(e:Error)
                        {
                            error(((('Error in update receiver "' + getQualifiedClassName(receiver)) + '": ') + e.message), true, e.errorID, e);
                            return;
                        };
                        index++;
                    };
                };
                priority++;
            };
            this.var_2624.stop();
        }

        private function experimentalFrameUpdateHandler(param1:uint, param2:uint):void
        {
            var _loc4_:Array;
            var _loc5_:int;
            var _loc3_:int;
            while (_loc3_ < CoreComponentContext.var_2625)
            {
                _loc4_ = this.var_2622[_loc3_];
                _loc5_ = (_loc4_.length - 1);
                while (_loc5_ > -1)
                {
                    if (_loc4_[_loc5_].disposed)
                    {
                        _loc4_.splice(_loc5_, 1);
                    };
                    _loc5_--;
                };
                _loc3_++;
            };
        }

        private function debugFrameUpdateHandler(param1:uint, param2:uint):void
        {
            var _loc3_:uint;
            var _loc4_:Array;
            var _loc5_:IUpdateReceiver;
            var _loc6_:uint;
            var _loc7_:uint;
            _loc3_ = 0;
            while (_loc3_ < CoreComponentContext.var_2625)
            {
                this.var_2623[_loc3_] = 0;
                _loc4_ = this.var_2622[_loc3_];
                _loc7_ = 0;
                _loc6_ = _loc4_.length;
                while (_loc7_ != _loc6_)
                {
                    _loc5_ = IUpdateReceiver(_loc4_[_loc7_]);
                    if (((_loc5_ == null) || (_loc5_.disposed)))
                    {
                        _loc4_.splice(_loc7_, 1);
                        _loc6_--;
                    }
                    else
                    {
                        _loc5_.update(param2);
                        _loc7_++;
                    };
                };
                _loc3_++;
            };
        }

        public function setProfilerMode(param1:Boolean):void
        {
            var _loc2_:int;
            var _loc3_:Array;
            var _loc4_:Object;
            var _loc5_:int;
            if (param1)
            {
                this.var_2629 = this.profilerFrameUpdateHandler;
                if (!this.var_2624)
                {
                    this.var_2624 = new Profiler(this);
                    attachComponent(this.var_2624, [new IIDProfiler()]);
                };
                _loc2_ = 0;
                while (_loc2_ < CoreComponentContext.var_2625)
                {
                    _loc3_ = this.var_2622[_loc2_];
                    _loc5_ = (_loc3_.length - 1);
                    while (_loc5_ > -1)
                    {
                        _loc4_ = _loc3_[_loc5_];
                        if ((_loc4_ is UpdateDelegate))
                        {
                            _loc3_[_loc5_] = UpdateDelegate(_loc4_).receiver;
                            UpdateDelegate(_loc4_).dispose();
                        };
                        _loc5_--;
                    };
                    _loc2_++;
                };
            }
            else
            {
                if (this.var_2624)
                {
                    detachComponent(this.var_2624);
                    this.var_2624.dispose();
                    this.var_2624 = null;
                };
                switch ((this.var_2492 & Core.var_75))
                {
                    case Core.var_72:
                        this.var_2629 = this.simpleFrameUpdateHandler;
                        return;
                    case Core.var_33:
                        this.var_2629 = this.complexFrameUpdateHandler;
                        return;
                    case Core.var_74:
                        this.var_2629 = this.experimentalFrameUpdateHandler;
                        _loc2_ = 0;
                        while (_loc2_ < CoreComponentContext.var_2625)
                        {
                            _loc3_ = this.var_2622[_loc2_];
                            _loc5_ = (_loc3_.length - 1);
                            while (_loc5_ > -1)
                            {
                                _loc4_ = _loc3_[_loc5_];
                                if ((_loc4_ is IUpdateReceiver))
                                {
                                    _loc3_[_loc5_] = new UpdateDelegate(IUpdateReceiver(_loc4_), this, _loc2_);
                                };
                                _loc5_--;
                            };
                            _loc2_++;
                        };
                        return;
                    default:
                        this.var_2629 = this.debugFrameUpdateHandler;
                };
            };
        }


    }
}import com.sulake.core.runtime.IDisposable;
import com.sulake.core.runtime.IUpdateReceiver;
import com.sulake.core.runtime.IContext;
import flash.events.Event;
import flash.utils.getTimer;
import flash.utils.getQualifiedClassName;

class UpdateDelegate implements IDisposable
{

    private var _receiver:IUpdateReceiver;
    private var _context:IContext;
    private var _priority:int;
    private var _lastUpdateTimeMs:uint;
    private var _framesSkipped:uint = 0;

    public function UpdateDelegate(param1:IUpdateReceiver, param2:IContext, param3:int)
    {
        if (((param2) && (param1)))
        {
            this._receiver = param1;
            this._context = param2;
            this._priority = param3;
            param2.displayObjectContainer.stage.addEventListener(((this._priority == 0) ? Event.EXIT_FRAME : Event.ENTER_FRAME), this.onFrameUpdate);
            this._lastUpdateTimeMs = getTimer();
        };
    }

    public function get priority():int
    {
        return (this._priority);
    }

    public function get receiver():IUpdateReceiver
    {
        return (this._receiver);
    }

    public function get disposed():Boolean
    {
        return ((this._receiver) ? this._receiver.disposed : true);
    }

    public function dispose():void
    {
        if (this._receiver)
        {
            this._receiver = null;
            this._context.displayObjectContainer.stage.removeEventListener(((this._priority == 0) ? Event.EXIT_FRAME : Event.ENTER_FRAME), this.onFrameUpdate);
            this._context = null;
        };
    }

    private function onFrameUpdate(event:Event):void
    {
        var msCurrentTime:uint;
        var msDeltaTime:uint;
        if (!this.disposed)
        {
            msCurrentTime = getTimer();
            msDeltaTime = (msCurrentTime - this._lastUpdateTimeMs);
            this._lastUpdateTimeMs = msCurrentTime;
            if (((this._priority > 0) && (this._framesSkipped < this._priority)))
            {
                if (msDeltaTime > (1000 / this._context.displayObjectContainer.stage.frameRate))
                {
                    this._framesSkipped++;
                    return;
                };
            };
            this._framesSkipped = 0;
            try
            {
                this._receiver.update(msDeltaTime);
            }
            catch(e:Error)
            {
                _context.error(((('Error in update receiver "' + getQualifiedClassName(_receiver)) + '": ') + e.message), true, e.errorID, e);
            };
        };
    }


}
