package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceCanMakeOfferResultParser implements IMessageParser 
    {

        private var _tokenCount:int;
        private var _result:int;


        public function get tokenCount():int
        {
            return (this._tokenCount);
        }

        public function get resultCode():int
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
            this._tokenCount = param1.readInteger();
            return (true);
        }


    }
}