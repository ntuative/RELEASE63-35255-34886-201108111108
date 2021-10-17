package com.sulake.habbo.communication.messages.incoming.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.poll.VoteQuestionMessageParser;

    public class VoteQuestionMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function VoteQuestionMessageEvent(param1:Function)
        {
            super(param1, VoteQuestionMessageParser);
        }

        public function getParser():VoteQuestionMessageParser
        {
            return (var_334 as VoteQuestionMessageParser);
        }


    }
}