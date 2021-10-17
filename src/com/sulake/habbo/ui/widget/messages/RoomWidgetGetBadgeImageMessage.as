package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetGetBadgeImageMessage extends RoomWidgetMessage 
    {

        public static const var_2303:String = "RWGOI_MESSAGE_GET_BADGE_IMAGE";

        private var var_3417:String = "";

        public function RoomWidgetGetBadgeImageMessage(param1:String)
        {
            super(var_2303);
            this.var_3417 = param1;
        }

        public function get badgeId():String
        {
            return (this.var_3417);
        }


    }
}