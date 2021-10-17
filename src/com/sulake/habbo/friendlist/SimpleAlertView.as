package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class SimpleAlertView extends AlertView 
    {

        private var _text:String;

        public function SimpleAlertView(param1:HabboFriendList, param2:String, param3:String)
        {
            super(param1, "simple_alert", param2);
            this._text = param3;
        }

        override internal function setupContent(param1:IWindowContainer):void
        {
            ITextWindow(param1.findChildByName("body_text")).text = this._text;
            param1.findChildByName("ok").procedure = this.onOk;
        }

        private function onOk(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            dispose();
        }


    }
}