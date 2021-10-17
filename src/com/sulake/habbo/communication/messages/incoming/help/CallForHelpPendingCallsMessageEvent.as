package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpPendingCallsMessageParser;

    public class CallForHelpPendingCallsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CallForHelpPendingCallsMessageEvent(param1:Function)
        {
            super(param1, CallForHelpPendingCallsMessageParser);
        }

        public function getParser():CallForHelpPendingCallsMessageParser
        {
            return (var_334 as CallForHelpPendingCallsMessageParser);
        }


    }
}