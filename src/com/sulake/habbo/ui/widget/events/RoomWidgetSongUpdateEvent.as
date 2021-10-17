package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetSongUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1706:String = "RWSUE_PLAYING_CHANGED";
        public static const var_1707:String = "RWSUE_DATA_RECEIVED";

        private var var_1932:int;
        private var _songName:String;
        private var var_5259:String;

        public function RoomWidgetSongUpdateEvent(param1:String, param2:int, param3:String, param4:String, param5:Boolean=false, param6:Boolean=false)
        {
            super(param1, param5, param6);
            this.var_1932 = param2;
            this._songName = param3;
            this.var_5259 = param4;
        }

        public function get songId():int
        {
            return (this.var_1932);
        }

        public function get songName():String
        {
            return (this._songName);
        }

        public function get songAuthor():String
        {
            return (this.var_5259);
        }


    }
}