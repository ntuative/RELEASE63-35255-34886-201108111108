package com.sulake.habbo.communication.messages.incoming.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.poll.VoteResultMessageParser;

    public class VoteResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function VoteResultMessageEvent(param1:Function)
        {
            super(param1, VoteResultMessageParser);
        }

        public function getParser():VoteResultMessageParser
        {
            return (this.var_334 as VoteResultMessageParser);
        }


    }
}