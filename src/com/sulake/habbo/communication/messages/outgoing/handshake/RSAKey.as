package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.hurlant.math.BigInteger;
    import com.hurlant.util.Memory;
    import flash.utils.ByteArray;
    import com.hurlant.crypto.prng.Random;
    import com.sulake.habbo.communication.messages.outgoing.handshake.*;

    internal class RSAKey 
    {

        public var e:int;
        public var n:BigInteger;
        public var d:BigInteger;
        public var p:BigInteger;
        public var q:BigInteger;
        public var dmp1:BigInteger;
        public var var_2433:BigInteger;
        public var var_2434:BigInteger;
        protected var var_3590:Boolean;
        protected var var_3589:Boolean;

        public function RSAKey(param1:BigInteger, param2:int, param3:BigInteger=null, param4:BigInteger=null, param5:BigInteger=null, param6:BigInteger=null, param7:BigInteger=null, param8:BigInteger=null)
        {
            this.n = param1;
            this.e = param2;
            this.d = param3;
            this.p = param4;
            this.q = param5;
            this.dmp1 = param6;
            this.var_2433 = param7;
            this.var_2434 = param8;
            this.var_3589 = ((!(this.n == null)) && (!(this.e == 0)));
            this.var_3590 = ((this.var_3589) && (!(this.d == null)));
        }

        internal static function parsePublicKey(param1:String, param2:String):RSAKey
        {
            return (new RSAKey(new BigInteger(param1, 16), parseInt(param2, 16)));
        }


        internal function getBlockSize():uint
        {
            return ((this.n.bitLength() + 7) / 8);
        }

        public function dispose():void
        {
            this.e = 0;
            this.n.dispose();
            this.n = null;
            Memory.gc();
        }

        internal function encrypt(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function=null):void
        {
            this._encrypt(this.doPublic, param1, param2, param3, param4, 2);
        }

        internal function decrypt(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function=null):void
        {
            this._decrypt(this.doPrivate2, param1, param2, param3, param4, 2);
        }

        private function _encrypt(param1:Function, param2:ByteArray, param3:ByteArray, param4:uint, param5:Function, param6:int):void
        {
            var _loc9_:BigInteger;
            var _loc10_:BigInteger;
            if (param5 == null)
            {
                param5 = this.pkcs1pad;
            };
            if (param2.position >= param2.length)
            {
                param2.position = 0;
            };
            var _loc7_:uint = this.getBlockSize();
            var _loc8_:int = (param2.position + param4);
            while (param2.position < _loc8_)
            {
                _loc9_ = new BigInteger(param5(param2, _loc8_, _loc7_, param6), _loc7_);
                _loc10_ = param1(_loc9_);
                _loc10_.toArray(param3);
            };
        }

        private function _decrypt(param1:Function, param2:ByteArray, param3:ByteArray, param4:uint, param5:Function, param6:int):void
        {
            var _loc9_:BigInteger;
            var _loc10_:BigInteger;
            var _loc11_:ByteArray;
            if (param5 == null)
            {
                param5 = this.pkcs1unpad;
            };
            if (param2.position >= param2.length)
            {
                param2.position = 0;
            };
            var _loc7_:uint = this.getBlockSize();
            var _loc8_:int = (param2.position + param4);
            while (param2.position < _loc8_)
            {
                _loc9_ = new BigInteger(param2, param4);
                _loc10_ = param1(_loc9_);
                _loc11_ = param5(_loc10_, _loc7_);
                param3.writeBytes(_loc11_);
            };
        }

        private function pkcs1pad(param1:ByteArray, param2:int, param3:uint, param4:uint=2):ByteArray
        {
            var _loc9_:int;
            var _loc5_:ByteArray = new ByteArray();
            var _loc6_:uint = param1.position;
            param2 = Math.min(param2, param1.length, ((_loc6_ + param3) - 11));
            param1.position = param2;
            var _loc7_:int = (param2 - 1);
            while (((_loc7_ >= _loc6_) && (param3 > 11)))
            {
                var _loc10_:* = --param3;
                _loc5_[_loc10_] = param1[_loc7_--];
            };
            _loc10_ = --param3;
            _loc5_[_loc10_] = 0;
            var _loc8_:Random = new Random();
            while (param3 > 2)
            {
                _loc9_ = 0;
                while (_loc9_ == 0)
                {
                    _loc9_ = ((param4 == 2) ? _loc8_.nextByte() : 0xFF);
                };
                var _loc11_:* = --param3;
                _loc5_[_loc11_] = _loc9_;
            };
            _loc11_ = --param3;
            _loc5_[_loc11_] = param4;
            var _loc12_:* = --param3;
            _loc5_[_loc12_] = 0;
            return (_loc5_);
        }

        private function pkcs1unpad(param1:BigInteger, param2:uint, param3:uint=2):ByteArray
        {
            var _loc4_:ByteArray = param1.toByteArray();
            var _loc5_:ByteArray = new ByteArray();
            _loc4_.position = 0;
            var _loc6_:int;
            while (((_loc6_ < _loc4_.length) && (_loc4_[_loc6_] == 0)))
            {
                _loc6_++;
            };
            if (((!((_loc4_.length - _loc6_) == (param2 - 1))) || (_loc4_[_loc6_] > 2)))
            {
                return (null);
            };
            _loc6_++;
            while (_loc4_[_loc6_] != 0)
            {
                if (++_loc6_ >= _loc4_.length)
                {
                    return (null);
                };
            };
            while (++_loc6_ < _loc4_.length)
            {
                _loc5_.writeByte(_loc4_[_loc6_]);
            };
            _loc5_.position = 0;
            return (_loc5_);
        }

        public function toString():String
        {
            return ("rsa");
        }

        private function doPublic(param1:BigInteger):BigInteger
        {
            return (param1.modPowInt(this.e, this.n));
        }

        private function doPrivate2(param1:BigInteger):BigInteger
        {
            if (((this.p == null) && (this.q == null)))
            {
                return (param1.modPow(this.d, this.n));
            };
            var _loc2_:BigInteger = param1.mod(this.p).modPow(this.dmp1, this.p);
            var _loc3_:BigInteger = param1.mod(this.q).modPow(this.var_2433, this.q);
            while (_loc2_.compareTo(_loc3_) < 0)
            {
                _loc2_ = _loc2_.add(this.p);
            };
            return (_loc2_.subtract(_loc3_).multiply(this.var_2434).mod(this.p).multiply(this.q).add(_loc3_));
        }

        protected function doPrivate(param1:BigInteger):BigInteger
        {
            if (((this.p == null) || (this.q == null)))
            {
                return (param1.modPow(this.d, this.n));
            };
            var _loc2_:BigInteger = param1.mod(this.p).modPow(this.dmp1, this.p);
            var _loc3_:BigInteger = param1.mod(this.q).modPow(this.var_2433, this.q);
            while (_loc2_.compareTo(_loc3_) < 0)
            {
                _loc2_ = _loc2_.add(this.p);
            };
            return (_loc2_.subtract(_loc3_).multiply(this.var_2434).mod(this.p).multiply(this.q).add(_loc3_));
        }


    }
}