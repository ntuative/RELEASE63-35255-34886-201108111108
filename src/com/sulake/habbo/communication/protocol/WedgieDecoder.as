package com.sulake.habbo.communication.protocol
{
    import com.sulake.core.communication.protocol.IProtocolDecoder;
    import flash.utils.ByteArray;
    import com.sulake.core.communication.util.Short;

    public class WedgieDecoder implements IProtocolDecoder 
    {


        public function dispose():void
        {
        }

        public function getID(param1:ByteArray):int
        {
            var _loc3_:uint;
            var _loc4_:uint;
            var _loc2_:int = -1;
            param1.position = 0;
            if (param1.bytesAvailable)
            {
                _loc3_ = this.readWedgieByte(param1);
                _loc4_ = this.readWedgieByte(param1);
                _loc2_ = ((_loc3_ << 6) | _loc4_);
            };
            return (_loc2_);
        }

        public function decode(param1:ByteArray):void
        {
            param1.position = 0;
            Logger.log("Wedgie Decoder");
            Logger.log(("Data Length: " + param1.length));
            Logger.log(("Data: " + param1));
        }

        public function readString(param1:ByteArray):String
        {
            var _loc3_:uint;
            var _loc2_:ByteArray = new ByteArray();
            while (param1.bytesAvailable)
            {
                _loc3_ = param1.readUnsignedByte();
                if (_loc3_ == WedgieProtocol.var_1416) break;
                _loc2_.writeByte(_loc3_);
            };
            _loc2_.position = 0;
            return (_loc2_.readUTFBytes(_loc2_.length));
        }

        public function readInteger(param1:ByteArray):int
        {
            var _loc6_:uint;
            var _loc7_:int;
            var _loc8_:uint;
            var _loc2_:uint;
            if (param1.bytesAvailable)
            {
                _loc2_ = this.readWedgieByte(param1);
            }
            else
            {
                return (0);
            };
            var _loc3_:* = (((_loc2_ & 0x38) >> 3) | 0x00);
            var _loc4_:Boolean = (((_loc2_ & 0x04) == 4) ? true : false);
            var _loc5_:* = (_loc2_ & 0x03);
            if (param1.bytesAvailable)
            {
                _loc6_ = 2;
                _loc7_ = 1;
                while (_loc7_ < _loc3_)
                {
                    _loc8_ = this.readWedgieByte(param1);
                    _loc5_ = ((_loc8_ << _loc6_) | _loc5_);
                    _loc6_ = (_loc6_ + 6);
                    _loc7_++;
                };
            };
            if (_loc4_)
            {
                _loc5_ = (_loc5_ * -1);
            };
            return (_loc5_);
        }

        public function readBoolean(param1:ByteArray):Boolean
        {
            var _loc2_:int = this.readInteger(param1);
            return (Boolean(_loc2_));
        }

        public function readShort(param1:ByteArray):Short
        {
            var _loc2_:int = this.readInteger(param1);
            return (Short(_loc2_));
        }

        private function readWedgieByte(param1:ByteArray):uint
        {
            return (param1.readUnsignedByte() & 0x3F);
        }


    }
}