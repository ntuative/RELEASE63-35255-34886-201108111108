package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChangeMottoMessage extends RoomWidgetMessage 
    {

        public static const var_2311:String = "RWVM_CHANGE_MOTTO_MESSAGE";

        private var var_3402:String;

        public function RoomWidgetChangeMottoMessage(param1:String)
        {
            super(var_2311);
            this.var_3402 = param1;
        }

        public function get motto():String
        {
            return (this.var_3402);
        }


    }
}