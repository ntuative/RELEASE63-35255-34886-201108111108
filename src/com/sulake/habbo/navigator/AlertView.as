package com.sulake.habbo.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class AlertView implements IDisposable 
    {

        private static var var_1837:Dictionary = new Dictionary();

        private var _navigator:HabboNavigator;
        protected var var_4356:IFrameWindow;
        protected var var_3964:String;
        protected var _title:String;
        protected var _disposed:Boolean;

        public function AlertView(param1:HabboNavigator, param2:String, param3:String=null)
        {
            this._navigator = param1;
            this.var_3964 = param2;
            this._title = param3;
        }

        public static function findAlertView(param1:IWindow):AlertView
        {
            var _loc2_:AlertView;
            if (var_1837 != null)
            {
                for each (_loc2_ in var_1837)
                {
                    if (_loc2_.var_4356 == param1)
                    {
                        return (_loc2_);
                    };
                };
            };
            return (null);
        }


        public function show():void
        {
            var _loc1_:AlertView = (var_1837[this.var_3964] as AlertView);
            if (_loc1_ != null)
            {
                _loc1_.dispose();
            };
            this.var_4356 = this.getAlertWindow();
            if (this._title != null)
            {
                this.var_4356.caption = this._title;
            };
            this.setupAlertWindow(this.var_4356);
            var _loc2_:Rectangle = Util.getLocationRelativeTo(this.var_4356.desktop, this.var_4356.width, this.var_4356.height);
            this.var_4356.x = _loc2_.x;
            this.var_4356.y = _loc2_.y;
            var_1837[this.var_3964] = this;
            this.var_4356.activate();
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            if (var_1837[this.var_3964] == this)
            {
                var_1837[this.var_3964] = null;
            };
            this._disposed = true;
            if (this.var_4356 != null)
            {
                this.var_4356.destroy();
                this.var_4356 = null;
            };
            this._navigator = null;
        }

        internal function setupAlertWindow(param1:IFrameWindow):void
        {
        }

        internal function onClose(param1:WindowMouseEvent):void
        {
            this.dispose();
        }

        private function getAlertWindow():IFrameWindow
        {
            var _loc1_:IFrameWindow = (this._navigator.getXmlWindow(this.var_3964, 2) as IFrameWindow);
            var _loc2_:IWindow = _loc1_.findChildByTag("close");
            if (_loc2_ != null)
            {
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
            return (_loc1_);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get navigator():HabboNavigator
        {
            return (this._navigator);
        }


    }
}