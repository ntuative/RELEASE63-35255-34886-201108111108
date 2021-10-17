package com.sulake.habbo.sound.trax
{
    import com.sulake.habbo.sound.IHabboSound;
    import com.sulake.core.runtime.IDisposable;
    import __AS3__.vec.Vector;
    import flash.events.IEventDispatcher;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import com.sulake.core.utils.Map;
    import flash.utils.Timer;
    import flash.media.SoundTransform;
    import flash.utils.getTimer;
    import flash.events.SampleDataEvent;
    import flash.events.TimerEvent;
    import flash.utils.ByteArray;
    import com.sulake.habbo.sound.events.SoundCompleteEvent;
    import __AS3__.vec.*;

    public class TraxSequencer implements IHabboSound, IDisposable 
    {

        private static const var_962:Number = 44100;
        private static const var_961:uint = 0x2000;
        private static const var_964:uint = 88000;
        private static const var_963:uint = 88000;
        private static const var_965:Vector.<int> = new Vector.<int>(var_961, true);
        private static const INTERPOLATION_BUFFER:Vector.<int> = new Vector.<int>(var_961, true);

        private var _disposed:Boolean = false;
        private var _events:IEventDispatcher;
        private var var_3858:Number;
        private var var_5057:Sound;
        private var var_5049:SoundChannel;
        private var var_5058:TraxData;
        private var var_5059:Map;
        private var var_2645:Boolean;
        private var var_1932:int;
        private var var_5060:int = 0;
        private var var_5061:uint;
        private var var_5062:Array;
        private var var_5063:Boolean;
        private var var_5064:Boolean = true;
        private var var_5065:uint;
        private var var_5066:uint = uint(30);
        private var var_5067:Boolean;
        private var var_5068:Boolean;
        private var var_5069:int;
        private var var_5070:int;
        private var var_5071:int;
        private var var_5072:int;
        private var var_5073:Timer;
        private var var_5074:Timer;
        private var var_5075:Boolean;
        private var var_5076:int = 0;
        private var var_5077:int = 0;

        public function TraxSequencer(param1:int, param2:TraxData, param3:Map, param4:IEventDispatcher)
        {
            this._events = param4;
            this.var_1932 = param1;
            this.var_3858 = 1;
            this.var_5057 = new Sound();
            this.var_5049 = null;
            this.var_5059 = param3;
            this.var_5058 = param2;
            this.var_2645 = true;
            this.var_5061 = 0;
            this.var_5062 = [];
            this.var_5063 = false;
            this.var_5065 = 0;
            this.var_5064 = false;
            this.var_5067 = false;
            this.var_5068 = false;
            this.var_5069 = 0;
            this.var_5070 = 0;
            this.var_5071 = 0;
            this.var_5072 = 0;
        }

        public function set position(param1:Number):void
        {
            this.var_5061 = uint((param1 * var_962));
        }

        public function get volume():Number
        {
            return (this.var_3858);
        }

        public function get position():Number
        {
            return (this.var_5061 / var_962);
        }

        public function get ready():Boolean
        {
            return (this.var_2645);
        }

        public function set ready(param1:Boolean):void
        {
            this.var_2645 = param1;
        }

        public function get finished():Boolean
        {
            return (this.var_5064);
        }

        public function get fadeOutSeconds():Number
        {
            return (this.var_5070 / var_962);
        }

        public function set fadeOutSeconds(param1:Number):void
        {
            this.var_5070 = int((param1 * var_962));
        }

        public function get fadeInSeconds():Number
        {
            return (this.var_5069 / var_962);
        }

        public function set fadeInSeconds(param1:Number):void
        {
            this.var_5069 = int((param1 * var_962));
        }

        public function get traxData():TraxData
        {
            return (this.var_5058);
        }

        public function set volume(param1:Number):void
        {
            this.var_3858 = param1;
            if (this.var_5049 != null)
            {
                this.var_5049.soundTransform = new SoundTransform(this.var_3858);
            };
        }

        public function get length():Number
        {
            return (this.var_5065 / var_962);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this.stopImmediately();
                this.var_5058 = null;
                this.var_5059 = null;
                this.var_5062 = null;
                this._events = null;
                this.var_5057 = null;
                this._disposed = true;
            };
        }

        public function prepare():Boolean
        {
            if (!this.var_2645)
            {
                Logger.log("Cannot start trax playback until samples ready!");
                return (false);
            };
            if (!this.var_5063)
            {
                if (this.var_5058 != null)
                {
                    this.var_5075 = false;
                    if (this.var_5058.hasMetaData)
                    {
                        this.var_5075 = this.var_5058.metaCutMode;
                    };
                    if (this.var_5075)
                    {
                        if (!this.prepareSequence())
                        {
                            Logger.log("Cannot start playback, prepare sequence failed!");
                            return (false);
                        };
                    }
                    else
                    {
                        if (!this.prepareLegacySequence())
                        {
                            Logger.log("Cannot start playback, prepare legacy sequence failed!");
                            return (false);
                        };
                    };
                };
            };
            return (true);
        }

        private function prepareLegacySequence():Boolean
        {
            var _loc3_:Map;
            var _loc4_:TraxChannel;
            var _loc5_:uint;
            var _loc6_:uint;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:TraxSample;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:int;
            if (this.var_5062 == null)
            {
                return (false);
            };
            var _loc1_:uint = getTimer();
            var _loc2_:int;
            while (_loc2_ < this.var_5058.channels.length)
            {
                _loc3_ = new Map();
                _loc4_ = (this.var_5058.channels[_loc2_] as TraxChannel);
                _loc5_ = 0;
                _loc6_ = 0;
                _loc7_ = 0;
                while (_loc7_ < _loc4_.itemCount)
                {
                    _loc8_ = _loc4_.getItem(_loc7_).id;
                    _loc9_ = (this.var_5059.getValue(_loc8_) as TraxSample);
                    _loc9_.setUsageFromSong(this.var_1932, _loc1_);
                    if (_loc9_ != null)
                    {
                        _loc10_ = this.getSampleBars(_loc9_.length);
                        _loc11_ = int((_loc4_.getItem(_loc7_).length / _loc10_));
                        _loc12_ = 0;
                        while (_loc12_ < _loc11_)
                        {
                            if (_loc8_ != 0)
                            {
                                _loc3_.add(_loc5_, _loc9_);
                            };
                            _loc6_ = (_loc6_ + _loc10_);
                            _loc5_ = (_loc6_ * var_963);
                            _loc12_++;
                        };
                    }
                    else
                    {
                        Logger.log("Error in prepareLegacySequence(), sample was null!");
                        return (false);
                    };
                    if (this.var_5065 < _loc5_)
                    {
                        this.var_5065 = _loc5_;
                    };
                    _loc7_++;
                };
                this.var_5062.push(_loc3_);
                _loc2_++;
            };
            this.var_5063 = true;
            return (true);
        }

        private function prepareSequence():Boolean
        {
            var _loc3_:Map;
            var _loc4_:TraxChannel;
            var _loc5_:uint;
            var _loc6_:uint;
            var _loc7_:Boolean;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:TraxSample;
            var _loc11_:int;
            var _loc12_:int;
            var _loc13_:int;
            var _loc14_:int;
            if (this.var_5062 == null)
            {
                return (false);
            };
            var _loc1_:uint = getTimer();
            var _loc2_:int;
            while (_loc2_ < this.var_5058.channels.length)
            {
                _loc3_ = new Map();
                _loc4_ = (this.var_5058.channels[_loc2_] as TraxChannel);
                _loc5_ = 0;
                _loc6_ = 0;
                _loc7_ = false;
                _loc8_ = 0;
                while (_loc8_ < _loc4_.itemCount)
                {
                    _loc9_ = _loc4_.getItem(_loc8_).id;
                    _loc10_ = (this.var_5059.getValue(_loc9_) as TraxSample);
                    _loc10_.setUsageFromSong(this.var_1932, _loc1_);
                    if (_loc10_ != null)
                    {
                        _loc11_ = _loc6_;
                        _loc12_ = _loc5_;
                        _loc13_ = this.getSampleBars(_loc10_.length);
                        _loc14_ = _loc4_.getItem(_loc8_).length;
                        while (_loc11_ < (_loc6_ + _loc14_))
                        {
                            if (((!(_loc9_ == 0)) || (_loc7_)))
                            {
                                _loc3_.add(_loc12_, _loc10_);
                                _loc7_ = false;
                            };
                            _loc11_ = (_loc11_ + _loc13_);
                            _loc12_ = (_loc11_ * var_963);
                            if (_loc11_ > (_loc6_ + _loc14_))
                            {
                                _loc7_ = true;
                            };
                        };
                        _loc6_ = (_loc6_ + _loc4_.getItem(_loc8_).length);
                        _loc5_ = (_loc6_ * var_963);
                    }
                    else
                    {
                        Logger.log("Error in prepareSequence(), sample was null!");
                        return (false);
                    };
                    if (this.var_5065 < _loc5_)
                    {
                        this.var_5065 = _loc5_;
                    };
                    _loc8_++;
                };
                this.var_5062.push(_loc3_);
                _loc2_++;
            };
            this.var_5063 = true;
            return (true);
        }

        public function play(param1:Number=0):Boolean
        {
            if (!this.prepare())
            {
                return (false);
            };
            this.removeFadeoutStopTimer();
            if (this.var_5049 != null)
            {
                this.stopImmediately();
            };
            if (this.var_5069 > 0)
            {
                this.var_5067 = true;
                this.var_5071 = 0;
            };
            this.var_5068 = false;
            this.var_5072 = 0;
            this.var_5064 = false;
            this.var_5057.addEventListener(SampleDataEvent.SAMPLE_DATA, this.onSampleData);
            this.var_5060 = (param1 * var_962);
            this.var_5076 = 0;
            this.var_5077 = 0;
            this.var_5049 = this.var_5057.play();
            this.volume = this.var_3858;
            return (true);
        }

        public function render(param1:SampleDataEvent):Boolean
        {
            if (!this.prepare())
            {
                return (false);
            };
            while ((!(this.var_5064)))
            {
                this.onSampleData(param1);
            };
            return (true);
        }

        public function stop():Boolean
        {
            if (((this.var_5070 > 0) && (!(this.var_5064))))
            {
                this.stopWithFadeout();
            }
            else
            {
                this.playingComplete();
            };
            return (true);
        }

        private function stopImmediately():void
        {
            this.removeStopTimer();
            if (this.var_5049 != null)
            {
                this.var_5049.stop();
                this.var_5049 = null;
            };
            if (this.var_5057 != null)
            {
                this.var_5057.removeEventListener(SampleDataEvent.SAMPLE_DATA, this.onSampleData);
            };
        }

        private function stopWithFadeout():void
        {
            if (this.var_5073 == null)
            {
                this.var_5068 = true;
                this.var_5072 = 0;
                this.var_5073 = new Timer((this.var_5066 + (this.var_5070 / (var_962 / 1000))), 1);
                this.var_5073.start();
                this.var_5073.addEventListener(TimerEvent.TIMER_COMPLETE, this.onFadeOutComplete);
            };
        }

        private function getSampleBars(param1:uint):int
        {
            if (this.var_5075)
            {
                return (Math.round((param1 / var_964)));
            };
            return (Math.ceil((param1 / var_964)));
        }

        private function getChannelSequenceOffsets():Array
        {
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:Map;
            var _loc5_:int;
            var _loc1_:Array = [];
            if (this.var_5062 != null)
            {
                _loc2_ = this.var_5062.length;
                _loc3_ = 0;
                while (_loc3_ < _loc2_)
                {
                    _loc4_ = this.var_5062[_loc3_];
                    _loc5_ = 0;
                    while (((_loc5_ < _loc4_.length) && (_loc4_.getKey(_loc5_) < this.var_5061)))
                    {
                        _loc5_++;
                    };
                    _loc1_.push((_loc5_ - 1));
                    _loc3_++;
                };
            };
            return (_loc1_);
        }

        private function mixChannelsIntoBuffer():void
        {
            var _loc5_:Map;
            var _loc6_:int;
            var _loc7_:TraxSample;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:int;
            var _loc13_:int;
            var _loc14_:int;
            if (this.var_5062 == null)
            {
                return;
            };
            var _loc1_:Array = this.getChannelSequenceOffsets();
            var _loc2_:int = this.var_5062.length;
            var _loc3_:TraxChannelSample;
            var _loc4_:int = (_loc2_ - 1);
            while (_loc4_ >= 0)
            {
                _loc5_ = this.var_5062[_loc4_];
                _loc6_ = _loc1_[_loc4_];
                _loc7_ = _loc5_.getWithIndex(_loc6_);
                if (_loc7_ == null)
                {
                    _loc3_ = null;
                }
                else
                {
                    _loc10_ = _loc5_.getKey(_loc6_);
                    _loc11_ = (this.var_5061 - _loc10_);
                    if (((_loc7_.id == 0) || (_loc11_ < 0)))
                    {
                        _loc3_ = null;
                    }
                    else
                    {
                        _loc3_ = new TraxChannelSample(_loc7_, _loc11_);
                    };
                };
                _loc8_ = var_961;
                if ((this.var_5065 - this.var_5061) < _loc8_)
                {
                    _loc8_ = (this.var_5065 - this.var_5061);
                };
                _loc9_ = 0;
                while (_loc9_ < _loc8_)
                {
                    _loc12_ = _loc8_;
                    if (_loc6_ < (_loc5_.length - 1))
                    {
                        _loc13_ = _loc5_.getKey((_loc6_ + 1));
                        if ((_loc8_ + this.var_5061) >= _loc13_)
                        {
                            _loc12_ = (_loc13_ - this.var_5061);
                        };
                    };
                    if (_loc12_ > (_loc8_ - _loc9_))
                    {
                        _loc12_ = (_loc8_ - _loc9_);
                    };
                    if (_loc4_ == (_loc2_ - 1))
                    {
                        if (_loc3_ != null)
                        {
                            _loc3_.setSample(var_965, _loc9_, _loc12_);
                            _loc9_ = (_loc9_ + _loc12_);
                        }
                        else
                        {
                            _loc14_ = 0;
                            while (_loc14_ < _loc12_)
                            {
                                var _loc15_:* = _loc9_++;
                                var_965[_loc15_] = 0;
                                _loc14_++;
                            };
                        };
                    }
                    else
                    {
                        if (_loc3_ != null)
                        {
                            _loc3_.addSample(var_965, _loc9_, _loc12_);
                        };
                        _loc9_ = (_loc9_ + _loc12_);
                    };
                    if (_loc9_ < _loc8_)
                    {
                        _loc7_ = _loc5_.getWithIndex(++_loc6_);
                        if (((_loc7_ == null) || (_loc7_.id == 0)))
                        {
                            _loc3_ = null;
                        }
                        else
                        {
                            _loc3_ = new TraxChannelSample(_loc7_, 0);
                        };
                    };
                };
                _loc4_--;
            };
        }

        private function checkSongFinishing():void
        {
            var _loc1_:int = ((this.var_5065 < this.var_5060) ? this.var_5065 : ((this.var_5060 > 0) ? this.var_5060 : this.var_5065));
            if (((this.var_5061 > (_loc1_ + (this.var_5066 * (var_962 / 1000)))) && (!(this.var_5064))))
            {
                this.var_5064 = true;
                if (this.var_5074 != null)
                {
                    this.var_5074.reset();
                    this.var_5074.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onPlayingComplete);
                };
                this.var_5074 = new Timer(2, 1);
                this.var_5074.start();
                this.var_5074.addEventListener(TimerEvent.TIMER_COMPLETE, this.onPlayingComplete);
            }
            else
            {
                if (((this.var_5061 > (_loc1_ - this.var_5070)) && (!(this.var_5068))))
                {
                    this.var_5067 = false;
                    this.var_5068 = true;
                    this.var_5072 = 0;
                };
            };
        }

        private function onSampleData(param1:SampleDataEvent):void
        {
            if (param1.position > this.var_5076)
            {
                this.var_5077++;
                Logger.log("Audio buffer under run...");
                this.var_5076 = param1.position;
            };
            if (this.volume > 0)
            {
                this.mixChannelsIntoBuffer();
            };
            var _loc2_:int = var_961;
            if ((this.var_5065 - this.var_5061) < _loc2_)
            {
                _loc2_ = (this.var_5065 - this.var_5061);
                if (_loc2_ < 0)
                {
                    _loc2_ = 0;
                };
            };
            if (this.volume <= 0)
            {
                _loc2_ = 0;
            };
            this.writeAudioToOutputStream(param1.data, _loc2_);
            this.var_5061 = (this.var_5061 + var_961);
            this.var_5076 = (this.var_5076 + var_961);
            if (this.var_5049 != null)
            {
                this.var_5066 = (((param1.position / var_962) * 1000) - this.var_5049.position);
            };
            this.checkSongFinishing();
        }

        private function interpolate(param1:int, param2:Number):int
        {
            var _loc4_:Number;
            var _loc5_:Number;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:Number;
            var _loc9_:Number;
            var _loc10_:int;
            var _loc3_:Number = 0;
            while (_loc10_ < param1)
            {
                _loc6_ = Math.floor(_loc3_);
                _loc7_ = Math.ceil(_loc3_);
                _loc4_ = var_965[_loc6_];
                _loc5_ = var_965[_loc7_];
                _loc8_ = (_loc3_ - _loc6_);
                _loc9_ = (_loc5_ - _loc4_);
                INTERPOLATION_BUFFER[_loc10_] = (_loc4_ + (_loc9_ * _loc8_));
                _loc3_ = (_loc3_ + param2);
                if (_loc3_ > (var_961 - 2))
                {
                    this.var_5061 = (this.var_5061 + var_961);
                    this.mixChannelsIntoBuffer();
                    _loc3_ = 0;
                };
                _loc10_++;
            };
            return (int(Math.round(_loc3_)));
        }

        private function writeAudioToOutputStream(param1:ByteArray, param2:int):void
        {
            var _loc5_:Number;
            var _loc6_:Number;
            if (param2 > 0)
            {
                if (((!(this.var_5067)) && (!(this.var_5068))))
                {
                    this.writeMixingBufferToOutputStream(param1, param2);
                }
                else
                {
                    if (this.var_5067)
                    {
                        _loc5_ = (1 / this.var_5069);
                        _loc6_ = (this.var_5071 / Number(this.var_5069));
                        this.var_5071 = (this.var_5071 + var_961);
                        if (this.var_5071 > this.var_5069)
                        {
                            this.var_5067 = false;
                        };
                    }
                    else
                    {
                        if (this.var_5068)
                        {
                            _loc5_ = (-1 / this.var_5070);
                            _loc6_ = (1 - (this.var_5072 / Number(this.var_5070)));
                            this.var_5072 = (this.var_5072 + var_961);
                            if (this.var_5072 > this.var_5070)
                            {
                                this.var_5072 = this.var_5070;
                            };
                        };
                    };
                    this.writeMixingBufferToOutputStreamWithFade(param1, param2, _loc6_, _loc5_);
                };
            };
            var _loc3_:Number = 0;
            var _loc4_:int = param2;
            while (_loc4_ < var_961)
            {
                param1.writeFloat(_loc3_);
                param1.writeFloat(_loc3_);
                _loc4_++;
            };
        }

        private function writeMixingBufferToOutputStream(param1:ByteArray, param2:int):void
        {
            var _loc3_:Number = 0;
            var _loc4_:int;
            while (_loc4_ < param2)
            {
                _loc3_ = (Number(var_965[_loc4_]) * TraxSample.SAMPLE_VALUE_MULTIPLIER);
                param1.writeFloat(_loc3_);
                param1.writeFloat(_loc3_);
                _loc4_++;
            };
        }

        private function writeMixingBufferToOutputStreamWithFade(param1:ByteArray, param2:int, param3:Number, param4:Number):void
        {
            var _loc5_:Number = 0;
            var _loc6_:int;
            _loc6_ = 0;
            while (_loc6_ < param2)
            {
                if (((param3 < 0) || (param3 > 1))) break;
                _loc5_ = ((Number(var_965[_loc6_]) * TraxSample.SAMPLE_VALUE_MULTIPLIER) * param3);
                param3 = (param3 + param4);
                param1.writeFloat(_loc5_);
                param1.writeFloat(_loc5_);
                _loc6_++;
            };
            if (param3 < 0)
            {
                while (_loc6_ < param2)
                {
                    param1.writeFloat(0);
                    param1.writeFloat(0);
                    _loc6_++;
                };
            }
            else
            {
                if (param3 > 1)
                {
                    while (_loc6_ < param2)
                    {
                        _loc5_ = (Number(var_965[_loc6_]) * TraxSample.SAMPLE_VALUE_MULTIPLIER);
                        param3 = (param3 + param4);
                        param1.writeFloat(_loc5_);
                        param1.writeFloat(_loc5_);
                        _loc6_++;
                    };
                };
            };
        }

        private function onPlayingComplete(param1:TimerEvent):void
        {
            if (this.var_5064)
            {
                this.playingComplete();
            };
        }

        private function onFadeOutComplete(param1:TimerEvent):void
        {
            this.removeFadeoutStopTimer();
            this.playingComplete();
        }

        private function playingComplete():void
        {
            this.stopImmediately();
            this._events.dispatchEvent(new SoundCompleteEvent(SoundCompleteEvent.TRAX_SONG_COMPLETE, this.var_1932));
        }

        private function removeFadeoutStopTimer():void
        {
            if (this.var_5073 != null)
            {
                this.var_5073.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onFadeOutComplete);
                this.var_5073.reset();
                this.var_5073 = null;
            };
        }

        private function removeStopTimer():void
        {
            if (this.var_5074 != null)
            {
                this.var_5074.reset();
                this.var_5074.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onPlayingComplete);
                this.var_5074 = null;
            };
        }


    }
}