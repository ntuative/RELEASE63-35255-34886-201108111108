package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNoSuchItemParser;

    public class TradingNoSuchItemEvent extends MessageEvent 
    {

        public function TradingNoSuchItemEvent(param1:Function, param2:Class)
        {
            super(param1, param2);
        }

        public function getParser():TradingNoSuchItemParser
        {
            return (var_334 as TradingNoSuchItemParser);
        }


    }
}