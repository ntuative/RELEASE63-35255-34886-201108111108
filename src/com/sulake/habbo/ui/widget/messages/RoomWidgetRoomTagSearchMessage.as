package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetRoomTagSearchMessage extends RoomWidgetMessage 
    {

        public static const var_2301:String = "RWRTSM_ROOM_TAG_SEARCH";

        private var var_3491:String = "";

        public function RoomWidgetRoomTagSearchMessage(param1:String)
        {
            super(var_2301);
            this.var_3491 = param1;
        }

        public function get tag():String
        {
            return (this.var_3491);
        }


    }
}