package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssuePickFailedMessageParser;

    public class IssuePickFailedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IssuePickFailedMessageEvent(param1:Function)
        {
            super(param1, IssuePickFailedMessageParser);
        }

        public function getParser():IssuePickFailedMessageParser
        {
            return (var_334 as IssuePickFailedMessageParser);
        }


    }
}