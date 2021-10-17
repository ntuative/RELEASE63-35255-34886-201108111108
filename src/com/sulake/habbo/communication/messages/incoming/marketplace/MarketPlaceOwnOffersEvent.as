package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOwnOffersParser;

    public class MarketPlaceOwnOffersEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketPlaceOwnOffersEvent(param1:Function)
        {
            super(param1, MarketPlaceOwnOffersParser);
        }

        public function getParser():MarketPlaceOwnOffersParser
        {
            return (var_334 as MarketPlaceOwnOffersParser);
        }


    }
}