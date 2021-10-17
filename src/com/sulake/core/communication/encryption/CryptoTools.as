package com.sulake.core.communication.encryption
{
    import flash.utils.ByteArray;

    public class CryptoTools 
    {


        public static function byteArrayToString(param1:ByteArray):String
        {
            param1.position = 0;
            var _loc2_:String = "";
            while (param1.bytesAvailable)
            {
                _loc2_ = (_loc2_ + String.fromCharCode(param1.readByte()));
            };
            return (_loc2_);
        }

        public static function stringToByteArray(param1:String):ByteArray
        {
            var _loc2_:ByteArray = new ByteArray();
            var _loc3_:int;
            while (_loc3_ < param1.length)
            {
                _loc2_.writeByte(param1.charCodeAt(_loc3_));
                _loc3_++;
            };
            _loc2_.position = 0;
            return (_loc2_);
        }

        public static function byteArrayToHexString(param1:ByteArray, param2:Boolean=false):String
        {
            var _loc4_:uint;
            var _loc5_:uint;
            var _loc6_:uint;
            param1.position = 0;
            var _loc3_:String = "";
            while (param1.bytesAvailable)
            {
                _loc4_ = param1.readUnsignedByte();
                _loc5_ = (_loc4_ >> 4);
                _loc6_ = (_loc4_ & 0x0F);
                _loc3_ = (_loc3_ + _loc5_.toString(16));
                _loc3_ = (_loc3_ + _loc6_.toString(16));
            };
            if (param2)
            {
                _loc3_ = _loc3_.toUpperCase();
            };
            return (_loc3_);
        }

        public static function hexStringToByteArray(param1:String):ByteArray
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:int;
            var _loc2_:ByteArray = new ByteArray();
            if ((param1.length % 2) != 0)
            {
                param1 = ("0" + param1);
            };
            var _loc3_:int;
            while (_loc3_ < (param1.length - 1))
            {
                _loc4_ = parseInt(param1.charAt((_loc3_ + 0)), 16);
                _loc5_ = parseInt(param1.charAt((_loc3_ + 1)), 16);
                _loc6_ = ((_loc4_ << 4) | _loc5_);
                _loc2_.writeByte(_loc6_);
                _loc3_++;
                _loc3_++;
            };
            return (_loc2_);
        }

        public static function BigIntegerToRadix(param1:ByteArray, param2:uint=16):String
        {
            return ("");
        }


    }
}