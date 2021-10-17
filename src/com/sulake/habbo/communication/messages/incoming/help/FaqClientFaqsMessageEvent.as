package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqClientFaqsMessageParser;

    public class FaqClientFaqsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqClientFaqsMessageEvent(param1:Function)
        {
            super(param1, FaqClientFaqsMessageParser);
        }

        public function getParser():FaqClientFaqsMessageParser
        {
            return (var_334 as FaqClientFaqsMessageParser);
        }


    }
}