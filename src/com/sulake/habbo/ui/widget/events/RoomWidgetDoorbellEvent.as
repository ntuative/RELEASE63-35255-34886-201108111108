package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDoorbellEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1636:String = "RWDE_RINGING";
        public static const var_344:String = "RWDE_REJECTED";
        public static const var_345:String = "RWDE_ACCEPTED";

        private var _userName:String = "";
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function RoomWidgetDoorbellEvent(param1:String, param2:String, param3:Boolean=false, param4:Boolean=false)
        {
            super(param1, param3, param4);
            this._userName = param2;
        }

        public function get userName():String
        {
            return (this._userName);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }


    }
}