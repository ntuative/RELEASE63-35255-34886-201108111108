package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionErrorMessageEvent extends RoomSessionEvent 
    {

        public static const var_355:String = "RSEME_DOOR_OTHER_DELETED";
        public static const var_354:String = "RSEME_DOOR_NOT_INSTALLED";
        public static const var_351:String = "RSEME_CANT_TRADE_STUFF";
        public static const var_352:String = "RSEME_INVALID_ITEM_LOC";
        public static const var_353:String = "RSEME_CANT_SET_NOT_OWNER";
        public static const var_359:String = "RSEME_MAX_STICKIES";
        public static const var_356:String = "RSEME_MAX_FURNITURE";
        public static const var_357:String = "RSEME_MAX_QUEUE";
        public static const var_358:String = "RSEME_MAX_SOUND";
        public static const var_360:String = "RSEME_KICKED";
        public static const var_362:String = "RSEME_GUIDE_BUSY";
        public static const var_361:String = "RSEME_GUIDE_EXISTS";
        public static const var_363:String = "RSEME_PETS_FORBIDDEN_IN_HOTEL";
        public static const var_364:String = "RSEME_PETS_FORBIDDEN_IN_FLAT";
        public static const var_365:String = "RSEME_MAX_PETS";
        public static const var_366:String = "RSEME_NO_FREE_TILES_FOR_PET";
        public static const var_367:String = "RSEME_SELECTED_TILE_NOT_FREE_FOR_PET";

        private var _message:String;

        public function RoomSessionErrorMessageEvent(param1:String, param2:IRoomSession, param3:String=null, param4:Boolean=false, param5:Boolean=false)
        {
            super(param1, param2, param4, param5);
            this._message = param3;
        }

        public function get message():String
        {
            return (this._message);
        }


    }
}