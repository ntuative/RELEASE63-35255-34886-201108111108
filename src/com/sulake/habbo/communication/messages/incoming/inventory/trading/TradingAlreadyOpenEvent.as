package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAlreadyOpenParser;

    public class TradingAlreadyOpenEvent extends MessageEvent 
    {

        public function TradingAlreadyOpenEvent(param1:Function, param2:Class)
        {
            super(param1, param2);
        }

        public function getParser():TradingAlreadyOpenParser
        {
            return (var_334 as TradingAlreadyOpenParser);
        }


    }
}