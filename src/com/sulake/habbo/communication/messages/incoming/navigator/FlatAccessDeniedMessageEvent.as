package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;

    public class FlatAccessDeniedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatAccessDeniedMessageEvent(param1:Function)
        {
            super(param1, FlatAccessDeniedMessageParser);
        }

        public function getParser():FlatAccessDeniedMessageParser
        {
            return (var_334 as FlatAccessDeniedMessageParser);
        }


    }
}