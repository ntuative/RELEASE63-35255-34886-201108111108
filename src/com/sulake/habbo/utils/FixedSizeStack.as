package com.sulake.habbo.utils
{
    public class FixedSizeStack 
    {

        private var _data:Array = [];
        private var var_5489:int = 0;
        private var _index:int = 0;

        public function FixedSizeStack(param1:int)
        {
            this.var_5489 = param1;
        }

        public function reset():void
        {
            this._data = [];
            this._index = 0;
        }

        public function addValue(param1:int):void
        {
            if (this._data.length < this.var_5489)
            {
                this._data.push(param1);
            }
            else
            {
                this._data[this._index] = param1;
            };
            this._index = ((this._index + 1) % this.var_5489);
        }

        public function getMax():int
        {
            var _loc1_:int = int.MIN_VALUE;
            var _loc2_:int;
            while (_loc2_ < this.var_5489)
            {
                if (this._data[_loc2_] > _loc1_)
                {
                    _loc1_ = this._data[_loc2_];
                };
                _loc2_++;
            };
            return (_loc1_);
        }

        public function getMin():int
        {
            var _loc1_:int = int.MAX_VALUE;
            var _loc2_:int;
            while (_loc2_ < this.var_5489)
            {
                if (this._data[_loc2_] < _loc1_)
                {
                    _loc1_ = this._data[_loc2_];
                };
                _loc2_++;
            };
            return (_loc1_);
        }


    }
}