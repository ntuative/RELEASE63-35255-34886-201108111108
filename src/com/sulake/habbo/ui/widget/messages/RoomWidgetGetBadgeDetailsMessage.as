package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetGetBadgeDetailsMessage extends RoomWidgetMessage 
    {

        public static const var_2302:String = "RWGOI_MESSAGE_GET_BADGE_DETAILS";

        private var var_3581:int = 0;

        public function RoomWidgetGetBadgeDetailsMessage(param1:int)
        {
            super(var_2302);
            this.var_3581 = param1;
        }

        public function get groupId():int
        {
            return (this.var_3581);
        }


    }
}