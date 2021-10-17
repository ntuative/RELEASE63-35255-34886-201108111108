package com.hurlant.crypto.prng
{
    import com.hurlant.crypto.symmetric.IStreamCipher;
    import flash.utils.ByteArray;
    import com.hurlant.util.Memory;

    public class ARC4 implements IPRNG, IStreamCipher 
    {

        private const psize:uint = 0x0100;

        private var i:int = 0;
        private var j:int = 0;
        private var S:ByteArray;

        public function ARC4(param1:ByteArray=null)
        {
            this.S = new ByteArray();
            if (param1)
            {
                this.init(param1);
            };
        }

        public function getPoolSize():uint
        {
            return (this.psize);
        }

        public function init(param1:ByteArray):void
        {
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:int;
            _loc2_ = 0;
            while (_loc2_ < 0x0100)
            {
                this.S[_loc2_] = _loc2_;
                _loc2_++;
            };
            _loc3_ = 0;
            _loc2_ = 0;
            while (_loc2_ < 0x0100)
            {
                _loc3_ = (((_loc3_ + this.S[_loc2_]) + param1[(_loc2_ % param1.length)]) & 0xFF);
                _loc4_ = this.S[_loc2_];
                this.S[_loc2_] = this.S[_loc3_];
                this.S[_loc3_] = _loc4_;
                _loc2_++;
            };
            this.i = 0;
            this.j = 0;
        }

        public function next():uint
        {
            var _loc1_:int;
            this.i = ((this.i + 1) & 0xFF);
            this.j = ((this.j + this.S[this.i]) & 0xFF);
            _loc1_ = this.S[this.i];
            this.S[this.i] = this.S[this.j];
            this.S[this.j] = _loc1_;
            return (this.S[((_loc1_ + this.S[this.i]) & 0xFF)]);
        }

        public function getBlockSize():uint
        {
            return (1);
        }

        public function encrypt(param1:ByteArray):void
        {
            var _loc2_:uint;
            while (_loc2_ < param1.length)
            {
                var _loc3_:* = _loc2_++;
                param1[_loc3_] = (param1[_loc3_] ^ this.next());
            };
        }

        public function decrypt(param1:ByteArray):void
        {
            this.encrypt(param1);
        }

        public function dispose():void
        {
            var _loc1_:uint;
            if (this.S != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.S.length)
                {
                    this.S[_loc1_] = (Math.random() * 0x0100);
                    _loc1_++;
                };
                this.S.length = 0;
                this.S = null;
            };
            this.i = 0;
            this.j = 0;
            Memory.gc();
        }

        public function toString():String
        {
            return ("rc4");
        }


    }
}