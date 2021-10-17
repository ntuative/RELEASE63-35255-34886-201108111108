package com.sulake.habbo.communication.messages.incoming.recycler
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PrizeLevelMessageData 
    {

        private var var_3180:int;
        private var var_3530:int;
        private var var_3181:Array;

        public function PrizeLevelMessageData(param1:IMessageDataWrapper)
        {
            this.var_3180 = param1.readInteger();
            this.var_3530 = param1.readInteger();
            this.var_3181 = new Array();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3181.push(new PrizeMessageData(param1));
                _loc3_++;
            };
        }

        public function get prizeLevelId():int
        {
            return (this.var_3180);
        }

        public function get probabilityDenominator():int
        {
            return (this.var_3530);
        }

        public function get prizes():Array
        {
            return (this.var_3181);
        }


    }
}