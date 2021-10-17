package com.sulake.habbo.ui.widget.events
{
    import flash.events.Event;

    public class RoomWidgetUpdateEvent extends Event 
    {

        public static const var_2249:String = "RWUE_EVENT_TEST";

        public function RoomWidgetUpdateEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

    }
}