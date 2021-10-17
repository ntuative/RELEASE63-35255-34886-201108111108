package com.sulake.core.communication.util
{
    import flash.utils.ByteArray;

    public class Short 
    {

        private var var_2595:ByteArray;

        public function Short(param1:int)
        {
            this.var_2595 = new ByteArray();
            this.var_2595.writeShort(param1);
            this.var_2595.position = 0;
        }

        public function get value():int
        {
            var _loc1_:int;
            this.var_2595.position = 0;
            if (this.var_2595.bytesAvailable)
            {
                _loc1_ = this.var_2595.readShort();
                this.var_2595.position = 0;
            };
            return (_loc1_);
        }


    }
}