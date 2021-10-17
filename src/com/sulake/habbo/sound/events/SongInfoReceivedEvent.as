package com.sulake.habbo.sound.events
{
    import flash.events.Event;

    public class SongInfoReceivedEvent extends Event 
    {

        public static const var_982:String = "SIR_TRAX_SONG_INFO_RECEIVED";

        private var _id:int;

        public function SongInfoReceivedEvent(param1:String, param2:int, param3:Boolean=false, param4:Boolean=false)
        {
            super(param1, param3, param4);
            this._id = param2;
        }

        public function get id():int
        {
            return (this._id);
        }


    }
}