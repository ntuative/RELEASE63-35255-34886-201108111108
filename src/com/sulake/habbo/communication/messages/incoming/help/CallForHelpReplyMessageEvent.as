package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpReplyMessageParser;

    public class CallForHelpReplyMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CallForHelpReplyMessageEvent(param1:Function)
        {
            super(param1, CallForHelpReplyMessageParser);
        }

        public function getParser():CallForHelpReplyMessageParser
        {
            return (var_334 as CallForHelpReplyMessageParser);
        }


    }
}