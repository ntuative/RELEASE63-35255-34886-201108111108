package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketPlaceOffersParser implements IMessageParser 
    {

        private const var_3734:int = 500;

        private var _offers:Array;
        private var var_3123:int;


        public function flush():Boolean
        {
            this._offers = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:String;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:int;
            var _loc13_:MarketPlaceOffer;
            this._offers = new Array();
            var _loc11_:int = param1.readInteger();
            var _loc12_:int;
            while (_loc12_ < _loc11_)
            {
                _loc2_ = param1.readInteger();
                _loc3_ = param1.readInteger();
                _loc4_ = param1.readInteger();
                _loc5_ = param1.readInteger();
                _loc6_ = param1.readString();
                _loc7_ = param1.readInteger();
                _loc8_ = param1.readInteger();
                _loc9_ = param1.readInteger();
                _loc10_ = param1.readInteger();
                _loc13_ = new MarketPlaceOffer(_loc2_, _loc5_, _loc4_, _loc6_, _loc7_, _loc3_, _loc8_, _loc9_, _loc10_);
                if (_loc12_ < this.var_3734)
                {
                    this._offers.push(_loc13_);
                };
                _loc12_++;
            };
            this.var_3123 = param1.readInteger();
            return (true);
        }

        public function get offers():Array
        {
            return (this._offers);
        }

        public function get totalItemsFound():int
        {
            return (this.var_3123);
        }


    }
}