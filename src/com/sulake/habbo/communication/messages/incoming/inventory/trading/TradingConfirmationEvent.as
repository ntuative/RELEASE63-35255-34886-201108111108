package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingConfirmationParser;

    public class TradingConfirmationEvent extends MessageEvent 
    {

        public function TradingConfirmationEvent(param1:Function, param2:Class)
        {
            super(param1, param2);
        }

        public function getParser():TradingConfirmationParser
        {
            return (var_334 as TradingConfirmationParser);
        }


    }
}