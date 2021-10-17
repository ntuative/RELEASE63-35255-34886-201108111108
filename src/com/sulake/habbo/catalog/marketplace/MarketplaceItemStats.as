package com.sulake.habbo.catalog.marketplace
{
    public class MarketplaceItemStats 
    {

        private var var_3108:int;
        private var var_3109:int;
        private var var_3110:int;
        private var _dayOffsets:Array;
        private var var_3111:Array;
        private var var_3112:Array;
        private var var_3113:int;
        private var var_3114:int;


        public function get averagePrice():int
        {
            return (this.var_3108);
        }

        public function get offerCount():int
        {
            return (this.var_3109);
        }

        public function get historyLength():int
        {
            return (this.var_3110);
        }

        public function get dayOffsets():Array
        {
            return (this._dayOffsets);
        }

        public function get averagePrices():Array
        {
            return (this.var_3111);
        }

        public function get soldAmounts():Array
        {
            return (this.var_3112);
        }

        public function get furniTypeId():int
        {
            return (this.var_3113);
        }

        public function get furniCategoryId():int
        {
            return (this.var_3114);
        }

        public function set averagePrice(param1:int):void
        {
            this.var_3108 = param1;
        }

        public function set offerCount(param1:int):void
        {
            this.var_3109 = param1;
        }

        public function set historyLength(param1:int):void
        {
            this.var_3110 = param1;
        }

        public function set dayOffsets(param1:Array):void
        {
            this._dayOffsets = param1.slice();
        }

        public function set averagePrices(param1:Array):void
        {
            this.var_3111 = param1.slice();
        }

        public function set soldAmounts(param1:Array):void
        {
            this.var_3112 = param1.slice();
        }

        public function set furniTypeId(param1:int):void
        {
            this.var_3113 = param1;
        }

        public function set furniCategoryId(param1:int):void
        {
            this.var_3114 = param1;
        }


    }
}