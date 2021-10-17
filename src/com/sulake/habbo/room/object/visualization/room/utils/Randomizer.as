package com.sulake.habbo.room.object.visualization.room.utils
{
    public class Randomizer 
    {

        public static const var_2514:int = 1;
        public static const var_2515:int = 0x1000000;
        private static var _randomizer:Randomizer = null;

        private var var_4787:int = 1;
        private var var_4788:int = 0x1000000;
        private var var_4789:int = 69069;
        private var var_4790:int = 5;


        public static function setSeed(param1:int=1):void
        {
            if (_randomizer == null)
            {
                _randomizer = new (Randomizer)();
            };
            _randomizer.seed = param1;
        }

        public static function setModulus(param1:int=0x1000000):void
        {
            if (_randomizer == null)
            {
                _randomizer = new (Randomizer)();
            };
            _randomizer.modulus = param1;
        }

        public static function getValues(param1:int, param2:int, param3:int):Array
        {
            if (_randomizer == null)
            {
                _randomizer = new (Randomizer)();
            };
            return (_randomizer.getRandomValues(param1, param2, param3));
        }

        public static function getArray(param1:int, param2:int):Array
        {
            if (_randomizer == null)
            {
                _randomizer = new (Randomizer)();
            };
            return (_randomizer.getRandomArray(param1, param2));
        }


        public function set seed(param1:int):void
        {
            this.var_4787 = param1;
        }

        public function set modulus(param1:int):void
        {
            if (param1 < 1)
            {
                param1 = 1;
            };
            this.var_4788 = param1;
        }

        public function dispose():void
        {
        }

        public function getRandomValues(param1:int, param2:int, param3:int):Array
        {
            var _loc4_:Array = [];
            var _loc5_:int;
            while (_loc5_ < param1)
            {
                _loc4_.push(this.iterateScaled(param2, (param3 - param2)));
                _loc5_++;
            };
            return (_loc4_);
        }

        public function getRandomArray(param1:int, param2:int):Array
        {
            var _loc7_:int;
            if (((param1 > param2) || (param2 > 1000)))
            {
                return (null);
            };
            var _loc3_:Array = [];
            var _loc4_:int;
            while (_loc4_ <= param2)
            {
                _loc3_.push(_loc4_);
                _loc4_++;
            };
            var _loc5_:Array = [];
            var _loc6_:int;
            while (_loc6_ < param1)
            {
                _loc7_ = this.iterateScaled(0, (_loc3_.length - 1));
                _loc5_.push(_loc3_[_loc7_]);
                _loc3_.splice(_loc7_, 1);
                _loc6_++;
            };
            return (_loc5_);
        }

        private function iterate():int
        {
            var _loc1_:int = ((this.var_4789 * this.var_4787) + this.var_4790);
            if (_loc1_ < 0)
            {
                _loc1_ = -(_loc1_);
            };
            _loc1_ = (_loc1_ % this.var_4788);
            this.var_4787 = _loc1_;
            return (_loc1_);
        }

        private function iterateScaled(param1:int, param2:int):int
        {
            var _loc3_:int = this.iterate();
            if (param2 < 1)
            {
                return (param1);
            };
            return (int((param1 + ((_loc3_ / this.var_4788) * param2))));
        }


    }
}