package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupJoinFailedMessageParser implements IMessageParser 
    {

        private var var_3673:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3673 = param1.readInteger();
            return (true);
        }

        public function get reason():int
        {
            return (this.var_3673);
        }


    }
}