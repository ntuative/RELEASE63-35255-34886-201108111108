package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpPendingCallsDeletedMessageParser;

    public class CallForHelpPendingCallsDeletedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CallForHelpPendingCallsDeletedMessageEvent(param1:Function)
        {
            super(param1, CallForHelpPendingCallsDeletedMessageParser);
        }

        public function getParser():CallForHelpPendingCallsDeletedMessageParser
        {
            return (var_334 as CallForHelpPendingCallsDeletedMessageParser);
        }


    }
}