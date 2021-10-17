package com.sulake.habbo.communication.messages.incoming.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.poll.PollContentsParser;

    public class PollContentsEvent extends MessageEvent implements IMessageEvent 
    {

        public function PollContentsEvent(param1:Function)
        {
            super(param1, PollContentsParser);
        }

        public function getParser():PollContentsParser
        {
            return (var_334 as PollContentsParser);
        }


    }
}