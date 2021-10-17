package com.sulake.habbo.communication.protocol
{
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.core.communication.protocol.IProtocolEncoder;
    import com.sulake.core.communication.protocol.IProtocolDecoder;
    import flash.utils.ByteArray;

    public class WedgieProtocol implements IProtocol 
    {

        public static const var_1415:uint = 1;
        public static const var_1416:uint = 2;

        private var var_3874:IProtocolEncoder;
        private var var_2594:IProtocolDecoder;

        public function WedgieProtocol()
        {
            this.var_3874 = new WedgieEncoder();
            this.var_2594 = new WedgieDecoder();
        }

        public function dispose():void
        {
            this.var_3874.dispose();
            this.var_2594.dispose();
            this.var_3874 = null;
            this.var_2594 = null;
        }

        public function get encoder():IProtocolEncoder
        {
            return (this.var_3874);
        }

        public function get decoder():IProtocolDecoder
        {
            return (this.var_2594);
        }

        public function getMessages(param1:ByteArray, param2:Array):uint
        {
            var _loc5_:uint;
            var _loc6_:int;
            param1.position = 0;
            var _loc3_:uint = param1.position;
            var _loc4_:ByteArray = new ByteArray();
            while (param1.bytesAvailable)
            {
                _loc5_ = param1.readUnsignedByte();
                if (_loc5_ == var_1415)
                {
                    _loc4_.position = 0;
                    _loc6_ = this.var_2594.getID(_loc4_);
                    param2.push([_loc6_, _loc4_]);
                    _loc4_ = new ByteArray();
                    _loc3_ = param1.position;
                }
                else
                {
                    _loc4_.writeByte(_loc5_);
                };
            };
            return (_loc3_);
        }


    }
}