package com.sulake.habbo.communication.encryption
{
    import com.sulake.core.communication.encryption.IEncryption;
    import flash.utils.ByteArray;

    public class RC4 implements IEncryption 
    {

        private var i:uint = 0;
        private var j:uint = 0;
        private var var_3376:Array;

        public function RC4()
        {
            this.var_3376 = new Array(0x0100);
        }

        public function init(param1:ByteArray):void
        {
            var _loc2_:uint = param1.length;
            this.i = 0;
            while (this.i < 0x0100)
            {
                this.var_3376[this.i] = this.i;
                this.i++;
            };
            this.j = 0;
            this.i = 0;
            while (this.i < 0x0100)
            {
                this.j = (((this.j + this.var_3376[this.i]) + param1[(this.i % _loc2_)]) % 0x0100);
                this.swap(this.i, this.j);
                this.i++;
            };
            this.i = 0;
            this.j = 0;
        }

        public function initFromState(param1:IEncryption):void
        {
            var _loc2_:RC4 = (param1 as RC4);
            this.var_3376 = _loc2_.var_3376.concat();
            this.i = _loc2_.i;
            this.j = _loc2_.j;
        }

        public function encipher(param1:ByteArray, param2:Boolean=false):ByteArray
        {
            var _loc4_:uint;
            var _loc3_:ByteArray = new ByteArray();
            param1.position = 0;
            while (param1.bytesAvailable)
            {
                this.i = ((this.i + 1) % 0x0100);
                this.j = ((this.j + this.var_3376[this.i]) % 0x0100);
                this.swap(this.i, this.j);
                if (param2)
                {
                    this.customHackScramble(this.var_3376, this.i, this.j);
                };
                _loc4_ = ((this.var_3376[this.i] + this.var_3376[this.j]) % 0x0100);
                _loc3_.writeByte((this.var_3376[_loc4_] ^ param1.readByte()));
            };
            _loc3_.position = 0;
            return (_loc3_);
        }

        protected function customHackScramble(param1:Array, param2:int, param3:int):void
        {
        }

        public function decipher(param1:ByteArray):ByteArray
        {
            var _loc3_:uint;
            var _loc2_:ByteArray = new ByteArray();
            param1.position = 0;
            while (param1.bytesAvailable)
            {
                this.i = ((this.i + 1) % 0x0100);
                this.j = ((this.j + this.var_3376[this.i]) % 0x0100);
                this.swap(this.i, this.j);
                _loc3_ = ((this.var_3376[this.i] + this.var_3376[this.j]) % 0x0100);
                _loc2_.writeByte((param1.readUnsignedByte() ^ this.var_3376[_loc3_]));
            };
            _loc2_.position = 0;
            return (_loc2_);
        }

        protected function swap(param1:uint, param2:uint):void
        {
            var _loc3_:Object = this.var_3376[param1];
            this.var_3376[param1] = this.var_3376[param2];
            this.var_3376[param2] = _loc3_;
        }


    }
}