package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IFrameWindow;

    public class SimpleAlertView extends AlertView 
    {

        private var _text:String;

        public function SimpleAlertView(param1:HabboNavigator, param2:String, param3:String)
        {
            super(param1, "nav_simple_alert", param2);
            this._text = param3;
        }

        override internal function setupAlertWindow(param1:IFrameWindow):void
        {
            var _loc2_:IWindowContainer = param1.content;
            ITextWindow(_loc2_.findChildByName("body_text")).text = this._text;
            var _loc3_:IWindow = _loc2_.findChildByName("ok");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onOk);
            };
            param1.tags.push("SimpleAlertView");
        }

        private function onOk(param1:WindowMouseEvent):void
        {
            dispose();
        }


    }
}