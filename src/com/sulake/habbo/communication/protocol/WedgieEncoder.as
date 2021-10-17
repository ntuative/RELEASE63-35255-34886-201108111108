package com.sulake.habbo.communication.protocol
{
    import com.sulake.core.communication.protocol.IProtocolEncoder;
    import flash.utils.ByteArray;
    import com.sulake.core.communication.util.Short;
    import com.sulake.habbo.communication.enum.HabboProtocolOption;

    public class WedgieEncoder implements IProtocolEncoder 
    {

        private static const WEDGIE_BYTE_MASK:uint = 64;


        public function dispose():void
        {
        }

        public function encode(param1:int, param2:Array, param3:int=-1):ByteArray
        {
            var _loc5_:Object;
            var _loc6_:uint;
            var _loc7_:ByteArray;
            var _loc4_:ByteArray = new ByteArray();
            _loc4_.writeByte((WEDGIE_BYTE_MASK | (param1 >> 6)));
            _loc4_.writeByte((WEDGIE_BYTE_MASK | (0x3F & param1)));
            for each (_loc5_ in param2)
            {
                if ((_loc5_ is String))
                {
                    this.writeString(_loc4_, (_loc5_ as String), param3);
                }
                else
                {
                    if ((_loc5_ is int))
                    {
                        this.writeWedgieInt(_loc4_, (_loc5_ as int), param3);
                    }
                    else
                    {
                        if ((_loc5_ is Boolean))
                        {
                            this.writeBoolean(_loc4_, (_loc5_ as Boolean), param3);
                        }
                        else
                        {
                            if ((_loc5_ is Short))
                            {
                                this.writeShort(_loc4_, (_loc5_ as Short), param3);
                            };
                        };
                    };
                };
            };
            _loc6_ = _loc4_.length;
            _loc7_ = new ByteArray();
            _loc7_.writeByte((WEDGIE_BYTE_MASK | (_loc6_ >> 12)));
            _loc7_.writeByte((WEDGIE_BYTE_MASK | (_loc6_ >> 6)));
            _loc7_.writeByte((WEDGIE_BYTE_MASK | (0x3F & _loc6_)));
            _loc7_.writeBytes(_loc4_);
            return (_loc7_);
        }

        private function writeWedgieInt(param1:ByteArray, param2:int, param3:int=-1):void
        {
            var _loc4_:ByteArray = new ByteArray();
            var _loc5_:Boolean = ((param2 < 0) ? true : false);
            var _loc6_:int = ((param2 < 0) ? 4 : 0);
            param2 = Math.abs(param2);
            var _loc7_:uint = 1;
            var _loc8_:ByteArray = new ByteArray();
            _loc8_.writeByte((0x40 | (param2 & 0x03)));
            param2 = (param2 >>> 2);
            while (param2 != 0)
            {
                _loc7_++;
                _loc8_.writeByte((0x40 | (param2 & 0x3F)));
                param2 = (param2 >>> 6);
            };
            _loc8_.position = 0;
            var _loc9_:uint = _loc8_.readByte();
            _loc8_.position = 0;
            _loc8_.writeByte(((_loc9_ | (_loc7_ << 3)) | _loc6_));
            param1.writeBytes(_loc8_);
        }

        private function writeString(param1:ByteArray, param2:String, param3:int=-1):void
        {
            var _loc5_:uint;
            var _loc4_:ByteArray = new ByteArray();
            _loc4_.writeUTFBytes(param2);
            if (param3 != HabboProtocolOption.OLD_STYLE)
            {
                _loc5_ = _loc4_.length;
                param1.writeByte((WEDGIE_BYTE_MASK | (_loc5_ >> 6)));
                param1.writeByte((WEDGIE_BYTE_MASK | (0x3F & _loc5_)));
            };
            param1.writeBytes(_loc4_);
        }

        private function writeBoolean(param1:ByteArray, param2:Boolean, param3:int=-1):void
        {
            param1.writeByte((0x40 | (int(param2) & 0x3F)));
        }

        private function writeShort(param1:ByteArray, param2:Short, param3:int=-1):void
        {
            var _loc4_:int = param2.value;
            param1.writeByte((WEDGIE_BYTE_MASK | (_loc4_ >> 6)));
            param1.writeByte((WEDGIE_BYTE_MASK | (0x3F & _loc4_)));
        }


    }
}