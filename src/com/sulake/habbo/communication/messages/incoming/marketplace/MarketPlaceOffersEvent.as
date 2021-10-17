package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOffersParser;

    public class MarketPlaceOffersEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketPlaceOffersEvent(param1:Function)
        {
            super(param1, MarketPlaceOffersParser);
        }

        public function getParser():MarketPlaceOffersParser
        {
            return (var_334 as MarketPlaceOffersParser);
        }


    }
}