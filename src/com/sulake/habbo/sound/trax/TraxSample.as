package com.sulake.habbo.sound.trax
{
    import com.sulake.core.runtime.IDisposable;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import __AS3__.vec.*;

    public class TraxSample implements IDisposable 
    {

        public static const var_172:String = "sample_44khz";
        public static const var_966:String = "sample_22khz";
        public static const var_967:String = "sample_11khz";
        public static const var_173:String = "sample_16bit";
        public static const var_968:String = "sample_8bit";
        public static const SAMPLE_VALUE_MULTIPLIER:Number = (1 / 0x8000);//3.0517578125E-5
        private static const var_969:int = 32;
        private static const var_972:int = 0xFF;
        private static const var_970:int = 0xFFFF;
        private static const var_973:int = 127;
        private static const var_971:int = 32767;

        private var _disposed:Boolean = false;
        private var var_5054:Vector.<int> = null;
        private var _id:int;
        private var var_5052:int = 2;
        private var var_5053:int = 1;
        private var var_5055:Array = [];
        private var var_5056:uint;

        public function TraxSample(param1:ByteArray, param2:int, param3:String="sample_44khz", param4:String="sample_16bit")
        {
            var _loc12_:Number;
            var _loc13_:int;
            var _loc14_:int;
            var _loc15_:Number;
            var _loc16_:Number;
            super();
            this._id = param2;
            var _loc5_:* = 0x10000;
            switch (param3)
            {
                case var_966:
                    this.var_5053 = 2;
                    break;
                case var_967:
                    this.var_5053 = 4;
                    break;
                default:
                    this.var_5053 = 1;
            };
            switch (param4)
            {
                case var_968:
                    this.var_5052 = 4;
                    _loc5_ = 0x0100;
                    break;
                default:
                    this.var_5052 = 2;
                    _loc5_ = 0x10000;
            };
            var _loc6_:int = (this.var_5052 * this.var_5053);
            var _loc7_:int = int((param1.length / 8));
            _loc7_ = int((int((_loc7_ / _loc6_)) * _loc6_));
            this.var_5054 = new Vector.<int>((_loc7_ / _loc6_), true);
            var _loc8_:Number = (1 / (Number(_loc5_) / 2));
            param1.position = 0;
            var _loc9_:int;
            var _loc10_:int = int((_loc7_ / this.var_5053));
            var _loc11_:int;
            while (_loc11_ < _loc10_)
            {
                _loc12_ = param1.readFloat();
                param1.readFloat();
                _loc13_ = 2;
                while (_loc13_ <= this.var_5053)
                {
                    _loc15_ = param1.readFloat();
                    param1.readFloat();
                    _loc16_ = Number(_loc13_);
                    _loc12_ = (((_loc12_ * (_loc16_ - 1)) / _loc16_) + (Number(_loc15_) / _loc16_));
                    _loc13_++;
                };
                if (_loc11_ >= ((_loc10_ - 1) - var_969))
                {
                    _loc12_ = (_loc12_ * (((_loc10_ - _loc11_) - 1) / Number(var_969)));
                };
                _loc14_ = int(((_loc12_ + 1) / _loc8_));
                if (_loc14_ < 0)
                {
                    _loc14_ = 0;
                }
                else
                {
                    if (_loc14_ >= _loc5_)
                    {
                        _loc14_ = (_loc5_ - 1);
                    };
                };
                _loc9_ = (_loc9_ * _loc5_);
                _loc9_ = (_loc9_ + _loc14_);
                if ((_loc11_ % this.var_5052) == (this.var_5052 - 1))
                {
                    this.var_5054[int((_loc11_ / this.var_5052))] = _loc9_;
                    _loc9_ = 0;
                };
                _loc11_++;
            };
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get length():uint
        {
            return ((this.var_5054.length * this.var_5052) * this.var_5053);
        }

        public function get usageCount():int
        {
            return (this.var_5055.length);
        }

        public function get usageTimeStamp():int
        {
            return (this.var_5056);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this.var_5054 = null;
                this.var_5055 = null;
            };
        }

        public function setSample(param1:Vector.<int>, param2:int, param3:int, param4:int):int
        {
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:int;
            if (((param1 == null) || (this.var_5054 == null)))
            {
                return (param4);
            };
            var _loc5_:int = (this.var_5052 * this.var_5053);
            param4 = int((param4 / _loc5_));
            if (param2 < 0)
            {
                param3 = (param3 + param2);
                param2 = 0;
            };
            if (param3 > (param1.length - param2))
            {
                param3 = (param1.length - param2);
            };
            var _loc6_:int = int((param3 / _loc5_));
            var _loc7_:int;
            if (_loc6_ > (this.var_5054.length - param4))
            {
                _loc7_ = ((_loc6_ - (this.var_5054.length - param4)) * _loc5_);
                _loc6_ = (this.var_5054.length - param4);
                if (_loc7_ > (param1.length - param2))
                {
                    _loc7_ = (param1.length - param2);
                };
            };
            if (this.var_5053 == 1)
            {
                if (this.var_5052 == 2)
                {
                    while (_loc6_-- > 0)
                    {
                        _loc8_ = this.var_5054[param4++];
                        var _loc11_:* = param2++;
                        param1[_loc11_] = (((_loc8_ >> 16) & var_970) - var_971);
                        var _loc12_:* = param2++;
                        param1[_loc12_] = ((_loc8_ & var_970) - var_971);
                    };
                }
                else
                {
                    if (this.var_5052 == 4)
                    {
                        while (_loc6_-- > 0)
                        {
                            _loc8_ = this.var_5054[param4++];
                            _loc11_ = param2++;
                            param1[_loc11_] = ((((_loc8_ >> 24) & var_972) - var_973) << 8);
                            _loc12_ = param2++;
                            param1[_loc12_] = ((((_loc8_ >> 16) & var_972) - var_973) << 8);
                            var _loc13_:* = param2++;
                            param1[_loc13_] = ((((_loc8_ >> 8) & var_972) - var_973) << 8);
                            var _loc14_:* = param2++;
                            param1[_loc14_] = (((_loc8_ & var_972) - var_973) << 8);
                        };
                    };
                };
            }
            else
            {
                if (this.var_5053 >= 2)
                {
                    _loc9_ = 0;
                    _loc10_ = 0;
                    if (this.var_5052 == 2)
                    {
                        while (_loc6_-- > 0)
                        {
                            _loc8_ = this.var_5054[param4++];
                            _loc10_ = (((_loc8_ >> 16) & var_970) - var_971);
                            _loc9_ = this.var_5053;
                            while (_loc9_ > 0)
                            {
                                _loc11_ = param2++;
                                param1[_loc11_] = _loc10_;
                                _loc9_--;
                            };
                            _loc10_ = ((_loc8_ & var_970) - var_971);
                            _loc9_ = this.var_5053;
                            while (_loc9_ > 0)
                            {
                                _loc11_ = param2++;
                                param1[_loc11_] = _loc10_;
                                _loc9_--;
                            };
                        };
                    }
                    else
                    {
                        if (this.var_5052 == 4)
                        {
                            while (_loc6_-- > 0)
                            {
                                _loc8_ = this.var_5054[param4++];
                                _loc10_ = ((((_loc8_ >> 24) & var_972) - var_973) << 8);
                                _loc9_ = this.var_5053;
                                while (_loc9_ > 0)
                                {
                                    _loc11_ = param2++;
                                    param1[_loc11_] = _loc10_;
                                    _loc9_--;
                                };
                                _loc10_ = ((((_loc8_ >> 16) & var_972) - var_973) << 8);
                                _loc9_ = this.var_5053;
                                while (_loc9_ > 0)
                                {
                                    _loc11_ = param2++;
                                    param1[_loc11_] = _loc10_;
                                    _loc9_--;
                                };
                                _loc10_ = ((((_loc8_ >> 8) & var_972) - var_973) << 8);
                                _loc9_ = this.var_5053;
                                while (_loc9_ > 0)
                                {
                                    _loc11_ = param2++;
                                    param1[_loc11_] = _loc10_;
                                    _loc9_--;
                                };
                                _loc10_ = (((_loc8_ & var_972) - var_973) << 8);
                                _loc9_ = this.var_5053;
                                while (_loc9_ > 0)
                                {
                                    _loc11_ = param2++;
                                    param1[_loc11_] = _loc10_;
                                    _loc9_--;
                                };
                            };
                        };
                    };
                };
            };
            while (_loc7_-- > 0)
            {
                _loc11_ = param2++;
                param1[_loc11_] = 0;
            };
            return (param4 * _loc5_);
        }

        public function addSample(param1:Vector.<int>, param2:int, param3:int, param4:int):int
        {
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:int;
            if (((param1 == null) || (this.var_5054 == null)))
            {
                return (param4);
            };
            var _loc5_:int = (this.var_5052 * this.var_5053);
            param4 = int((param4 / _loc5_));
            if (param2 < 0)
            {
                param3 = (param3 + param2);
                param2 = 0;
            };
            if (param3 > (param1.length - param2))
            {
                param3 = (param1.length - param2);
            };
            var _loc6_:int = int((param3 / _loc5_));
            if (_loc6_ > (this.var_5054.length - param4))
            {
                _loc6_ = (this.var_5054.length - param4);
            };
            if (this.var_5053 == 1)
            {
                if (this.var_5052 == 2)
                {
                    while (_loc6_-- > 0)
                    {
                        _loc7_ = this.var_5054[param4++];
                        var _loc10_:* = param2++;
                        param1[_loc10_] = (param1[_loc10_] + (((_loc7_ >> 16) & var_970) - var_971));
                        var _loc11_:* = param2++;
                        param1[_loc11_] = (param1[_loc11_] + ((_loc7_ & var_970) - var_971));
                    };
                }
                else
                {
                    if (this.var_5052 == 4)
                    {
                        while (_loc6_-- > 0)
                        {
                            _loc7_ = this.var_5054[param4++];
                            _loc10_ = param2++;
                            param1[_loc10_] = (param1[_loc10_] + ((((_loc7_ >> 24) & var_972) - var_973) << 8));
                            _loc11_ = param2++;
                            param1[_loc11_] = (param1[_loc11_] + ((((_loc7_ >> 16) & var_972) - var_973) << 8));
                            var _loc12_:* = param2++;
                            param1[_loc12_] = (param1[_loc12_] + ((((_loc7_ >> 8) & var_972) - var_973) << 8));
                            var _loc13_:* = param2++;
                            param1[_loc13_] = (param1[_loc13_] + (((_loc7_ & var_972) - var_973) << 8));
                        };
                    };
                };
            }
            else
            {
                if (this.var_5053 >= 2)
                {
                    _loc8_ = 0;
                    _loc9_ = 0;
                    if (this.var_5052 == 2)
                    {
                        while (_loc6_-- > 0)
                        {
                            _loc7_ = this.var_5054[param4++];
                            _loc9_ = (((_loc7_ >> 16) & var_970) - var_971);
                            _loc8_ = this.var_5053;
                            while (_loc8_ > 0)
                            {
                                _loc10_ = param2++;
                                param1[_loc10_] = (param1[_loc10_] + _loc9_);
                                _loc8_--;
                            };
                            _loc9_ = ((_loc7_ & var_970) - var_971);
                            _loc8_ = this.var_5053;
                            while (_loc8_ > 0)
                            {
                                _loc10_ = param2++;
                                param1[_loc10_] = (param1[_loc10_] + _loc9_);
                                _loc8_--;
                            };
                        };
                    }
                    else
                    {
                        if (this.var_5052 == 4)
                        {
                            while (_loc6_-- > 0)
                            {
                                _loc7_ = this.var_5054[param4++];
                                _loc9_ = ((((_loc7_ >> 24) & var_972) - var_973) << 8);
                                _loc8_ = this.var_5053;
                                while (_loc8_ > 0)
                                {
                                    _loc10_ = param2++;
                                    param1[_loc10_] = (param1[_loc10_] + _loc9_);
                                    _loc8_--;
                                };
                                _loc9_ = ((((_loc7_ >> 16) & var_972) - var_973) << 8);
                                _loc8_ = this.var_5053;
                                while (_loc8_ > 0)
                                {
                                    _loc10_ = param2++;
                                    param1[_loc10_] = (param1[_loc10_] + _loc9_);
                                    _loc8_--;
                                };
                                _loc9_ = ((((_loc7_ >> 8) & var_972) - var_973) << 8);
                                _loc8_ = this.var_5053;
                                while (_loc8_ > 0)
                                {
                                    _loc10_ = param2++;
                                    param1[_loc10_] = (param1[_loc10_] + _loc9_);
                                    _loc8_--;
                                };
                                _loc9_ = (((_loc7_ & var_972) - var_973) << 8);
                                _loc8_ = this.var_5053;
                                while (_loc8_ > 0)
                                {
                                    _loc10_ = param2++;
                                    param1[_loc10_] = (param1[_loc10_] + _loc9_);
                                    _loc8_--;
                                };
                            };
                        };
                    };
                };
            };
            return (param4 * _loc5_);
        }

        public function setUsageFromSong(param1:int, param2:uint):void
        {
            if (this.var_5055 == null)
            {
                return;
            };
            if (this.var_5055.indexOf(param1) == -1)
            {
                this.var_5055.push(param1);
            };
            this.var_5056 = param2;
        }

        public function isUsedFromSong(param1:int):Boolean
        {
            if (this.var_5055 == null)
            {
                return (false);
            };
            return (!(this.var_5055.indexOf(param1) == -1));
        }


    }
}