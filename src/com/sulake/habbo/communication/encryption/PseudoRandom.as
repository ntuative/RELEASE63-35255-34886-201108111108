package com.sulake.habbo.communication.encryption
{
    public class PseudoRandom 
    {

        private static const var_1765:int = 19979;
        private static const var_1766:int = 5;

        private var seed:int;
        private var modulus:int;

        public function PseudoRandom(param1:int, param2:int):void
        {
            this.seed = param1;
            this.modulus = param2;
        }

        public function nextInt():int
        {
            var _loc1_:int = (Math.abs(((var_1765 * this.seed) + var_1766)) % this.modulus);
            this.seed = _loc1_;
            return (_loc1_);
        }


    }
}