package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceItemStatsParser implements IMessageParser 
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

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3108 = param1.readInteger();
            this.var_3109 = param1.readInteger();
            this.var_3110 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            this._dayOffsets = [];
            this.var_3111 = [];
            this.var_3112 = [];
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this._dayOffsets.push(param1.readInteger());
                this.var_3111.push(param1.readInteger());
                this.var_3112.push(param1.readInteger());
                _loc3_++;
            };
            this.var_3114 = param1.readInteger();
            this.var_3113 = param1.readInteger();
            return (true);
        }


    }
}