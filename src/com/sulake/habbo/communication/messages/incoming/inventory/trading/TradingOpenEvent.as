package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOpenParser;

    public class TradingOpenEvent extends MessageEvent 
    {

        public function TradingOpenEvent(param1:Function, param2:Class)
        {
            super(param1, param2);
        }

        public function get userID():int
        {
            return (this.getParser().userID);
        }

        public function get userCanTrade():Boolean
        {
            return (this.getParser().userCanTrade);
        }

        public function get otherUserID():int
        {
            return (this.getParser().otherUserID);
        }

        public function get otherUserCanTrade():Boolean
        {
            return (this.getParser().otherUserCanTrade);
        }

        public function getParser():TradingOpenParser
        {
            return (var_334 as TradingOpenParser);
        }


    }
}