package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionVoteEvent extends RoomSessionEvent 
    {

        public static const var_369:String = "RSPE_VOTE_QUESTION";
        public static const var_370:String = "RSPE_VOTE_RESULT";

        private var var_3783:String = "";
        private var var_3784:Array = [];
        private var var_3785:Array = [];
        private var var_3786:int = 0;

        public function RoomSessionVoteEvent(param1:String, param2:IRoomSession, param3:String, param4:Array, param5:Array=null, param6:int=0, param7:Boolean=false, param8:Boolean=false)
        {
            super(param1, param2, param7, param8);
            this.var_3783 = param3;
            this.var_3784 = param4;
            this.var_3785 = param5;
            if (this.var_3785 == null)
            {
                this.var_3785 = [];
            };
            this.var_3786 = param6;
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