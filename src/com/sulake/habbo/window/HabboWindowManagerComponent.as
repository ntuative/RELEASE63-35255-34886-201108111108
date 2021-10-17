package com.sulake.habbo.window
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.window.ICoreWindowManager;
    import com.sulake.core.window.IWindowFactory;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.IWindowContextStateListener;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.graphics.ISkinContainer;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.tools.ProfilerOutput;
    import com.sulake.core.utils.profiler.ProfilerAgentTask;
    import flash.utils.Dictionary;
    import com.sulake.core.utils.FontEnum;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.components.HTMLTextController;
    import com.sulake.iid.IIDCoreLocalizationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.utils.getTimer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.graphics.SkinContainer;
    import com.sulake.core.window.graphics.WindowRenderer;
    import flash.geom.Rectangle;
    import com.sulake.core.window.WindowContext;
    import com.sulake.core.runtime.IIDProfiler;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.runtime.IProfiler;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.utils.DefaultAttStruct;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.habbo.window.utils.AlertDialog;
    import com.sulake.core.window.utils.INotify;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.window.utils.AlertDialogWithLink;
    import com.sulake.habbo.window.utils.IAlertDialogWithLink;
    import com.sulake.habbo.window.utils.ConfirmDialog;
    import com.sulake.habbo.window.utils.IConfirmDialog;
    import flash.events.Event;
    import com.sulake.habbo.window.enum.HabboWindowTrackingEvent;
    import com.sulake.core.window.utils.MouseCursorControl;
    import flash.events.MouseEvent;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.tracking.HabboErrorVariableEnum;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class HabboWindowManagerComponent extends Component implements IHabboWindowManager, ICoreWindowManager, IWindowFactory, IUpdateReceiver, IWindowContextStateListener 
    {

        private static var _instance:IHabboWindowManager;
        private static const var_243:uint = 3;
        private static const var_244:uint = 1;

        private var _localization:ICoreLocalizationManager;
        private var _windowContextArray:Array;
        private var var_2764:IWindowContext;
        private var var_2779:IWindowRenderer;
        private var _skinContainer:ISkinContainer;
        private var var_5495:Array;
        private var var_5496:IEventDispatcher;
        private var var_5497:Boolean = false;
        private var var_5498:ProfilerOutput;
        private var var_5499:ProfilerAgentTask;
        private var var_5500:ProfilerAgentTask;

        public function HabboWindowManagerComponent(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            var _loc4_:Dictionary;
            super(param1, param2, param3);
            lock();
            FontEnum.refresh();
            _instance = this;
            this.var_5496 = param1.events;
            this.var_5495 = new Array();
            _loc4_ = new Dictionary();
            _loc4_[HabboWindowType.var_218] = null;
            _loc4_[HabboWindowType.var_219] = (param3.getAssetByName("habbo_window_layout_frame_xml").content as XML);
            _loc4_[HabboWindowType.var_220] = (param3.getAssetByName("habbo_window_layout_simple_xml").content as XML);
            _loc4_[HabboWindowType.var_221] = (param3.getAssetByName("habbo_window_layout_frame_xml").content as XML);
            _loc4_[HabboWindowType.var_222] = (param3.getAssetByName("habbo_window_layout_header_xml").content as XML);
            _loc4_[HabboWindowType.var_223] = null;
            _loc4_[HabboWindowType.var_224] = (param3.getAssetByName("habbo_window_layout_scrollbar_horizontal_xml").content as XML);
            _loc4_[HabboWindowType.var_225] = null;
            _loc4_[HabboWindowType.var_157] = null;
            _loc4_[HabboWindowType.var_226] = (param3.getAssetByName("habbo_window_layout_bubble_xml").content as XML);
            _loc4_[HabboWindowType.BUTTON] = (param3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _loc4_[HabboWindowType.var_227] = (param3.getAssetByName("habbo_window_layout_button_thick_xml").content as XML);
            _loc4_[HabboWindowType.var_228] = (param3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _loc4_[HabboWindowType.var_229] = (param3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _loc4_[HabboWindowType.var_230] = (param3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _loc4_[HabboWindowType.var_231] = null;
            _loc4_[HabboWindowType.var_232] = (param3.getAssetByName("habbo_window_layout_scrollbar_vertical_xml").content as XML);
            _loc4_[HabboWindowType.var_233] = (param3.getAssetByName("habbo_window_layout_dropmenu_xml").content as XML);
            _loc4_[HabboWindowType.var_234] = (param3.getAssetByName("habbo_window_layout_dropmenu_item_xml").content as XML);
            _loc4_[HabboWindowType.var_235] = null;
            _loc4_[HabboWindowType.var_156] = null;
            _loc4_[HabboWindowType.var_236] = null;
            _loc4_[HabboWindowType.var_237] = null;
            _loc4_[HabboWindowType.var_238] = (param3.getAssetByName("habbo_window_layout_tab_button_xml").content as XML);
            _loc4_[WindowType.var_239] = (param3.getAssetByName("habbo_window_layout_badge_xml").content as XML);
            _loc4_[WindowType.var_240] = (param3.getAssetByName("habbo_window_layout_tab_context_xml").content as XML);
            _loc4_[WindowType.var_241] = (param3.getAssetByName("habbo_window_layout_tooltip_xml").content as XML);
            _loc4_[WindowType.var_242] = (param3.getAssetByName("habbo_window_layout_scaler_xml").content as XML);
            _loc4_[WindowType.WINDOW_TYPE_SCROLLABLE_ITEMLIST_VERTICAL] = (param3.getAssetByName("habbo_window_layout_scrollable_itemlist_vertical_xml").content as XML);
            this.var_5495.push(_loc4_);
            _loc4_ = new Dictionary();
            _loc4_[HabboWindowType.BUTTON] = (param3.getAssetByName("habbo_window_layout_button_black_xml").content as XML);
            _loc4_[HabboWindowType.var_222] = (param3.getAssetByName("habbo_window_layout_header_black_xml").content as XML);
            _loc4_[HabboWindowType.var_227] = (param3.getAssetByName("habbo_window_layout_button_thick_black_xml").content as XML);
            _loc4_[HabboWindowType.var_228] = (param3.getAssetByName("habbo_window_layout_button_black_xml").content as XML);
            _loc4_[HabboWindowType.var_229] = (param3.getAssetByName("habbo_window_layout_button_black_xml").content as XML);
            _loc4_[HabboWindowType.var_230] = (param3.getAssetByName("habbo_window_layout_button_black_xml").content as XML);
            _loc4_[HabboWindowType.var_233] = (param3.getAssetByName("habbo_window_layout_dropmenu_black_xml").content as XML);
            _loc4_[HabboWindowType.var_234] = (param3.getAssetByName("habbo_window_layout_dropmenu_item_black_xml").content as XML);
            _loc4_[HabboWindowType.var_238] = (param3.getAssetByName("habbo_window_layout_tab_button_black_xml").content as XML);
            this.var_5495.push(_loc4_);
            _loc4_ = new Dictionary();
            _loc4_[HabboWindowType.BUTTON] = (param3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _loc4_[HabboWindowType.var_227] = (param3.getAssetByName("habbo_window_layout_button_thick_xml").content as XML);
            _loc4_[HabboWindowType.var_228] = (param3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _loc4_[HabboWindowType.var_229] = (param3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _loc4_[HabboWindowType.var_230] = (param3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _loc4_[HabboWindowType.var_238] = (param3.getAssetByName("habbo_window_layout_tab_button_xml").content as XML);
            this.var_5495.push(_loc4_);
            _loc4_ = new Dictionary();
            _loc4_[HabboWindowType.var_219] = (param3.getAssetByName("habbo_window_layout_frame_3_xml").content as XML);
            _loc4_[HabboWindowType.var_222] = (param3.getAssetByName("habbo_window_layout_header_3_xml").content as XML);
            _loc4_[HabboWindowType.BUTTON] = (param3.getAssetByName("habbo_window_layout_button_shiny_xml").content as XML);
            _loc4_[HabboWindowType.var_227] = (param3.getAssetByName("habbo_window_layout_button_shiny_thick_xml").content as XML);
            _loc4_[WindowType.var_242] = (param3.getAssetByName("habbo_window_layout_scaler_3_xml").content as XML);
            _loc4_[HabboWindowType.var_238] = (param3.getAssetByName("habbo_window_layout_tab_button_3_xml").content as XML);
            _loc4_[WindowType.var_240] = (param3.getAssetByName("habbo_window_layout_tab_context_3_xml").content as XML);
            this.var_5495.push(_loc4_);
            _loc4_ = new Dictionary();
            _loc4_[HabboWindowType.BUTTON] = (param3.getAssetByName("habbo_window_layout_button_shiny_black_xml").content as XML);
            _loc4_[HabboWindowType.var_227] = (param3.getAssetByName("habbo_window_layout_button_shiny_thick_black_xml").content as XML);
            this.var_5495.push(_loc4_);
            _loc4_ = new Dictionary();
            _loc4_[HabboWindowType.BUTTON] = (param3.getAssetByName("habbo_window_layout_button_shiny_black_xml").content as XML);
            _loc4_[HabboWindowType.var_227] = (param3.getAssetByName("habbo_window_layout_button_shiny_thick_black_xml").content as XML);
            this.var_5495.push(_loc4_);
            HTMLTextController.defaultLinkTarget = "habboMain";
            queueInterface(new IIDCoreLocalizationManager(), this.initialize);
        }

        public static function getInstance():IHabboWindowManager
        {
            return (_instance);
        }


        private function initialize(param1:IID, param2:IUnknown):void
        {
            var _loc3_:int = getTimer();
            this._localization = (param2 as ICoreLocalizationManager);
            var _loc4_:IAsset = assets.getAssetByName("habbo_element_description_xml");
            this._skinContainer = new SkinContainer((_loc4_.content as XML), assets);
            this.var_2779 = new WindowRenderer(this._skinContainer);
            this._windowContextArray = new Array(var_243);
            var _loc5_:Rectangle = new Rectangle(0, 0, context.displayObjectContainer.stage.stageWidth, context.displayObjectContainer.stage.stageHeight);
            var _loc6_:uint;
            while (_loc6_ < var_243)
            {
                this._windowContextArray[_loc6_] = new WindowContext(("layer_" + _loc6_), this.var_2779, this, this._localization, context.displayObjectContainer, _loc5_);
                _loc6_++;
            };
            this.var_2764 = this._windowContextArray[var_244];
            this.addMouseEventTracker(this);
            unlock();
            registerUpdateReceiver(this, 0);
            queueInterface(new IIDProfiler(), this.receiveProfilerInterface);
            _loc3_ = (getTimer() - _loc3_);
            Logger.log((("initializing window framework took " + _loc3_) + "ms"));
        }

        private function onCrashTest(param1:WindowMouseEvent):void
        {
            var _loc2_:IWindow;
            Logger.log("CRASH!");
            _loc2_.background = true;
        }

        private function receiveProfilerInterface(param1:IID, param2:IUnknown):void
        {
            var _loc3_:IProfiler = (param2 as IProfiler);
            if (_loc3_ != null)
            {
                if (!this.var_5498)
                {
                    this.var_5498 = new ProfilerOutput(context, this, this.var_2779);
                };
                this.var_5498.profiler = _loc3_;
                this.var_5499 = new ProfilerAgentTask("Update", "Event processing");
                _loc3_.getProfilerAgentForReceiver(this).addSubTask(this.var_5499);
                this.var_5500 = new ProfilerAgentTask("Redraw", "Window rasterizer");
                _loc3_.getProfilerAgentForReceiver(this).addSubTask(this.var_5500);
                this.var_5497 = true;
            };
        }

        private function receiveLoggerInterface(param1:IID, param2:IUnknown):void
        {
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                removeUpdateReceiver(this);
                if (this._windowContextArray)
                {
                    while (this._windowContextArray.length > 0)
                    {
                        IDisposable(this._windowContextArray.pop()).dispose();
                    };
                };
                this._windowContextArray = null;
                if (this.var_5495)
                {
                    while (this.var_5495.length > 0)
                    {
                        this.var_5495.pop();
                    };
                };
                this.var_5495 = null;
                if (this._localization)
                {
                    this._localization.release(new IIDCoreLocalizationManager());
                    this._localization = null;
                };
                if (this.var_2779)
                {
                    this.var_2779.dispose();
                    this.var_2779 = null;
                };
                if (this._skinContainer)
                {
                    this._skinContainer.dispose();
                    this._skinContainer = null;
                };
                super.dispose();
            };
        }

        public function create(param1:String, param2:uint, param3:uint, param4:uint, param5:Rectangle, param6:Function=null, param7:String="", param8:uint=0, param9:Array=null, param10:IWindow=null, param11:Array=null):IWindow
        {
            return (this.var_2764.create(param1, param7, param2, param3, param4, param5, param6, param10, param8, param11, param9));
        }

        public function destroy(param1:IWindow):void
        {
            param1.destroy();
        }

        public function buildFromXML(param1:XML, param2:uint=1, param3:Map=null):IWindow
        {
            return (this.getWindowContext(param2).getWindowParser().parseAndConstruct(param1, null, param3));
        }

        public function windowToXMLString(param1:IWindow):String
        {
            return (this.var_2764.getWindowParser().windowToXMLString(param1));
        }

        public function getLayoutByTypeAndStyle(param1:uint, param2:uint):XML
        {
            var _loc3_:Dictionary = (this.var_5495[param2] as Dictionary);
            if (_loc3_ == null)
            {
                return (null);
            };
            var _loc4_:XML = (_loc3_[param1] as XML);
            return ((_loc4_ == null) ? (this.var_5495[0][param1] as XML) : _loc4_);
        }

        public function getDefaultsByTypeAndStyle(param1:uint, param2:uint):DefaultAttStruct
        {
            return (this._skinContainer.getDefaultAttributesByTypeAndStyle(param1, param2));
        }

        public function createWindow(param1:String, param2:String="", param3:uint=0, param4:uint=0, param5:uint=0, param6:Rectangle=null, param7:Function=null, param8:uint=0, param9:uint=1):IWindow
        {
            return (this._windowContextArray[param9].create(param1, param2, param3, param4, param5, param6, param7, null, param8, null, null));
        }

        public function removeWindow(param1:String, param2:uint=1):void
        {
            var _loc3_:IDesktopWindow = this._windowContextArray[param2].getDesktopWindow();
            var _loc4_:IWindow = _loc3_.getChildByName(param1);
            if (_loc4_ != null)
            {
                _loc4_.destroy();
            };
        }

        public function getWindowByName(param1:String, param2:uint=1):IWindow
        {
            return (this._windowContextArray[param2].getDesktopWindow().getChildByName(param1));
        }

        public function getActiveWindow(param1:uint=1):IWindow
        {
            return (this._windowContextArray[param1].getDesktopWindow().getChildAt((this.var_2764.getDesktopWindow().numChildren - 1)));
        }

        public function getWindowContext(param1:uint):IWindowContext
        {
            return (this._windowContextArray[param1]);
        }

        public function getDesktop(param1:uint):IDesktopWindow
        {
            var _loc2_:IWindowContext = this._windowContextArray[param1];
            return ((_loc2_) ? _loc2_.getDesktopWindow() : null);
        }

        public function notify(param1:String, param2:String, param3:Function, param4:uint=0):INotify
        {
            var _loc5_:IAsset = assets.getAssetByName("habbo_window_alert_xml");
            if (!_loc5_)
            {
                throw (new Error("Failed to initialize alert dialog; missing asset!"));
            };
            var _loc6_:XML = (_loc5_.content as XML);
            return (new AlertDialog(this, _loc6_, param1, param2, param4, param3));
        }

        public function alert(param1:String, param2:String, param3:uint, param4:Function):IAlertDialog
        {
            var _loc5_:IAsset = assets.getAssetByName("habbo_window_alert_xml");
            if (!_loc5_)
            {
                throw (new Error("Failed to initialize alert dialog; missing asset!"));
            };
            var _loc6_:XML = (_loc5_.content as XML);
            return (new AlertDialog(this, _loc6_, param1, param2, param3, param4));
        }

        public function alertWithLink(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:Function):IAlertDialogWithLink
        {
            var _loc7_:IAsset = assets.getAssetByName("habbo_window_alert_link_xml");
            if (!_loc7_)
            {
                throw (new Error("Failed to initialize alert dialog; missing asset!"));
            };
            var _loc8_:XML = (_loc7_.content as XML);
            return (new AlertDialogWithLink(this, _loc8_, param1, param2, param3, param4, param5, param6));
        }

        public function confirm(param1:String, param2:String, param3:uint, param4:Function):IConfirmDialog
        {
            var _loc5_:IAsset = assets.getAssetByName("habbo_window_confirm_xml");
            if (!_loc5_)
            {
                throw (new Error("Failed to initialize aleret dialog; missing asset!"));
            };
            var _loc6_:XML = (_loc5_.content as XML);
            return (new ConfirmDialog(this, _loc6_, param1, param2, param3, param4));
        }

        public function registerLocalizationParameter(param1:String, param2:String, param3:String, param4:String="%"):void
        {
            this._localization.registerParameter(param1, param2, param3, param4);
        }

        public function update(param1:uint):void
        {
            var _loc2_:int;
            if (this.var_5497)
            {
                this.var_5499.start();
            };
            if (WindowContext.var_245.length > 0)
            {
                this.var_5496.dispatchEvent(new Event(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_INPUT));
                _loc2_ = (var_243 - 1);
                while (_loc2_ >= 0)
                {
                    this._windowContextArray[_loc2_].update(param1);
                    _loc2_--;
                };
            };
            if (this.var_5497)
            {
                this.var_5499.stop();
            };
            if (this.var_5497)
            {
                this.var_5500.start();
            };
            this.var_5496.dispatchEvent(new Event(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_RENDER));
            _loc2_ = 0;
            while (_loc2_ < var_243)
            {
                this._windowContextArray[_loc2_].render(param1);
                _loc2_++;
            };
            if (this.var_5497)
            {
                this.var_5500.stop();
            };
            if (WindowContext.var_245.length > 0)
            {
                WindowContext.var_245.flush();
            };
            MouseCursorControl.change();
            this.var_5496.dispatchEvent(new Event(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_SLEEP));
        }

        public function addMouseEventTracker(param1:IWindowContextStateListener):void
        {
            var _loc2_:IWindowContext;
            for each (_loc2_ in this._windowContextArray)
            {
                _loc2_.addMouseEventTracker(param1);
            };
        }

        public function removeMouseEventTracker(param1:IWindowContextStateListener):void
        {
            var _loc2_:IWindowContext;
            for each (_loc2_ in this._windowContextArray)
            {
                _loc2_.removeMouseEventTracker(param1);
            };
        }

        public function mouseEventReceived(param1:String, param2:IWindow):void
        {
            if (param2 != null)
            {
                if (param1 == MouseEvent.CLICK)
                {
                    ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_246, new Date().getTime().toString());
                    ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_247, ((param2.name + ": ") + param2.toString()));
                }
                else
                {
                    if (param1 == MouseEvent.MOUSE_UP)
                    {
                        ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_248, new Date().getTime().toString());
                        ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_249, ((param2.name + ": ") + param2.toString()));
                    };
                };
            };
        }

        private function performTestCases():void
        {
        }


    }
}