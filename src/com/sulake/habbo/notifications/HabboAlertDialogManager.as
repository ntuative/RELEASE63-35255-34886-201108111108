package com.sulake.habbo.notifications
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class HabboAlertDialogManager 
    {

        private var _windowManager:IHabboWindowManager;
        private var _localization:IHabboLocalizationManager;

        public function HabboAlertDialogManager(param1:IHabboWindowManager, param2:IHabboLocalizationManager)
        {
            this._windowManager = param1;
            this._localization = param2;
        }

        public function dispose():void
        {
            this._windowManager = null;
            this._localization = null;
        }

        public function handleModMessage(message:String, url:String=""):void
        {
            var p:RegExp = /\\r/g;
            message = message.replace(p, "\r");
            if (url.length > 0)
            {
                this._windowManager.alertWithLink("${mod.alert.title}", message, "${mod.alert.link}", url, 0, function (param1:IAlertDialog, param2:WindowEvent):void
                {
                    param1.dispose();
                });
            }
            else
            {
                this._windowManager.alert("${mod.alert.title}", message, 0, function (param1:IAlertDialog, param2:WindowEvent):void
                {
                    param1.dispose();
                });
            };
        }

        public function handleUserBannedMessage(message:String):void
        {
            this._windowManager.alert("${mod.ban.title}", message, 0, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            });
        }

        public function handleHotelClosingMessage(minutesUntilClosing:int):void
        {
            this._localization.registerParameter("opening.hours.shutdown", "m", String(minutesUntilClosing));
            this._windowManager.alert("${opening.hours.title}", "${opening.hours.shutdown}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            });
        }

        public function handleHotelClosedMessage(openHour:int, openMinute:int, userThrownOutAtClose:Boolean):void
        {
            if (userThrownOutAtClose)
            {
                this._localization.registerParameter("opening.hours.disconnected", "h", this.getTimeZeroPadded(openHour));
                this._localization.registerParameter("opening.hours.disconnected", "m", this.getTimeZeroPadded(openMinute));
                this._windowManager.alert("${opening.hours.title}", "${opening.hours.disconnected}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                {
                    param1.dispose();
                });
            }
            else
            {
                this._localization.registerParameter("opening.hours.closed", "h", this.getTimeZeroPadded(openHour));
                this._localization.registerParameter("opening.hours.closed", "m", this.getTimeZeroPadded(openMinute));
                this._windowManager.alert("${opening.hours.title}", "${opening.hours.closed}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                {
                    param1.dispose();
                });
            };
        }

        public function handleLoginFailedHotelClosedMessage(openHour:int, openMinute:int):void
        {
            this._localization.registerParameter("opening.hours.disconnected", "h", this.getTimeZeroPadded(openHour));
            this._localization.registerParameter("opening.hours.disconnected", "m", this.getTimeZeroPadded(openMinute));
            this._windowManager.alert("${opening.hours.title}", "${opening.hours.disconnected}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            });
        }

        private function getTimeZeroPadded(param1:int):String
        {
            var _loc2_:String = ("0" + String(param1));
            return (_loc2_.substr((_loc2_.length - 2), _loc2_.length));
        }


    }
}