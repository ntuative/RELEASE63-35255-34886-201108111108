package com.hurlant.crypto.prng
{
    import flash.utils.ByteArray;
    import flash.text.Font;
    import flash.system.System;
    import flash.system.Capabilities;
    import flash.utils.getTimer;
    import com.hurlant.util.Memory;

    public class Random 
    {

        private var state:IPRNG;
        private var ready:Boolean = false;
        private var var_2540:ByteArray;
        private var psize:int;
        private var var_2541:int;
        private var var_2542:Boolean = false;

        public function Random(param1:Class=null)
        {
            var _loc2_:uint;
            super();
            if (param1 == null)
            {
                param1 = ARC4;
            };
            this.state = (new (param1)() as IPRNG);
            this.psize = this.state.getPoolSize();
            this.var_2540 = new ByteArray();
            this.var_2541 = 0;
            while (this.var_2541 < this.psize)
            {
                _loc2_ = uint((0x10000 * Math.random()));
                var _loc3_:* = this.var_2541++;
                this.var_2540[_loc3_] = (_loc2_ >>> 8);
                var _loc4_:* = this.var_2541++;
                this.var_2540[_loc4_] = (_loc2_ & 0xFF);
            };
            this.var_2541 = 0;
            this.seed();
        }

        public function seed(param1:int=0):void
        {
            if (param1 == 0)
            {
                param1 = new Date().getTime();
            };
            var _loc2_:* = this.var_2541++;
            this.var_2540[_loc2_] = (this.var_2540[_loc2_] ^ (param1 & 0xFF));
            var _loc3_:* = this.var_2541++;
            this.var_2540[_loc3_] = (this.var_2540[_loc3_] ^ ((param1 >> 8) & 0xFF));
            var _loc4_:* = this.var_2541++;
            this.var_2540[_loc4_] = (this.var_2540[_loc4_] ^ ((param1 >> 16) & 0xFF));
            var _loc5_:* = this.var_2541++;
            this.var_2540[_loc5_] = (this.var_2540[_loc5_] ^ ((param1 >> 24) & 0xFF));
            this.var_2541 = (this.var_2541 % this.psize);
            this.var_2542 = true;
        }

        public function autoSeed():void
        {
            var _loc3_:Font;
            var _loc1_:ByteArray = new ByteArray();
            _loc1_.writeUnsignedInt(System.totalMemory);
            _loc1_.writeUTF(Capabilities.serverString);
            _loc1_.writeUnsignedInt(getTimer());
            _loc1_.writeUnsignedInt(new Date().getTime());
            var _loc2_:Array = Font.enumerateFonts(true);
            for each (_loc3_ in _loc2_)
            {
                _loc1_.writeUTF(_loc3_.fontName);
                _loc1_.writeUTF(_loc3_.fontStyle);
                _loc1_.writeUTF(_loc3_.fontType);
            };
            _loc1_.position = 0;
            while (_loc1_.bytesAvailable >= 4)
            {
                this.seed(_loc1_.readUnsignedInt());
            };
        }

        public function nextBytes(param1:ByteArray, param2:int):void
        {
            while (param2--)
            {
                param1.writeByte(this.nextByte());
            };
        }

        public function nextByte():int
        {
            if (!this.ready)
            {
                if (!this.var_2542)
                {
                    this.autoSeed();
                };
                this.state.init(this.var_2540);
                this.var_2540.length = 0;
                this.var_2541 = 0;
                this.ready = true;
            };
            return (this.state.next());
        }

        public function dispose():void
        {
            var _loc1_:uint;
            while (_loc1_ < this.var_2540.length)
            {
                this.var_2540[_loc1_] = (Math.random() * 0x0100);
                _loc1_++;
            };
            this.var_2540.length = 0;
            this.var_2540 = null;
            this.state.dispose();
            this.state = null;
            this.psize = 0;
            this.var_2541 = 0;
            Memory.gc();
        }

        public function toString():String
        {
            return ("random-" + this.state.toString());
        }


    }
}