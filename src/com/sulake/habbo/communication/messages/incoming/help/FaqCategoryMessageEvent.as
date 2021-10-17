package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqCategoryMessageParser;

    public class FaqCategoryMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqCategoryMessageEvent(param1:Function)
        {
            super(param1, FaqCategoryMessageParser);
        }

        public function getParser():FaqCategoryMessageParser
        {
            return (var_334 as FaqCategoryMessageParser);
        }


    }
}