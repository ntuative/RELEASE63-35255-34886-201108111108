package com.sulake.habbo.navigator.events
{
    import flash.events.Event;

    public class HabboNavigatorEvent extends Event 
    {

        public static const var_46:String = "HTIE_ICON_ZOOM";

        public function HabboNavigatorEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

    }
}