package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FindFriendsProcessResultMessageParser implements IMessageParser 
    {

        private var var_3658:Boolean;


        public function get success():Boolean
        {
            return (this.var_3658);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3658 = param1.readBoolean();
            return (true);
        }


    }
}