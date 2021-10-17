package com.sulake.habbo.communication.messages.incoming.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.poll.PollOfferParser;

    public class PollOfferEvent extends MessageEvent implements IMessageEvent 
    {

        public function PollOfferEvent(param1:Function)
        {
            super(param1, PollOfferParser);
        }

        public function getParser():PollOfferParser
        {
            return (var_334 as PollOfferParser);
        }


    }
}