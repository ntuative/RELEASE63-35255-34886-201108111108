package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqCategoriesMessageParser;

    public class FaqCategoriesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqCategoriesMessageEvent(param1:Function)
        {
            super(param1, FaqCategoriesMessageParser);
        }

        public function getParser():FaqCategoriesMessageParser
        {
            return (var_334 as FaqCategoriesMessageParser);
        }


    }
}