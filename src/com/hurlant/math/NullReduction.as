package com.hurlant.math
{
    use namespace bi_internal;

    public class NullReduction implements IReduction 
    {


        public function revert(param1:BigInteger):BigInteger
        {
            return (param1);
        }

        public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger):void
        {
            param1.multiplyTo(param2, param3);
        }

        public function sqrTo(param1:BigInteger, param2:BigInteger):void
        {
            param1.squareTo(param2);
        }

        public function convert(param1:BigInteger):BigInteger
        {
            return (param1);
        }

        public function reduce(param1:BigInteger):void
        {
        }


    }
}