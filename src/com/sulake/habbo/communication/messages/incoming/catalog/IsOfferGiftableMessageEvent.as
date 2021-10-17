package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.IsOfferGiftableMessageParser;

    public class IsOfferGiftableMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IsOfferGiftableMessageEvent(param1:Function)
        {
            super(param1, IsOfferGiftableMessageParser);
        }

        public function getParser():IsOfferGiftableMessageParser
        {
            return (this.var_334 as IsOfferGiftableMessageParser);
        }


    }
}