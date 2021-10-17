package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetVoteMessage extends RoomWidgetMessage 
    {

        public static const var_419:String = "RWVM_VOTE_MESSAGE";

        private var var_5388:int;

        public function RoomWidgetVoteMessage(param1:int)
        {
            super(var_419);
            this.var_5388 = param1;
        }

        public function get vote():int
        {
            return (this.var_5388);
        }


    }
}