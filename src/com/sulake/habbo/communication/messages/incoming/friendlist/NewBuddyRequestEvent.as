package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewBuddyRequestMessageParser;

    public class NewBuddyRequestEvent extends MessageEvent implements IMessageEvent 
    {

        public function NewBuddyRequestEvent(param1:Function)
        {
            super(param1, NewBuddyRequestMessageParser);
        }

        public function getParser():NewBuddyRequestMessageParser
        {
            return (this.var_334 as NewBuddyRequestMessageParser);
        }


    }
}