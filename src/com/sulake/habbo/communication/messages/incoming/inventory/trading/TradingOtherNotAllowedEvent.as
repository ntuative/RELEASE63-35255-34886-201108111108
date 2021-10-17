package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOtherNotAllowedParser;

    public class TradingOtherNotAllowedEvent extends MessageEvent 
    {

        public function TradingOtherNotAllowedEvent(param1:Function, param2:Class)
        {
            super(param1, param2);
        }

        public function getParser():TradingOtherNotAllowedParser
        {
            return (var_334 as TradingOtherNotAllowedParser);
        }


    }
}