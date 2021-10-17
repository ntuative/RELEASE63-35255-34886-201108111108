package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChangeEmailMessage extends RoomWidgetMessage 
    {

        public static const var_2252:String = "rwcem_change_email";

        private var var_3634:String;

        public function RoomWidgetChangeEmailMessage(param1:String)
        {
            super(var_2252);
            this.var_3634 = param1;
        }

        public function get newEmail():String
        {
            return (this.var_3634);
        }


    }
}