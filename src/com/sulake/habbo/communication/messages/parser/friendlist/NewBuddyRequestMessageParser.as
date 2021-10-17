package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NewBuddyRequestMessageParser implements IMessageParser 
    {

        private var var_3669:FriendRequestData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3669 = new FriendRequestData(param1);
            return (true);
        }

        public function get req():FriendRequestData
        {
            return (this.var_3669);
        }


    }
}