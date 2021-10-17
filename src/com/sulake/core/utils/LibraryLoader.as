package com.sulake.core.utils
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.utils.getTimer;
    import flash.display.DisplayObject;
    import flash.net.URLRequestHeader;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.display.MovieClip;
    import flash.display.FrameLabel;
    import flash.utils.ByteArray;
    import com.sulake.core.Core;

    public class LibraryLoader extends EventDispatcher implements IDisposable 
    {

        protected static const var_2641:uint = 1;
        protected static const var_2642:uint = 2;
        protected static const var_2643:uint = 4;
        protected static const var_2644:uint = 3;
        protected static const var_1304:uint = 7;
        public static const var_268:int = 5;
        public static const LIBRARY_LOADER_FINALIZE:String = "LIBRARY_LOADER_FINALIZE";
        public static const var_269:Boolean = false;
        public static const var_270:int = 2;
        private static var var_271:Array = new Array();
        private static var var_272:Array = new Array();

        protected var var_2551:Loader;
        protected var _context:LoaderContext;
        protected var var_2549:int = 0;
        protected var var_273:URLRequest;
        protected var _manifest:XML;
        protected var var_2559:Class;
        protected var var_2649:uint = 0;
        protected var _name:String;
        protected var var_2645:Boolean = false;
        protected var _debug:Boolean = false;
        protected var var_2648:Boolean = false;
        protected var var_2650:String = "";
        protected var var_2651:String = "";
        protected var var_2647:int;
        protected var var_2646:int;
        protected var var_2652:int;
        protected var var_2653:uint = 0;
        protected var var_2654:Boolean = true;

        public function LibraryLoader(param1:LoaderContext=null, param2:Boolean=false, param3:Boolean=false)
        {
            if (param1 == null)
            {
                this._context = new LoaderContext();
                this._context.applicationDomain = ApplicationDomain.currentDomain;
            }
            else
            {
                this._context = param1;
            };
            this.var_2648 = param2;
            this._debug = param3;
            this.var_2549 = 0;
            this.var_2551 = new Loader();
            this.var_2551.contentLoaderInfo.addEventListener(Event.INIT, this.loadEventHandler);
            this.var_2551.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadEventHandler);
            this.var_2551.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.loadEventHandler);
            this.var_2551.contentLoaderInfo.addEventListener(Event.UNLOAD, this.loadEventHandler);
            this.var_2551.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.loadEventHandler);
            this.var_2551.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.loadEventHandler);
            this.var_2551.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadEventHandler);
            super();
        }

        protected static function parseNameFromUrl(param1:String):String
        {
            var _loc2_:int;
            _loc2_ = param1.indexOf("?", 0);
            if (_loc2_ > -1)
            {
                param1 = param1.slice(0, _loc2_);
            };
            _loc2_ = param1.lastIndexOf(".");
            if (_loc2_ > -1)
            {
                param1 = param1.slice(0, _loc2_);
            };
            _loc2_ = param1.lastIndexOf("/");
            if (_loc2_ > -1)
            {
                param1 = param1.slice((_loc2_ + 1), param1.length);
            };
            return (param1);
        }

        protected static function queue(param1:LibraryLoader):void
        {
            if (var_269)
            {
                if (var_271.indexOf(param1) == -1)
                {
                    var_271.push(param1);
                };
                throttle();
            }
            else
            {
                param1.var_2551.load(param1.var_273, param1._context);
            };
        }

        protected static function throttle():void
        {
            var _loc1_:LibraryLoader;
            var _loc2_:int;
            if (var_269)
            {
                _loc2_ = (var_272.length - 1);
                while (_loc2_ > -1)
                {
                    _loc1_ = (var_272[_loc2_] as LibraryLoader);
                    if (((_loc1_) && ((_loc1_.ready) || (_loc1_.disposed))))
                    {
                        var_272.splice(_loc2_, 1);
                    };
                    _loc2_--;
                };
                while (((var_272.length < var_270) && (var_271.length > 0)))
                {
                    _loc1_ = (var_271.shift() as LibraryLoader);
                    if (((!(_loc1_.ready)) && (!(_loc1_.disposed))))
                    {
                        var_272.push(_loc1_);
                        _loc1_.var_2551.load(_loc1_.var_273, _loc1_._context);
                    };
                };
            };
        }


        public function get url():String
        {
            return ((this.var_273) ? this.var_273.url : null);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get ready():Boolean
        {
            return (this.var_2645);
        }

        public function get status():int
        {
            return (this.var_2549);
        }

        public function get domain():ApplicationDomain
        {
            return (this.var_2551.contentLoaderInfo.applicationDomain);
        }

        public function get request():URLRequest
        {
            return (this.var_273);
        }

        public function get resource():Class
        {
            return (this.var_2559);
        }

        public function get manifest():XML
        {
            return (this._manifest);
        }

        public function get bytesTotal():uint
        {
            return (this.var_2551.contentLoaderInfo.bytesTotal);
        }

        public function get bytesLoaded():uint
        {
            return (this.var_2551.contentLoaderInfo.bytesLoaded);
        }

        public function get elapsedTime():uint
        {
            return ((this.var_2645) ? (this.var_2646 - this.var_2647) : (getTimer() - this.var_2647));
        }

        public function get paused():Boolean
        {
            return (this.var_2648);
        }

        protected function get content():DisplayObject
        {
            return (this.var_2551.content);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_DISPOSE, this.var_2549, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
                try
                {
                    this.var_2551.close();
                }
                catch(e:Error)
                {
                };
                try
                {
                    this.var_2551.unload();
                }
                catch(e:Error)
                {
                };
                this.var_2551 = null;
                this._context = null;
                this.var_2559 = null;
                this._manifest = null;
                super.dispose();
            };
        }

        public function load(param1:URLRequest, param2:int=5):void
        {
            this.var_273 = param1;
            this._name = parseNameFromUrl(this.var_273.url);
            this.var_2645 = false;
            this.var_2652 = param2;
            ErrorReportStorage.addDebugData("Library url", ("Library url " + param1.url));
            ErrorReportStorage.addDebugData("Library name", ("Library name " + this._name));
            if (!this.var_2648)
            {
                this.var_2648 = true;
                this.final();
            };
        }

        public function final():void
        {
            if (((this.var_2648) && (!(_disposed))))
            {
                this.var_2648 = false;
                if (((!(this.var_2645)) && (this.var_273)))
                {
                    this.var_2646 = -1;
                    this.var_2647 = getTimer();
                    queue(this);
                };
            };
        }

        protected function retry():Boolean
        {
            if ((((!(this.var_2645)) && (!(_disposed))) && (this.var_2652 > 0)))
            {
                try
                {
                    this.var_2551.close();
                    this.var_2551.unload();
                }
                catch(e:Error)
                {
                };
                this.addRequestCounterToUrlRequest(this.var_273, (var_268 - this.var_2652));
                if (this.var_2654)
                {
                    this.var_273.requestHeaders.push(new URLRequestHeader("pragma", "no-cache"));
                    this.var_273.requestHeaders.push(new URLRequestHeader("Cache-Control", "no-cache"));
                    this.var_2654 = false;
                };
                this.var_2652--;
                this.var_2649 = 0;
                this.var_2551.load(this.var_273, this._context);
                return (true);
            };
            return (false);
        }

        public function hasDefinition(name:String):Boolean
        {
            var result:Boolean;
            try
            {
                result = this.var_2551.contentLoaderInfo.applicationDomain.hasDefinition(name);
            }
            catch(e:Error)
            {
            };
            return (result);
        }

        public function getDefinition(name:String):Object
        {
            var result:Object;
            try
            {
                if (this.var_2551.contentLoaderInfo.applicationDomain.hasDefinition(name))
                {
                    result = this.var_2551.contentLoaderInfo.applicationDomain.getDefinition(name);
                };
            }
            catch(e:Error)
            {
            };
            return (result);
        }

        protected function loadEventHandler(param1:Event):void
        {
            var _loc2_:Timer;
            switch (param1.type)
            {
                case Event.INIT:
                    this.debug((('Load event INIT for file "' + this.url) + '"'));
                    this.var_2649 = (this.var_2649 | LibraryLoader.var_2642);
                    break;
                case Event.COMPLETE:
                    this.debug((('Load event COMPLETE for file "' + this.url) + '"'));
                    this.var_2649 = (this.var_2649 | LibraryLoader.var_2641);
                    break;
                case Event.ENTER_FRAME:
                    break;
                case HTTPStatusEvent.HTTP_STATUS:
                    this.var_2549 = HTTPStatusEvent(param1).status;
                    this.debug((((("Load event STATUS " + this.var_2549) + ' for file "') + this.url) + '"'));
                    break;
                case Event.UNLOAD:
                    this.debug((('Load event UNLOAD for file "' + this.url) + '"'));
                    dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_UNLOAD, this.var_2549, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
                    break;
                case ProgressEvent.PROGRESS:
                    this.debug(((((('Load event PROGRESS for file "' + this.url) + '"  bytes: ') + this.bytesLoaded) + "/") + this.bytesTotal));
                    dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this.var_2549, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
                    break;
                case IOErrorEvent.IO_ERROR:
                    this.debug((('Load event IO ERROR for file "' + this.url) + '"'));
                    if (!this.handleHttpStatus(this.var_2549))
                    {
                        this.var_2646 = getTimer();
                        this.failure((('IO Error, send or load operation failed for file "' + this.url) + '"'));
                        this.removeEventListeners();
                    };
                    break;
                case SecurityErrorEvent.SECURITY_ERROR:
                    this.var_2646 = getTimer();
                    this.failure((('Security Error, security violation with file "' + this.url) + '"'));
                    this.removeEventListeners();
                    break;
                case TimerEvent.TIMER:
                    _loc2_ = (TimerEvent(param1).target as Timer);
                    _loc2_.removeEventListener(TimerEvent.TIMER, this.loadEventHandler);
                    _loc2_.stop();
                    if (!_disposed)
                    {
                        this.var_2649 = LibraryLoader.var_1304;
                        this.loadEventHandler(new Event(Event.COMPLETE));
                    };
                    return;
                default:
                    Logger.log((("LibraryLoader::loadEventHandler(" + param1) + ")"));
            };
            if (this.var_2649 == LibraryLoader.var_2644)
            {
                if (this.analyzeLibrary())
                {
                    this.var_2649 = (this.var_2649 | LibraryLoader.var_2643);
                };
            };
            if (this.var_2649 == LibraryLoader.var_1304)
            {
                if (this.prepareLibrary())
                {
                    this.var_2645 = true;
                    this.var_2646 = getTimer();
                    this.removeEventListeners();
                    throttle();
                    dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.var_2549, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
                    dispatchEvent(new Event(LIBRARY_LOADER_FINALIZE));
                };
            };
        }

        protected function analyzeLibrary():Boolean
        {
            var _loc1_:MovieClip;
            var _loc2_:FrameLabel;
            var _loc3_:Array;
            var _loc4_:uint;
            this.debug((((('Analyzing library "' + this._name) + '", content ') + ((this.content is MovieClip) ? "is" : "is not")) + " a MovieClip"));
            this.debug(((("\tBytes loaded: " + this.var_2551.contentLoaderInfo.bytesLoaded) + "/") + this.var_2551.contentLoaderInfo.bytesTotal));
            if ((this.content is MovieClip))
            {
                _loc1_ = (this.content as MovieClip);
                _loc3_ = _loc1_.currentLabels;
                this.debug((((((('\tLibrary "' + this._name) + '" is in frame ') + _loc1_.currentFrame) + "(") + _loc1_.currentLabel) + ")"));
                if (_loc3_.length > 1)
                {
                    _loc4_ = 0;
                    while (_loc4_ < _loc3_.length)
                    {
                        _loc2_ = (_loc3_[_loc4_] as FrameLabel);
                        if (_loc2_.name == this._name)
                        {
                            if (_loc2_.frame != _loc1_.currentFrame)
                            {
                                _loc1_.addEventListener(Event.ENTER_FRAME, this.loadEventHandler);
                                return (false);
                            };
                        };
                        _loc4_++;
                    };
                };
            };
            return (true);
        }

        protected function prepareLibrary():Boolean
        {
            var xmlClass:Class;
            this.debug((('Preparing library "' + this._name) + '"'));
            this.var_2559 = (this.getDefinition(this._name) as Class);
            if (this.var_2559 == null)
            {
                if (!this.retry())
                {
                    this.failure((((('Failed to find resource class "' + this._name) + '" from library ') + this.var_273.url) + "!"));
                };
                return (false);
            };
            var result:Boolean = true;
            try
            {
                xmlClass = (this.var_2559.manifest as Class);
                if (xmlClass == null)
                {
                    return (false);
                };
            }
            catch(e:Error)
            {
                if (!retry())
                {
                    failure((("Failed to find embedded manifest.xml from library " + var_273.url) + "!"));
                };
                result = false;
            };
            if (!result)
            {
                return (false);
            };
            var bytes:ByteArray = (new (xmlClass)() as ByteArray);
            try
            {
                this._manifest = new XML(bytes.readUTFBytes(bytes.length));
            }
            catch(e:Error)
            {
                if (!retry())
                {
                    failure(((("Failed to extract manifest.xml from library " + _name) + "!\n") + e.message));
                };
                result = false;
            };
            return (result);
        }

        protected function handleHttpStatus(param1:int):Boolean
        {
            if (((param1 == 0) || (param1 >= 400)))
            {
                if (this.retry())
                {
                    return (true);
                };
                this.failure((((("HTTP Error " + param1) + ' "') + this.var_2551.contentLoaderInfo.url) + '"'));
                this.removeEventListeners();
            };
            return (false);
        }

        protected function addRequestCounterToUrlRequest(param1:URLRequest, param2:int):void
        {
            var _loc9_:int;
            var _loc10_:String;
            if (((param1.url == null) || (param1.url == "")))
            {
                return;
            };
            var _loc3_:Array = param1.url.split("?");
            var _loc4_:String = _loc3_[0];
            var _loc5_:String = ((_loc3_.length > 1) ? _loc3_[1] : "");
            var _loc6_:String = "counterparameter";
            var _loc7_:Array = _loc5_.split("&");
            var _loc8_:Boolean;
            _loc9_ = 0;
            while (_loc9_ < _loc7_.length)
            {
                _loc10_ = _loc7_[_loc9_];
                if (_loc10_.indexOf((_loc6_ + "=")) >= 0)
                {
                    _loc10_ = ((_loc6_ + "=") + param2.toString());
                    _loc7_[_loc9_] = _loc10_;
                    _loc8_ = true;
                    break;
                };
                _loc9_++;
            };
            if (!_loc8_)
            {
                _loc7_.push(((_loc6_ + "=") + param2));
            };
            _loc9_ = 0;
            while (_loc9_ < _loc7_.length)
            {
                _loc4_ = (_loc4_ + (((_loc9_ == 0) ? "?" : "&") + _loc7_[_loc9_]));
                _loc9_++;
            };
            param1.url = _loc4_;
        }

        protected function removeEventListeners():void
        {
            if (this.var_2551)
            {
                if (this.var_2551.content != null)
                {
                    this.var_2551.content.removeEventListener(Event.ENTER_FRAME, this.loadEventHandler);
                };
                this.var_2551.contentLoaderInfo.removeEventListener(Event.INIT, this.loadEventHandler);
                this.var_2551.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loadEventHandler);
                this.var_2551.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.loadEventHandler);
                this.var_2551.contentLoaderInfo.removeEventListener(Event.UNLOAD, this.loadEventHandler);
                this.var_2551.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.loadEventHandler);
                this.var_2551.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loadEventHandler);
                this.var_2551.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadEventHandler);
            };
        }

        protected function debug(param1:String):void
        {
            Core.debug(param1);
            this.var_2651 = param1;
            if (this._debug)
            {
                dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_DEBUG, this.var_2549, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
            };
        }

        protected function failure(param1:String):void
        {
            Core.warning(param1);
            this.var_2650 = param1;
            throttle();
            dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.var_2549, this.bytesTotal, this.bytesLoaded, this.elapsedTime));
            dispatchEvent(new Event(LIBRARY_LOADER_FINALIZE));
        }

        public function getLastDebugMessage():String
        {
            return (this.var_2651);
        }

        public function getLastErrorMessage():String
        {
            return (this.var_2650);
        }


    }
}