package com.sulake.habbo.room.object.visualization.avatar
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import flash.display.BlendMode;
    import com.sulake.habbo.avatar.enum.AvatarAction;

    public class AvatarVisualization extends RoomObjectSpriteVisualization implements IAvatarImageListener 
    {

        private static const var_1518:String = "avatar";
        private static const var_1517:Number = -0.01;
        private static const var_1516:Number = -0.409;
        private static const var_1512:int = 2;
        private static const var_1513:Array = [0, 0, 0];
        private static const var_1515:int = 3;

        private const var_4569:int = 0;
        private const var_4570:int = 1;
        private const var_4571:int = 2;
        private const var_4572:int = 3;
        private const var_4573:int = 4;

        private var var_4559:AvatarVisualizationData = null;
        private var var_4560:Map;
        private var var_4561:Map;
        private var var_4562:int = 0;
        private var var_3029:Boolean;
        private var var_2994:String;
        private var var_2938:String;
        private var var_4563:int = 0;
        private var var_4564:BitmapDataAsset;
        private var var_4565:BitmapDataAsset;
        private var var_4566:int = -1;
        private var var_4567:int = -1;
        private var var_4568:int = -1;
        private var var_4574:int = -1;
        private var var_4575:String = "";
        private var var_4576:String = "";
        private var var_4577:Boolean = false;
        private var var_3798:Boolean = false;
        private var var_4500:Boolean = false;
        private var var_4578:Boolean = false;
        private var var_3803:Boolean = false;
        private var var_3800:int = 0;
        private var _danceStyle:int = 0;
        private var var_4499:int = 0;
        private var var_4579:int = 0;
        private var var_4580:int = 0;
        private var var_4581:int = 0;
        private var var_4582:int = 0;
        private var var_4583:Boolean = false;
        private var var_4584:Boolean = false;
        private var var_4585:int = 0;
        private var var_4586:int = 0;
        private var var_4587:Boolean = false;
        private var var_4588:int = 0;
        private var var_4589:IAvatarImage = null;
        private var var_1023:Boolean;

        public function AvatarVisualization()
        {
            this.var_4560 = new Map();
            this.var_4561 = new Map();
            this.var_3029 = false;
        }

        override public function dispose():void
        {
            if (this.var_4560 != null)
            {
                this.resetImages();
                this.var_4560.dispose();
                this.var_4561.dispose();
                this.var_4560 = null;
            };
            this.var_4559 = null;
            this.var_4564 = null;
            this.var_4565 = null;
            super.dispose();
            this.var_1023 = true;
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        override public function initialize(param1:IRoomObjectVisualizationData):Boolean
        {
            this.var_4559 = (param1 as AvatarVisualizationData);
            createSprites(this.var_4573);
            return (true);
        }

        private function updateModel(param1:IRoomObjectModel, param2:Number, param3:Boolean):Boolean
        {
            var _loc4_:Boolean;
            var _loc5_:Boolean;
            var _loc6_:int;
            var _loc7_:String;
            var _loc8_:String;
            if (param1.getUpdateID() != var_1457)
            {
                _loc4_ = false;
                _loc5_ = false;
                _loc6_ = 0;
                _loc7_ = "";
                _loc5_ = ((param1.getNumber(RoomObjectVariableEnum.var_511) > 0) && (param3));
                if (_loc5_ != this.var_4577)
                {
                    this.var_4577 = _loc5_;
                    _loc4_ = true;
                };
                _loc5_ = (param1.getNumber(RoomObjectVariableEnum.var_512) > 0);
                if (_loc5_ != this.var_3798)
                {
                    this.var_3798 = _loc5_;
                    _loc4_ = true;
                };
                _loc5_ = (param1.getNumber(RoomObjectVariableEnum.var_513) > 0);
                if (_loc5_ != this.var_4500)
                {
                    this.var_4500 = _loc5_;
                    _loc4_ = true;
                };
                _loc5_ = ((param1.getNumber(RoomObjectVariableEnum.var_748) > 0) && (param3));
                if (_loc5_ != this.var_4578)
                {
                    this.var_4578 = _loc5_;
                    _loc4_ = true;
                };
                _loc5_ = (param1.getNumber(RoomObjectVariableEnum.var_514) > 0);
                if (_loc5_ != this.var_3803)
                {
                    this.var_3803 = _loc5_;
                    _loc4_ = true;
                    this.updateTypingBubble(param2);
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_750);
                if (_loc6_ != this.var_3800)
                {
                    this.var_3800 = _loc6_;
                    _loc4_ = true;
                };
                _loc7_ = param1.getString(RoomObjectVariableEnum.var_751);
                if (_loc7_ != this.var_4575)
                {
                    this.var_4575 = _loc7_;
                    _loc4_ = true;
                };
                _loc7_ = param1.getString(RoomObjectVariableEnum.var_752);
                if (_loc7_ != this.var_4576)
                {
                    this.var_4576 = _loc7_;
                    _loc4_ = true;
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_517);
                if (_loc6_ != this._danceStyle)
                {
                    this._danceStyle = _loc6_;
                    _loc4_ = true;
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_749);
                if (_loc6_ != this.var_4579)
                {
                    this.var_4579 = _loc6_;
                    _loc4_ = true;
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_515);
                if (_loc6_ != this.var_4580)
                {
                    this.var_4580 = _loc6_;
                    _loc4_ = true;
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_516);
                if (_loc6_ != this.var_4581)
                {
                    this.var_4581 = _loc6_;
                    _loc4_ = true;
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_510);
                if (_loc6_ != this.var_4566)
                {
                    this.var_4566 = _loc6_;
                    _loc4_ = true;
                };
                if (((this.var_4580 > 0) && (param1.getNumber(RoomObjectVariableEnum.var_516) > 0)))
                {
                    if (this.var_4581 != this.var_4580)
                    {
                        this.var_4581 = this.var_4580;
                        _loc4_ = true;
                    };
                }
                else
                {
                    if (this.var_4581 != 0)
                    {
                        this.var_4581 = 0;
                        _loc4_ = true;
                    };
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_519);
                if (_loc6_ != this.var_4585)
                {
                    this.var_4585 = _loc6_;
                    _loc4_ = true;
                    this.updateNumberBubble(param2);
                };
                this.validateActions(param2);
                _loc7_ = param1.getString(RoomObjectVariableEnum.AVATAR_GENDER);
                if (_loc7_ != this.var_2938)
                {
                    this.var_2938 = _loc7_;
                    _loc4_ = true;
                };
                _loc8_ = param1.getString(RoomObjectVariableEnum.var_522);
                if (this.updateFigure(_loc8_))
                {
                    _loc4_ = true;
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_520);
                if (_loc6_ != this.var_4499)
                {
                    _loc4_ = true;
                };
                var_1457 = param1.getUpdateID();
                return (_loc4_);
            };
            return (false);
        }

        private function updateFigure(param1:String):Boolean
        {
            if (this.var_2994 != param1)
            {
                this.var_2994 = param1;
                this.resetImages();
                return (true);
            };
            return (false);
        }

        private function resetImages():void
        {
            var _loc1_:IAvatarImage;
            var _loc2_:IRoomObjectSprite;
            for each (_loc1_ in this.var_4560)
            {
                if (_loc1_)
                {
                    _loc1_.dispose();
                };
            };
            for each (_loc1_ in this.var_4561)
            {
                if (_loc1_)
                {
                    _loc1_.dispose();
                };
            };
            this.var_4560.reset();
            this.var_4561.reset();
            this.var_4589 = null;
            _loc2_ = getSprite(this.var_4569);
            if (_loc2_ != null)
            {
                _loc2_.asset = null;
                _loc2_.alpha = 0xFF;
            };
        }

        private function validateActions(param1:Number):void
        {
            var _loc2_:int;
            if (param1 < 48)
            {
                this.var_4578 = false;
            };
            if (((this.var_4575 == "sit") || (this.var_4575 == "lay")))
            {
                this.var_4582 = (param1 / 2);
            }
            else
            {
                this.var_4582 = 0;
            };
            this.var_4584 = false;
            this.var_4583 = false;
            if (this.var_4575 == "lay")
            {
                this.var_4583 = true;
                _loc2_ = int(this.var_4576);
                if (_loc2_ < 0)
                {
                    this.var_4584 = true;
                };
            };
        }

        private function getAvatarImage(param1:Number, param2:int):IAvatarImage
        {
            var _loc3_:IAvatarImage;
            var _loc5_:IAvatarImage;
            var _loc4_:String = ("avatarImage" + param1.toString());
            if (param2 == 0)
            {
                _loc3_ = (this.var_4560.getValue(_loc4_) as IAvatarImage);
            }
            else
            {
                _loc4_ = (_loc4_ + ("-" + param2));
                _loc3_ = (this.var_4561.getValue(_loc4_) as IAvatarImage);
                if (_loc3_)
                {
                    _loc3_.forceActionUpdate();
                };
            };
            if (_loc3_ == null)
            {
                _loc3_ = this.var_4559.getAvatar(this.var_2994, param1, this.var_2938, this);
                if (_loc3_ != null)
                {
                    if (param2 == 0)
                    {
                        this.var_4560.add(_loc4_, _loc3_);
                    }
                    else
                    {
                        if (this.var_4561.length >= var_1515)
                        {
                            _loc5_ = this.var_4561.remove(this.var_4561.getKey(0));
                            if (_loc5_)
                            {
                                _loc5_.dispose();
                            };
                        };
                        this.var_4561.add(_loc4_, _loc3_);
                    };
                };
            };
            return (_loc3_);
        }

        private function updateObject(param1:IRoomObject, param2:IRoomGeometry, param3:Boolean, param4:Boolean=false):Boolean
        {
            var _loc5_:Boolean;
            var _loc6_:int;
            var _loc7_:int;
            if ((((param4) || (!(var_1455 == param1.getUpdateID()))) || (!(this.var_4574 == param2.updateId))))
            {
                _loc5_ = param3;
                _loc6_ = (param1.getDirection().x - param2.direction.x);
                _loc6_ = (((_loc6_ % 360) + 360) % 360);
                _loc7_ = this.var_4566;
                if (this.var_4575 == "float")
                {
                    _loc7_ = _loc6_;
                }
                else
                {
                    _loc7_ = (_loc7_ - param2.direction.x);
                };
                _loc7_ = (((_loc7_ % 360) + 360) % 360);
                if (((!(_loc6_ == this.var_4567)) || (param4)))
                {
                    _loc5_ = true;
                    this.var_4567 = _loc6_;
                    _loc6_ = (_loc6_ - (135 - 22.5));
                    _loc6_ = ((_loc6_ + 360) % 360);
                    this.var_4589.setDirectionAngle(AvatarSetType.var_129, _loc6_);
                };
                if (((!(_loc7_ == this.var_4568)) || (param4)))
                {
                    _loc5_ = true;
                    this.var_4568 = _loc7_;
                    if (this.var_4568 != this.var_4567)
                    {
                        _loc7_ = (_loc7_ - (135 - 22.5));
                        _loc7_ = ((_loc7_ + 360) % 360);
                        this.var_4589.setDirectionAngle(AvatarSetType.var_130, _loc7_);
                    };
                };
                var_1455 = param1.getUpdateID();
                this.var_4574 = param2.updateId;
                return (_loc5_);
            };
            return (false);
        }

        private function updateShadow(param1:Number):void
        {
            var _loc3_:int;
            var _loc4_:int;
            var _loc2_:IRoomObjectSprite = getSprite(this.var_4570);
            this.var_4564 = null;
            if (((this.var_4575 == "mv") || (this.var_4575 == "std")))
            {
                _loc2_.visible = true;
                if (((this.var_4564 == null) || (!(param1 == var_1456))))
                {
                    _loc3_ = 0;
                    _loc4_ = 0;
                    if (param1 < 48)
                    {
                        this.var_4564 = this.var_4589.getAsset("sh_std_sd_1_0_0");
                        _loc3_ = -8;
                        _loc4_ = -3;
                    }
                    else
                    {
                        this.var_4564 = this.var_4589.getAsset("h_std_sd_1_0_0");
                        _loc3_ = -17;
                        _loc4_ = -7;
                    };
                    if (this.var_4564 != null)
                    {
                        _loc2_.asset = (this.var_4564.content as BitmapData);
                        _loc2_.offsetX = _loc3_;
                        _loc2_.offsetY = _loc4_;
                        _loc2_.alpha = 50;
                        _loc2_.relativeDepth = 1;
                    }
                    else
                    {
                        _loc2_.visible = false;
                    };
                };
            }
            else
            {
                this.var_4564 = null;
                _loc2_.visible = false;
            };
        }

        private function updateTypingBubble(param1:Number):void
        {
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int;
            this.var_4565 = null;
            var _loc2_:IRoomObjectSprite = getSprite(this.var_4571);
            if (this.var_3803)
            {
                _loc2_.visible = true;
                _loc5_ = 64;
                if (param1 < 48)
                {
                    this.var_4565 = (this.var_4559.getAvatarRendererAsset("user_typing_small_png") as BitmapDataAsset);
                    _loc3_ = 3;
                    _loc4_ = -42;
                    _loc5_ = 32;
                }
                else
                {
                    this.var_4565 = (this.var_4559.getAvatarRendererAsset("user_typing_png") as BitmapDataAsset);
                    _loc3_ = 14;
                    _loc4_ = -83;
                };
                if (this.var_4575 == "sit")
                {
                    _loc4_ = int((_loc4_ + (_loc5_ / 2)));
                }
                else
                {
                    if (this.var_4575 == "lay")
                    {
                        _loc4_ = (_loc4_ + _loc5_);
                    };
                };
                if (this.var_4565 != null)
                {
                    _loc2_.asset = (this.var_4565.content as BitmapData);
                    _loc2_.offsetX = _loc3_;
                    _loc2_.offsetY = _loc4_;
                    _loc2_.relativeDepth = (-0.02 + 0);
                };
            }
            else
            {
                _loc2_.visible = false;
            };
        }

        private function updateNumberBubble(param1:Number):void
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:int;
            var _loc2_:BitmapDataAsset;
            var _loc3_:IRoomObjectSprite = getSprite(this.var_4572);
            if (this.var_4585 > 0)
            {
                _loc6_ = 64;
                if (param1 < 48)
                {
                    _loc2_ = (this.var_4559.getAvatarRendererAsset((("number_" + this.var_4585) + "_small_png")) as BitmapDataAsset);
                    _loc4_ = -6;
                    _loc5_ = -52;
                    _loc6_ = 32;
                }
                else
                {
                    _loc2_ = (this.var_4559.getAvatarRendererAsset((("number_" + this.var_4585) + "_png")) as BitmapDataAsset);
                    _loc4_ = -8;
                    _loc5_ = -105;
                };
                if (this.var_4575 == "sit")
                {
                    _loc5_ = int((_loc5_ + (_loc6_ / 2)));
                }
                else
                {
                    if (this.var_4575 == "lay")
                    {
                        _loc5_ = (_loc5_ + _loc6_);
                    };
                };
                if (_loc2_ != null)
                {
                    _loc3_.visible = true;
                    _loc3_.asset = (_loc2_.content as BitmapData);
                    _loc3_.offsetX = _loc4_;
                    _loc3_.offsetY = _loc5_;
                    _loc3_.relativeDepth = -0.01;
                    this.var_4586 = 1;
                    this.var_4587 = true;
                    this.var_4588 = 0;
                    _loc3_.alpha = 0;
                }
                else
                {
                    _loc3_.visible = false;
                };
            }
            else
            {
                if (_loc3_.visible)
                {
                    this.var_4586 = -1;
                };
            };
        }

        private function animateNumberBubble(param1:int):Boolean
        {
            var _loc5_:int;
            var _loc2_:IRoomObjectSprite = getSprite(this.var_4572);
            var _loc3_:int = _loc2_.alpha;
            var _loc4_:Boolean;
            if (this.var_4587)
            {
                this.var_4588++;
                if (this.var_4588 < 10)
                {
                    return (false);
                };
                if (this.var_4586 < 0)
                {
                    if (param1 < 48)
                    {
                        _loc2_.offsetY = (_loc2_.offsetY - 2);
                    }
                    else
                    {
                        _loc2_.offsetY = (_loc2_.offsetY - 4);
                    };
                }
                else
                {
                    _loc5_ = 4;
                    if (param1 < 48)
                    {
                        _loc5_ = 8;
                    };
                    if ((this.var_4588 % _loc5_) == 0)
                    {
                        _loc2_.offsetY--;
                        _loc4_ = true;
                    };
                };
            };
            if (this.var_4586 > 0)
            {
                if (_loc3_ < 0xFF)
                {
                    _loc3_ = (_loc3_ + 32);
                };
                if (_loc3_ >= 0xFF)
                {
                    _loc3_ = 0xFF;
                    this.var_4586 = 0;
                };
                _loc2_.alpha = _loc3_;
                return (true);
            };
            if (this.var_4586 < 0)
            {
                if (_loc3_ >= 0)
                {
                    _loc3_ = (_loc3_ - 32);
                };
                if (_loc3_ <= 0)
                {
                    this.var_4586 = 0;
                    this.var_4587 = false;
                    _loc3_ = 0;
                    _loc2_.visible = false;
                };
                _loc2_.alpha = _loc3_;
                return (true);
            };
            return (_loc4_);
        }

        override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean):void
        {
            var _loc16_:IRoomObjectSprite;
            var _loc17_:IRoomObjectSprite;
            var _loc18_:Array;
            var _loc19_:int;
            var _loc20_:ISpriteDataContainer;
            var _loc21_:BitmapData;
            var _loc22_:IAnimationLayerData;
            var _loc23_:int;
            var _loc24_:int;
            var _loc25_:IAnimationLayerData;
            var _loc26_:int;
            var _loc27_:int;
            var _loc28_:int;
            var _loc29_:int;
            var _loc30_:int;
            var _loc31_:String;
            var _loc32_:BitmapDataAsset;
            var _loc5_:IRoomObject = object;
            if (_loc5_ == null)
            {
                return;
            };
            if (param1 == null)
            {
                return;
            };
            if (this.var_4559 == null)
            {
                return;
            };
            var _loc6_:IRoomObjectModel = _loc5_.getModel();
            var _loc7_:Number = param1.scale;
            var _loc8_:Boolean;
            var _loc9_:Boolean;
            var _loc10_:Boolean;
            var _loc11_:int = this.var_4579;
            var _loc12_:Boolean;
            var _loc13_:Boolean = this.updateModel(_loc6_, _loc7_, param3);
            if (this.animateNumberBubble(_loc7_))
            {
                increaseUpdateId();
            };
            if ((((_loc13_) || (!(_loc7_ == var_1456))) || (this.var_4589 == null)))
            {
                if (_loc7_ != var_1456)
                {
                    _loc9_ = true;
                    this.validateActions(_loc7_);
                };
                if (_loc11_ != this.var_4579)
                {
                    _loc12_ = true;
                };
                if ((((_loc9_) || (this.var_4589 == null)) || (_loc12_)))
                {
                    this.var_4589 = this.getAvatarImage(_loc7_, this.var_4579);
                    if (this.var_4589 == null)
                    {
                        return;
                    };
                    _loc8_ = true;
                    _loc16_ = getSprite(this.var_4569);
                    if ((((_loc16_) && (this.var_4589)) && (this.var_4589.isPlaceholder())))
                    {
                        _loc16_.alpha = 150;
                    }
                    else
                    {
                        if (_loc16_)
                        {
                            _loc16_.alpha = 0xFF;
                        };
                    };
                };
                if (this.var_4589 == null)
                {
                    return;
                };
                this.updateShadow(_loc7_);
                if (_loc9_)
                {
                    this.updateTypingBubble(_loc7_);
                    this.updateNumberBubble(_loc7_);
                };
                _loc10_ = this.updateObject(_loc5_, param1, param3, true);
                this.updateActions(this.var_4589);
                var_1456 = _loc7_;
            }
            else
            {
                _loc10_ = this.updateObject(_loc5_, param1, param3);
            };
            var _loc14_:Boolean = (((_loc10_) || (_loc13_)) || (_loc9_));
            var _loc15_:Boolean = (((this.var_3029) || (this.var_4563 > 0)) && (param3));
            if (_loc14_)
            {
                this.var_4563 = var_1512;
            };
            if (((_loc14_) || (_loc15_)))
            {
                increaseUpdateId();
                this.var_4563--;
                this.var_4562--;
                if (((((this.var_4562 <= 0) || (_loc9_)) || (_loc13_)) || (_loc8_)))
                {
                    this.var_4589.updateAnimationByFrames(1);
                    this.var_4562 = var_1512;
                }
                else
                {
                    return;
                };
                _loc18_ = this.var_4589.getCanvasOffsets();
                if (((_loc18_ == null) || (_loc18_.length < 3)))
                {
                    _loc18_ = var_1513;
                };
                _loc17_ = getSprite(this.var_4569);
                if (_loc17_ != null)
                {
                    _loc21_ = this.var_4589.getImage(AvatarSetType.var_129, false);
                    if (_loc21_ != null)
                    {
                        _loc17_.asset = _loc21_;
                    };
                    if (_loc17_.asset)
                    {
                        _loc17_.offsetX = (((-1 * _loc7_) / 2) + _loc18_[0]);
                        _loc17_.offsetY = (((-(_loc17_.asset.height) + (_loc7_ / 4)) + _loc18_[1]) + this.var_4582);
                    };
                    if (this.var_4583)
                    {
                        if (this.var_4584)
                        {
                            _loc17_.relativeDepth = -0.5;
                        }
                        else
                        {
                            _loc17_.relativeDepth = (var_1516 + _loc18_[2]);
                        };
                    }
                    else
                    {
                        _loc17_.relativeDepth = (var_1517 + _loc18_[2]);
                    };
                };
                _loc17_ = getSprite(this.var_4571);
                if (((!(_loc17_ == null)) && (_loc17_.visible)))
                {
                    if (!this.var_4583)
                    {
                        _loc17_.relativeDepth = ((var_1517 - 0.01) + _loc18_[2]);
                    }
                    else
                    {
                        _loc17_.relativeDepth = ((var_1516 - 0.01) + _loc18_[2]);
                    };
                };
                this.var_3029 = this.var_4589.isAnimating();
                _loc19_ = this.var_4573;
                for each (_loc20_ in this.var_4589.getSprites())
                {
                    if (_loc20_.id == var_1518)
                    {
                        _loc17_ = getSprite(this.var_4569);
                        _loc22_ = this.var_4589.getLayerData(_loc20_);
                        _loc23_ = _loc20_.getDirectionOffsetX(this.var_4589.getDirection());
                        _loc24_ = _loc20_.getDirectionOffsetY(this.var_4589.getDirection());
                        if (_loc22_ != null)
                        {
                            _loc23_ = (_loc23_ + _loc22_.dx);
                            _loc24_ = (_loc24_ + _loc22_.dy);
                        };
                        if (_loc7_ < 48)
                        {
                            _loc23_ = int((_loc23_ / 2));
                            _loc24_ = int((_loc24_ / 2));
                        };
                        _loc17_.offsetX = (_loc17_.offsetX + _loc23_);
                        _loc17_.offsetY = (_loc17_.offsetY + _loc24_);
                    }
                    else
                    {
                        _loc17_ = getSprite(_loc19_);
                        if (_loc17_ != null)
                        {
                            _loc17_.capturesMouse = false;
                            _loc17_.visible = true;
                            _loc25_ = this.var_4589.getLayerData(_loc20_);
                            _loc26_ = 0;
                            _loc27_ = _loc20_.getDirectionOffsetX(this.var_4589.getDirection());
                            _loc28_ = _loc20_.getDirectionOffsetY(this.var_4589.getDirection());
                            _loc29_ = _loc20_.getDirectionOffsetZ(this.var_4589.getDirection());
                            _loc30_ = 0;
                            if (_loc20_.hasDirections)
                            {
                                _loc30_ = this.var_4589.getDirection();
                            };
                            if (_loc25_ != null)
                            {
                                _loc26_ = _loc25_.animationFrame;
                                _loc27_ = (_loc27_ + _loc25_.dx);
                                _loc28_ = (_loc28_ + _loc25_.dy);
                                _loc30_ = (_loc30_ + _loc25_.directionOffset);
                            };
                            if (_loc7_ < 48)
                            {
                                _loc27_ = int((_loc27_ / 2));
                                _loc28_ = int((_loc28_ / 2));
                            };
                            if (_loc30_ < 0)
                            {
                                _loc30_ = (_loc30_ + 8);
                            }
                            else
                            {
                                if (_loc30_ > 7)
                                {
                                    _loc30_ = (_loc30_ - 8);
                                };
                            };
                            _loc31_ = ((((((this.var_4589.getScale() + "_") + _loc20_.member) + "_") + _loc30_) + "_") + _loc26_);
                            _loc32_ = this.var_4589.getAsset(_loc31_);
                            if (_loc32_ == null) continue;
                            _loc17_.asset = (_loc32_.content as BitmapData);
                            _loc17_.offsetX = ((-(_loc32_.offset.x) - (_loc7_ / 2)) + _loc27_);
                            _loc17_.offsetY = ((-(_loc32_.offset.y) + _loc28_) + this.var_4582);
                            if (this.var_4583)
                            {
                                _loc17_.relativeDepth = (var_1516 - ((0.001 * spriteCount) * _loc29_));
                            }
                            else
                            {
                                _loc17_.relativeDepth = (var_1517 - ((0.001 * spriteCount) * _loc29_));
                            };
                            if (_loc20_.ink == 33)
                            {
                                _loc17_.blendMode = BlendMode.ADD;
                            }
                            else
                            {
                                _loc17_.blendMode = BlendMode.NORMAL;
                            };
                        };
                        _loc19_++;
                    };
                };
            };
        }

        private function updateActions(param1:IAvatarImage):void
        {
            var _loc3_:ISpriteDataContainer;
            if (param1 == null)
            {
                return;
            };
            param1.initActionAppends();
            param1.appendAction(AvatarAction.var_1015, this.var_4575, this.var_4576);
            if (this.var_3800 > 0)
            {
                param1.appendAction(AvatarAction.var_1016, AvatarAction.var_1519[this.var_3800]);
            };
            if (this._danceStyle > 0)
            {
                param1.appendAction(AvatarAction.var_377, this._danceStyle);
            };
            if (this.var_4499 > 0)
            {
                param1.appendAction(AvatarAction.var_1028, this.var_4499);
            };
            if (this.var_4580 > 0)
            {
                param1.appendAction(AvatarAction.var_1029, this.var_4580);
            };
            if (this.var_4581 > 0)
            {
                param1.appendAction(AvatarAction.var_1030, this.var_4581);
            };
            if (this.var_4577)
            {
                param1.appendAction(AvatarAction.var_1017);
            };
            if (((this.var_4500) || (this.var_4578)))
            {
                param1.appendAction(AvatarAction.var_1020);
            };
            if (this.var_3798)
            {
                param1.appendAction(AvatarAction.var_1018);
            };
            if (this.var_4579 > 0)
            {
                param1.appendAction(AvatarAction.var_1019, this.var_4579);
            };
            param1.endActionAppends();
            this.var_3029 = param1.isAnimating();
            var _loc2_:int = this.var_4573;
            for each (_loc3_ in this.var_4589.getSprites())
            {
                if (_loc3_.id != var_1518)
                {
                    _loc2_++;
                };
            };
            if (_loc2_ != spriteCount)
            {
                createSprites(_loc2_);
            };
        }

        public function avatarImageReady(param1:String):void
        {
            this.resetImages();
        }


    }
}