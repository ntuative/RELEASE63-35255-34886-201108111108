package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetUserActionMessage extends RoomWidgetMessage 
    {

        public static const var_2288:String = "RWUAM_WHISPER_USER";
        public static const var_2289:String = "RWUAM_IGNORE_USER";
        public static const var_2290:String = "RWUAM_UNIGNORE_USER";
        public static const var_2291:String = "RWUAM_KICK_USER";
        public static const var_2292:String = "RWUAM_BAN_USER";
        public static const var_2286:String = "RWUAM_SEND_FRIEND_REQUEST";
        public static const var_2287:String = "RWUAM_RESPECT_USER";
        public static const var_2293:String = "RWUAM_GIVE_RIGHTS";
        public static const var_2294:String = "RWUAM_TAKE_RIGHTS";
        public static const var_2295:String = "RWUAM_START_TRADING";
        public static const var_2296:String = "RWUAM_OPEN_HOME_PAGE";
        public static const var_2304:String = "RWUAM_KICK_BOT";
        public static const var_2305:String = "RWUAM_REPORT";
        public static const var_2306:String = "RWUAM_PICKUP_PET";
        public static const var_2307:String = "RWUAM_TRAIN_PET";
        public static const var_2310:String = " RWUAM_RESPECT_PET";
        public static const var_1708:String = "RWUAM_REQUEST_PET_UPDATE";
        public static const var_2284:String = "RWUAM_START_NAME_CHANGE";

        private var _userId:int = 0;

        public function RoomWidgetUserActionMessage(param1:String, param2:int=0)
        {
            super(param1);
            this._userId = param2;
        }

        public function get userId():int
        {
            return (this._userId);
        }


    }
}