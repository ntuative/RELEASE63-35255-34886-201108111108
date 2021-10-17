package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.BuddyRequestsMessageParser;

    public class BuddyRequestsEvent extends MessageEvent implements IMessageEvent 
    {

        public function BuddyRequestsEvent(param1:Function)
        {
            super(param1, BuddyRequestsMessageParser);
        }

        public function getParser():BuddyRequestsMessageParser
        {
            return (this.var_334 as BuddyRequestsMessageParser);
        }


    }
}