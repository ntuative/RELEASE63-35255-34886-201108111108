package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.AcceptBuddyResultMessageParser;

    public class AcceptBuddyResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function AcceptBuddyResultEvent(param1:Function)
        {
            super(param1, AcceptBuddyResultMessageParser);
        }

        public function getParser():AcceptBuddyResultMessageParser
        {
            return (this.var_334 as AcceptBuddyResultMessageParser);
        }


    }
}