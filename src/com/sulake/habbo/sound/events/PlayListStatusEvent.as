package com.sulake.habbo.sound.events
{
    import flash.events.Event;

    public class PlayListStatusEvent extends Event 
    {

        public static const var_1580:String = "PLUE_PLAY_LIST_UPDATED";
        public static const var_1581:String = "PLUE_PLAY_LIST_FULL";

        public function PlayListStatusEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

    }
}