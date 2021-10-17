package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetFurniActionMessage extends RoomWidgetMessage 
    {

        public static const var_2297:String = "RWFUAM_ROTATE";
        public static const var_1174:String = "RWFAM_MOVE";
        public static const var_2298:String = "RWFAM_PICKUP";
        public static const var_2299:String = "RWFAM_USE";
        public static const var_1608:String = "RWFAM_OPEN_WELCOME_GIFT";
        public static const var_2300:String = "RWFAM_SAVE_STUFF_DATA";

        private var _furniId:int = 0;
        private var var_5379:int = 0;
        private var var_5380:String;

        public function RoomWidgetFurniActionMessage(param1:String, param2:int, param3:int, param4:String=null)
        {
            super(param1);
            this._furniId = param2;
            this.var_5379 = param3;
            this.var_5380 = param4;
        }

        public function get furniId():int
        {
            return (this._furniId);
        }

        public function get furniCategory():int
        {
            return (this.var_5379);
        }

        public function get objectData():String
        {
            return (this.var_5380);
        }


    }
}