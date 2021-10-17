package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAcceptParser;

    public class TradingAcceptEvent extends MessageEvent 
    {

        public function TradingAcceptEvent(param1:Function, param2:Class)
        {
            super(param1, param2);
        }

        public function get userID():int
        {
            return (this.getParser().userID);
        }

        public function get userAccepts():Boolean
        {
            return (this.getParser().userAccepts);
        }

        public function getParser():TradingAcceptParser
        {
            return (var_334 as TradingAcceptParser);
        }


    }
}