package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetFriendRequestMessage extends RoomWidgetMessage 
    {

        public static const var_1595:String = "RWFRM_ACCEPT";
        public static const var_1596:String = "RWFRM_DECLINE";

        private var var_3405:int = 0;

        public function RoomWidgetFriendRequestMessage(param1:String, param2:int=0)
        {
            super(param1);
            this.var_3405 = param2;
        }

        public function get requestId():int
        {
            return (this.var_3405);
        }


    }
}