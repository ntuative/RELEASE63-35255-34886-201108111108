package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceBuyOfferResultParser implements IMessageParser 
    {

        private var _result:int;
        private var var_3725:int = -1;
        private var var_3726:int = -1;
        private var var_3727:int = -1;


        public function get result():int
        {
            return (this._result);
        }

        public function get offerId():int
        {
            return (this.var_3725);
        }

        public function get newPrice():int
        {
            return (this.var_3726);
        }

        public function get requestedOfferId():int
        {
            return (this.var_3727);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._result = param1.readInteger();
            this.var_3725 = param1.readInteger();
            this.var_3726 = param1.readInteger();
            this.var_3727 = param1.readInteger();
            return (true);
        }


    }
}