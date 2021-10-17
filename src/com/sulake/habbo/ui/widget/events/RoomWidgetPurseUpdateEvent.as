package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPurseUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_140:String = "RWPUE_CREDIT_BALANCE";
        public static const var_142:String = "RWPUE_PIXEL_BALANCE";
        public static const var_144:String = "RWPUE_SHELL_BALANCE";

        private var var_3143:int;

        public function RoomWidgetPurseUpdateEvent(param1:String, param2:int, param3:Boolean=false, param4:Boolean=false)
        {
            super(param1, param3, param4);
            this.var_3143 = param2;
        }

        public function get balance():int
        {
            return (this.var_3143);
        }


    }
}