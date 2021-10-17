package com.sulake.habbo.window.utils
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IButtonWindow;

    public class AlertDialogWithLink extends AlertDialog implements IAlertDialogWithLink 
    {

        protected var var_5494:String = "";
        protected var var_5493:String = "";

        public function AlertDialogWithLink(param1:IHabboWindowManager, param2:XML, param3:String, param4:String, param5:String, param6:String, param7:uint, param8:Function)
        {
            super(param1, param2, param3, param4, param7, param8);
            this.linkTitle = param5;
            this.linkUrl = param6;
        }

        override protected function dialogEventProc(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "_alert_button_link":
                        HabboWebTools.navigateToURL(this.var_5493, "_empty");
                        return;
                };
            };
            super.dialogEventProc(param1, param2);
        }

        public function set linkTitle(param1:String):void
        {
            this.var_5494 = param1;
            if (_window)
            {
                IButtonWindow(_window.findChildByTag("LINK")).caption = this.var_5494;
            };
        }

        public function get linkTitle():String
        {
            return (this.var_5494);
        }

        public function set linkUrl(param1:String):void
        {
            this.var_5493 = param1;
        }

        public function get linkUrl():String
        {
            return (this.var_5493);
        }


    }
}