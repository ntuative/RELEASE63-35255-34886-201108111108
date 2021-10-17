package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TradingCloseParser implements IMessageParser 
    {

        private var _userId:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._userId = param1.readInteger();
            return (true);
        }

        public function get userID():int
        {
            return (this._userId);
        }


    }
}