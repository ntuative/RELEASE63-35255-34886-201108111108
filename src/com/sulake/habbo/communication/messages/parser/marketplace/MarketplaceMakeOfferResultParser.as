package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceMakeOfferResultParser implements IMessageParser 
    {

        private var _result:int;


        public function get result():int
        {
            return (this._result);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._result = param1.readInteger();
            return (true);
        }


    }
}