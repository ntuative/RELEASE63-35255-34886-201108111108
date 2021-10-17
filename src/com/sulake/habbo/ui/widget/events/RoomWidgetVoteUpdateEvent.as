package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetVoteUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_369:String = "RWPUE_VOTE_QUESTION";
        public static const var_370:String = "RWPUE_VOTE_RESULT";

        private var var_3783:String;
        private var var_3784:Array;
        private var var_3785:Array;
        private var var_3786:int;

        public function RoomWidgetVoteUpdateEvent(param1:String, param2:String, param3:Array, param4:Array=null, param5:int=0, param6:Boolean=false, param7:Boolean=false)
        {
            super(param1, param6, param7);
            this.var_3783 = param2;
            this.var_3784 = param3;
            this.var_3785 = param4;
            if (this.var_3785 == null)
            {
                this.var_3785 = [];
            };
            this.var_3786 = param5;
        }

        public function get question():String
        {
            return (this.var_3783);
        }

        public function get choices():Array
        {
            return (this.var_3784.slice());
        }

        public function get votes():Array
        {
            return (this.var_3785.slice());
        }

        public function get totalVotes():int
        {
            return (this.var_3786);
        }


    }
}