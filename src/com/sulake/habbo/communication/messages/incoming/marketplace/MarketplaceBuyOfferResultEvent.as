package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceBuyOfferResultParser;

    public class MarketplaceBuyOfferResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceBuyOfferResultEvent(param1:Function)
        {
            super(param1, MarketplaceBuyOfferResultParser);
        }

        public function getParser():MarketplaceBuyOfferResultParser
        {
            return (var_334 as MarketplaceBuyOfferResultParser);
        }


    }
}