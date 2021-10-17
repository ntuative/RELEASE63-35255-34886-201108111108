package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNotOpenParser;

    public class TradingNotOpenEvent extends MessageEvent 
    {

        public function TradingNotOpenEvent(param1:Function, param2:Class)
        {
            super(param1, param2);
        }

        public function getParser():TradingNotOpenParser
        {
            return (var_334 as TradingNotOpenParser);
        }


    }
}