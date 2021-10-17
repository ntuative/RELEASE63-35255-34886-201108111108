package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetFloodControlEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1642:String = "RWFCE_FLOOD_CONTROL";

        private var var_3802:int = 0;

        public function RoomWidgetFloodControlEvent(param1:int)
        {
            super(var_1642, false, false);
            this.var_3802 = param1;
        }

        public function get seconds():int
        {
            return (this.var_3802);
        }


    }
}