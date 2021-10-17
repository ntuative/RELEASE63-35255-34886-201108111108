package com.sulake.habbo.sound.events
{
    import flash.events.Event;

    public class SongDiskInventoryReceivedEvent extends Event 
    {

        public static const SONG_DISK_INVENTORY_RECEIVED:String = "SDIR_SONG_DISK_INVENTORY_RECEIVENT_EVENT";

        public function SongDiskInventoryReceivedEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

    }
}