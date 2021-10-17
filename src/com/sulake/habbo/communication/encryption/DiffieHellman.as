package com.sulake.habbo.communication.encryption
{
    import com.sulake.core.communication.handshake.IKeyExchange;
    import com.hurlant.math.BigInteger;
    import com.sulake.core.utils.ErrorReportStorage;

    public class DiffieHellman implements IKeyExchange 
    {

        private var var_3347:BigInteger;
        private var var_3371:BigInteger;
        private var var_3372:BigInteger;
        private var var_3373:BigInteger;
        private var var_3374:BigInteger;
        private var var_3375:BigInteger;

        public function DiffieHellman(param1:BigInteger, param2:BigInteger)
        {
            this.var_3374 = param1;
            this.var_3375 = param2;
        }

        public function init(param1:String, param2:uint=16):Boolean
        {
            ErrorReportStorage.addDebugData("DiffieHellman", ((((("Prime: " + this.var_3374.toString()) + ",generator: ") + this.var_3375.toString()) + ",secret: ") + param1));
            this.var_3347 = new BigInteger();
            this.var_3347.fromRadix(param1, param2);
            this.var_3371 = this.var_3375.modPow(this.var_3347, this.var_3374);
            return (true);
        }

        public function generateSharedKey(param1:String, param2:uint=16):String
        {
            this.var_3372 = new BigInteger();
            this.var_3372.fromRadix(param1, param2);
            this.var_3373 = this.var_3372.modPow(this.var_3347, this.var_3374);
            return (this.getSharedKey(param2));
        }

        public function getPublicKey(param1:uint=16):String
        {
            return (this.var_3371.toRadix(param1));
        }

        public function getSharedKey(param1:uint=16):String
        {
            return (this.var_3373.toRadix(param1));
        }


    }
}