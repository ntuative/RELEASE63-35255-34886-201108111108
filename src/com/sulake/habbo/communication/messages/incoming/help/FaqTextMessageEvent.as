package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqTextMessageParser;

    public class FaqTextMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqTextMessageEvent(param1:Function)
        {
            super(param1, FaqTextMessageParser);
        }

        public function getParser():FaqTextMessageParser
        {
            return (var_334 as FaqTextMessageParser);
        }


    }
}