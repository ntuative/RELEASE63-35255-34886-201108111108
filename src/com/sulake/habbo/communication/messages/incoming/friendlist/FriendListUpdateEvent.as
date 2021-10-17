package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;

    public class FriendListUpdateEvent extends MessageEvent implements IMessageEvent 
    {

        public function FriendListUpdateEvent(param1:Function)
        {
            super(param1, FriendListUpdateMessageParser);
        }

        public function getParser():FriendListUpdateMessageParser
        {
            return (this.var_334 as FriendListUpdateMessageParser);
        }


    }
}