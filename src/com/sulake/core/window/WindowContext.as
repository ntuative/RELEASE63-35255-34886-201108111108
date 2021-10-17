package com.sulake.core.window
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.utils.IEventQueue;
    import com.sulake.core.window.utils.IEventProcessor;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import flash.display.Stage;
    import com.sulake.core.window.utils.EventProcessorState;
    import __AS3__.vec.Vector;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import flash.display.DisplayObjectContainer;
    import com.sulake.core.window.services.IInternalWindowServices;
    import com.sulake.core.window.utils.IWindowParser;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.components.SubstituteParentController;
    import com.sulake.core.window.services.ServiceManager;
    import com.sulake.core.window.utils.WindowParser;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.DesktopController;
    import flash.events.Event;
    import com.sulake.core.window.utils.MouseEventQueue;
    import com.sulake.core.window.utils.MouseEventProcessor;
    import com.sulake.core.window.utils.tablet.TabletEventQueue;
    import com.sulake.core.window.utils.tablet.TabletEventProcessor;
    import com.sulake.core.window.graphics.IGraphicContextHost;
    import flash.display.DisplayObject;
    import com.sulake.core.localization.ILocalizable;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.enum.WindowState;
    import __AS3__.vec.*;

    public class WindowContext implements IWindowContext, IDisposable, IUpdateReceiver 
    {

        public static const var_1104:uint = 0;
        public static const var_1105:uint = 1;
        public static const var_1106:int = 0;
        public static const var_1107:int = 1;
        public static const var_1108:int = 2;
        public static const var_1109:int = 3;
        public static const var_1110:int = 4;
        public static const var_1111:int = 5;
        public static var var_245:IEventQueue;
        private static var var_1114:IEventProcessor;
        private static var var_1113:uint = var_1104;//0
        private static var var_1112:IWindowRenderer;
        private static var stage:Stage;

        private var var_2808:EventProcessorState;
        private var var_2807:Vector.<IWindowContextStateListener>;
        protected var _localization:ICoreLocalizationManager;
        protected var var_2806:DisplayObjectContainer;
        protected var var_2809:Boolean = true;
        protected var var_259:Error;
        protected var var_2810:int = -1;
        protected var var_2811:IInternalWindowServices;
        protected var var_2812:IWindowParser;
        protected var var_2813:IWindowFactory;
        protected var var_1981:IDesktopWindow;
        protected var var_2814:SubstituteParentController;
        private var _disposed:Boolean = false;
        private var var_2687:Boolean = false;
        private var var_2815:Boolean = false;
        private var _name:String;

        public function WindowContext(param1:String, param2:IWindowRenderer, param3:IWindowFactory, param4:ICoreLocalizationManager, param5:DisplayObjectContainer, param6:Rectangle)
        {
            this._name = param1;
            var_1112 = param2;
            this._localization = param4;
            this.var_2806 = param5;
            this.var_2811 = new ServiceManager(this, param5);
            this.var_2813 = param3;
            this.var_2812 = new WindowParser(this);
            this.var_2807 = new Vector.<IWindowContextStateListener>();
            if (!stage)
            {
                if ((this.var_2806 is Stage))
                {
                    stage = (this.var_2806 as Stage);
                }
                else
                {
                    if (this.var_2806.stage)
                    {
                        stage = this.var_2806.stage;
                    };
                };
            };
            Classes.init();
            if (param6 == null)
            {
                param6 = new Rectangle(0, 0, 800, 600);
            };
            this.var_1981 = new DesktopController(("_CONTEXT_DESKTOP_" + this._name), this, param6);
            this.var_1981.limits.maxWidth = param6.width;
            this.var_1981.limits.maxHeight = param6.height;
            this.var_2806.addChild(this.var_1981.getDisplayObject());
            this.var_2806.doubleClickEnabled = true;
            this.var_2806.addEventListener(Event.RESIZE, this.stageResizedHandler);
            this.var_2808 = new EventProcessorState(var_1112, this.var_1981, this.var_1981, null, this.var_2807);
            inputMode = var_1104;
            this.var_2814 = new SubstituteParentController(this);
        }

        public static function get inputMode():uint
        {
            return (var_1113);
        }

        public static function set inputMode(value:uint):void
        {
            if (var_245)
            {
                if ((var_245 is IDisposable))
                {
                    IDisposable(var_245).dispose();
                };
            };
            if (var_1114)
            {
                if ((var_1114 is IDisposable))
                {
                    IDisposable(var_1114).dispose();
                };
            };
            switch (value)
            {
                case var_1104:
                    var_245 = new MouseEventQueue(stage);
                    var_1114 = new MouseEventProcessor();
                    try
                    {
                    }
                    catch(e:Error)
                    {
                    };
                    return;
                case var_1105:
                    var_245 = new TabletEventQueue(stage);
                    var_1114 = new TabletEventProcessor();
                    try
                    {
                    }
                    catch(e:Error)
                    {
                    };
                    return;
                default:
                    inputMode = var_1104;
                    throw (new Error(("Unknown input mode " + value)));
            };
        }


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this.var_2806.removeEventListener(Event.RESIZE, this.stageResizedHandler);
                this.var_2806.removeChild((IGraphicContextHost(this.var_1981).getGraphicContext(true) as DisplayObject));
                this.var_1981.destroy();
                this.var_1981 = null;
                this.var_2814.destroy();
                this.var_2814 = null;
                if ((this.var_2811 is IDisposable))
                {
                    IDisposable(this.var_2811).dispose();
                };
                this.var_2811 = null;
                this.var_2812.dispose();
                this.var_2812 = null;
                var_1112 = null;
            };
        }

        public function getLastError():Error
        {
            return (this.var_259);
        }

        public function getLastErrorCode():int
        {
            return (this.var_2810);
        }

        public function handleError(param1:int, param2:Error):void
        {
            this.var_259 = param2;
            this.var_2810 = param1;
            if (this.var_2809)
            {
                throw (param2);
            };
        }

        public function flushError():void
        {
            this.var_259 = null;
            this.var_2810 = -1;
        }

        public function getWindowServices():IInternalWindowServices
        {
            return (this.var_2811);
        }

        public function getWindowParser():IWindowParser
        {
            return (this.var_2812);
        }

        public function getWindowFactory():IWindowFactory
        {
            return (this.var_2813);
        }

        public function getDesktopWindow():IDesktopWindow
        {
            return (this.var_1981);
        }

        public function findWindowByName(param1:String):IWindow
        {
            return (this.var_1981.findChildByName(param1));
        }

        public function registerLocalizationListener(param1:String, param2:IWindow):void
        {
            this._localization.registerListener(param1, (param2 as ILocalizable));
        }

        public function removeLocalizationListener(param1:String, param2:IWindow):void
        {
            this._localization.removeListener(param1, (param2 as ILocalizable));
        }

        public function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:Rectangle, param7:Function, param8:IWindow, param9:uint, param10:Array=null, param11:Array=null):IWindow
        {
            var _loc12_:IWindow;
            var _loc13_:Class = Classes.getWindowClassByType(param3);
            if (_loc13_ == null)
            {
                this.handleError(WindowContext.var_1110, new Error((('Failed to solve implementation for window "' + param1) + '"!')));
                return (null);
            };
            if (param8 == null)
            {
                if ((param5 & WindowParam.var_713))
                {
                    param8 = this.var_2814;
                };
            };
            _loc12_ = new _loc13_(param1, param3, param4, param5, this, param6, ((param8 != null) ? param8 : this.var_1981), param7, param10, param11, param9);
            if (((param2) && (param2.length)))
            {
                _loc12_.caption = param2;
            };
            return (_loc12_);
        }

        public function destroy(param1:IWindow):Boolean
        {
            if (param1 == this.var_1981)
            {
                this.var_1981 = null;
            };
            if (param1.state != WindowState.var_1115)
            {
                param1.destroy();
            };
            return (true);
        }

        public function invalidate(param1:IWindow, param2:Rectangle, param3:uint):void
        {
            if (!this.disposed)
            {
                var_1112.addToRenderQueue(WindowController(param1), param2, param3);
            };
        }

        public function update(param1:uint):void
        {
            this.var_2687 = true;
            if (this.var_259)
            {
                throw (this.var_259);
            };
            var_1114.process(this.var_2808, var_245);
            this.var_2687 = false;
        }

        public function render(param1:uint):void
        {
            this.var_2815 = true;
            var_1112.update(param1);
            this.var_2815 = false;
        }

        private function stageResizedHandler(param1:Event):void
        {
            if (((!(this.var_1981 == null)) && (!(this.var_1981.disposed))))
            {
                if ((this.var_2806 is Stage))
                {
                    this.var_1981.limits.maxWidth = Stage(this.var_2806).stageWidth;
                    this.var_1981.limits.maxHeight = Stage(this.var_2806).stageHeight;
                    this.var_1981.width = Stage(this.var_2806).stageWidth;
                    this.var_1981.height = Stage(this.var_2806).stageHeight;
                }
                else
                {
                    this.var_1981.limits.maxWidth = this.var_2806.width;
                    this.var_1981.limits.maxHeight = this.var_2806.height;
                    this.var_1981.width = this.var_2806.width;
                    this.var_1981.height = this.var_2806.height;
                };
            };
        }

        public function addMouseEventTracker(param1:IWindowContextStateListener):void
        {
            if (this.var_2807.indexOf(param1) < 0)
            {
                this.var_2807.push(param1);
            };
        }

        public function removeMouseEventTracker(param1:IWindowContextStateListener):void
        {
            var _loc2_:int = this.var_2807.indexOf(param1);
            if (_loc2_ > -1)
            {
                this.var_2807.splice(_loc2_, 1);
            };
        }


    }
}