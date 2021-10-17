package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingYouAreNotAllowedParser;

    public class TradingYouAreNotAllowedEvent extends MessageEvent 
    {

        public function TradingYouAreNotAllowedEvent(param1:Function, param2:Class)
        {
            super(param1, param2);
        }

        public function getParser():TradingYouAreNotAllowedParser
        {
            return (var_334 as TradingYouAreNotAllowedParser);
        }


    }
}