package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoteResultMessageParser implements IMessageParser 
    {

        private var var_3783:String;
        private var var_3784:Array;
        private var var_3785:Array;
        private var var_3786:int;


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

        public function flush():Boolean
        {
            this.var_3783 = "";
            this.var_3784 = [];
            this.var_3785 = [];
            this.var_3786 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3783 = param1.readString();
            this.var_3784 = [];
            this.var_3785 = [];
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                param1.readInteger();
                this.var_3784.push(param1.readString());
                this.var_3785.push(param1.readInteger());
                _loc3_++;
            };
            this.var_3786 = param1.readInteger();
            return (true);
        }


    }
}