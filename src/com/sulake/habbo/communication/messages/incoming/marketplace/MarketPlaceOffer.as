package com.sulake.habbo.communication.messages.incoming.marketplace
{
    public class MarketPlaceOffer 
    {

        private var var_3082:int;
        private var _furniId:int;
        private var var_3128:int;
        private var var_3129:String;
        private var var_3084:int;
        private var var_2549:int;
        private var var_3131:int = -1;
        private var var_3108:int;
        private var var_3132:int;

        public function MarketPlaceOffer(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:int, param9:int=-1)
        {
            this.var_3082 = param1;
            this._furniId = param2;
            this.var_3128 = param3;
            this.var_3129 = param4;
            this.var_3084 = param5;
            this.var_2549 = param6;
            this.var_3131 = param7;
            this.var_3108 = param8;
            this.var_3132 = param9;
        }

        public function get offerId():int
        {
            return (this.var_3082);
        }

        public function get furniId():int
        {
            return (this._furniId);
        }

        public function get furniType():int
        {
            return (this.var_3128);
        }

        public function get stuffData():String
        {
            return (this.var_3129);
        }

        public function get price():int
        {
            return (this.var_3084);
        }

        public function get status():int
        {
            return (this.var_2549);
        }

        public function get timeLeftMinutes():int
        {
            return (this.var_3131);
        }

        public function get averagePrice():int
        {
            return (this.var_3108);
        }

        public function get offerCount():int
        {
            return (this.var_3132);
        }


    }
}