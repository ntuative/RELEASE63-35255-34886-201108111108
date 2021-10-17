package com.sulake.habbo.communication.encryption
{
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.core.communication.encryption.CryptoTools;
    import flash.utils.ByteArray;

    public class RC4_R27 extends RC4 implements IEncryption 
    {

        private static const WEDGIE_BYTE_MASK:uint = 64;
        private static const var_1767:String = "mWxFRJnGJ5T9Si0OMVvEBBm8laihXkN8GmH6fuv7ldZhLyGRRKCcGzziPYBaJom";
        private static const var_1768:int = 52;
        private static const PREMIX_STRING:String = "NV6VVFPoC7FLDlzDUri3qcOAg9cRoFOmsYR9ffDGy5P8HfF6eekX40SFSVfJ1mDb3lcpYRqdg28sp61eHkPukKbqTu1JsVEKiRavi04YtSzUsLXaYSa5BEGwg5G2OF";
        private static const var_2432:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

        private var var_3377:IEncryption;
        private var var_3378:PseudoRandom;

        public function RC4_R27(param1:IEncryption, param2:PseudoRandom)
        {
            this.var_3377 = param1;
            this.var_3378 = param2;
        }

        public static function getEncodedSize(param1:int):int
        {
            var _loc2_:int = (param1 % 3);
            switch (_loc2_)
            {
                case 0:
                    return ((param1 / 3) * 4);
                case 1:
                    return ((((param1 - 1) / 3) * 4) + 2);
                case 2:
                    return ((((param1 - 2) / 3) * 4) + 3);
            };
            return (0);
        }

        public static function getDecodedSize(param1:int):int
        {
            var _loc2_:int = (param1 % 4);
            switch (_loc2_)
            {
                case 0:
                    return ((param1 / 4) * 3);
                case 2:
                    return ((((param1 - 2) / 4) * 3) + 1);
                case 3:
                    return ((((param1 - 3) / 4) * 3) + 2);
            };
            return (0);
        }


        override public function init(param1:ByteArray):void
        {
            var _loc2_:int;
            var _loc3_:ByteArray = CryptoTools.stringToByteArray(var_1767);
            var _loc4_:int;
            while (_loc4_ < param1.length)
            {
                param1[_loc4_] = (param1[_loc4_] ^ _loc3_[_loc2_]);
                _loc2_ = ((_loc2_ >= (_loc3_.length - 1)) ? 0 : (_loc2_ + 1));
                _loc4_++;
            };
            super.init(param1);
            var _loc5_:ByteArray = CryptoTools.stringToByteArray(PREMIX_STRING);
            var _loc6_:int;
            while (_loc6_ < var_1768)
            {
                super.encipher(_loc5_, true);
                _loc6_++;
            };
        }

        override public function encipher(param1:ByteArray, param2:Boolean=false):ByteArray
        {
            var _loc3_:ByteArray;
            var _loc4_:String;
            var _loc5_:ByteArray;
            var _loc6_:int;
            var _loc7_:ByteArray;
            var _loc8_:ByteArray;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:int;
            if (this.var_3377 != null)
            {
                _loc7_ = new ByteArray();
                _loc8_ = new ByteArray();
                _loc6_ = (this.var_3378.nextInt() % 5);
                _loc9_ = (param1.length - 3);
                _loc10_ = (_loc6_ + _loc9_);
                _loc11_ = RC4_R27.getEncodedSize(_loc10_);
                _loc7_.writeByte(Math.floor((Math.random() * 0xFF)));
                _loc7_.writeByte((WEDGIE_BYTE_MASK | ((_loc11_ >> 12) & 0x3F)));
                _loc7_.writeByte((WEDGIE_BYTE_MASK | ((_loc11_ >> 6) & 0x3F)));
                _loc7_.writeByte((WEDGIE_BYTE_MASK | (0x3F & _loc11_)));
                _loc5_ = this.var_3377.encipher(_loc7_, true);
                while (_loc8_.length < _loc6_)
                {
                    _loc8_.writeByte(Math.floor((Math.random() * 0xFF)));
                };
                _loc8_.position = _loc6_;
                _loc8_.writeBytes(param1, 3);
                _loc3_ = super.encipher(_loc8_, true);
                _loc4_ = Base64.encodeBytes(_loc3_, 0, false);
                _loc5_.position = _loc5_.length;
                _loc5_.writeBytes(CryptoTools.stringToByteArray(_loc4_));
            }
            else
            {
                _loc3_ = super.encipher(param1, true);
                _loc4_ = Base64.encodeBytes(_loc3_, 0, false);
                _loc5_ = CryptoTools.stringToByteArray(_loc4_);
            };
            return (_loc5_);
        }

        override protected function customHackScramble(param1:Array, param2:int, param3:int):void
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:int;
            if ((param2 & 0x3F) == 63)
            {
                _loc4_ = (((param2 + 67) * 297) & 0xFF);
                _loc5_ = ((param3 + param1[_loc4_]) & 0xFF);
                _loc6_ = param1[_loc4_];
                param1[_loc4_] = param1[_loc5_];
                param1[_loc5_] = _loc6_;
            };
        }


    }
}