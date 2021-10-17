package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDanceUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1692:String = "RWUE_DANCE";

        private var var_1206:int;

        public function RoomWidgetDanceUpdateEvent(param1:int, param2:Boolean=false, param3:Boolean=false)
        {
            super(var_1692, param2, param3);
            this.var_1206 = param1;
        }

        public function get style():int
        {
            return (this.var_1206);
        }


    }
}