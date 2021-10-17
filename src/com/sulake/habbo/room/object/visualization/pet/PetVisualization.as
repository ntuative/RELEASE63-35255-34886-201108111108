package com.sulake.habbo.room.object.visualization.pet
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.habbo.avatar.IPetImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.IAvatarImage;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import flash.display.BlendMode;

    public class PetVisualization extends RoomObjectSpriteVisualization implements IPetImageListener 
    {

        private static const var_1512:int = 2;
        private static const var_1513:Array = [0, 0, 0];

        private const var_4742:int = 3;
        private const var_4569:int = 0;
        private const var_4570:int = 1;
        private const var_4571:int = 2;
        private const var_4573:int = 3;

        private var var_4559:PetVisualizationData = null;
        private var var_4560:Map;
        private var var_4562:int = 0;
        private var var_1094:int = 0;
        private var var_3029:Boolean;
        private var var_2994:String;
        private var var_4563:int = 0;
        private var _updateTimes:Array;
        private var var_4564:BitmapDataAsset;
        private var var_4730:ExperienceData;
        private var var_1023:Boolean = false;
        private var var_4741:Boolean = false;
        private var var_4574:int = -1;
        private var var_4589:IAvatarImage = null;
        private var var_4575:String = "";
        private var var_4576:String = "";
        private var var_4500:Boolean = false;
        private var var_4578:Boolean = false;
        private var var_4584:Boolean = false;
        private var var_4583:Boolean = false;
        private var var_4743:Boolean = false;
        private var var_3800:String = "";
        private var var_4731:int = 0;
        private var var_3836:int = 0;
        private var var_4566:Number = NaN;
        private var var_4567:int = -1;
        private var var_4568:int = -1;

        public function PetVisualization()
        {
            this._updateTimes = new Array();
            this.var_4560 = new Map();
            this.var_3029 = false;
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        override public function dispose():void
        {
            var _loc1_:Array;
            var _loc2_:String;
            var _loc3_:IAvatarImage;
            super.dispose();
            if (this.var_4560 != null)
            {
                _loc1_ = this.var_4560.getKeys();
                for each (_loc2_ in _loc1_)
                {
                    _loc3_ = (this.var_4560.getValue(_loc2_) as IAvatarImage);
                    _loc3_.dispose();
                };
            };
            this.var_4560.dispose();
            if (this.var_4730)
            {
                this.var_4730.dispose();
            };
            this.var_4730 = null;
            this.var_4559 = null;
            this.var_1023 = true;
        }

        override public function initialize(param1:IRoomObjectVisualizationData):Boolean
        {
            this.var_4559 = (param1 as PetVisualizationData);
            createSprites(this.var_4573);
            var _loc2_:BitmapData = ((this.var_4559.getAvatarRendererAsset("pet_experience_bubble_png") as BitmapDataAsset).content as BitmapData);
            this.var_4730 = new ExperienceData(_loc2_.clone());
            return (true);
        }

        private function updateModel(param1:IRoomObjectModel, param2:Number):Boolean
        {
            var _loc3_:String;
            if (param1.getUpdateID() != var_1457)
            {
                this.var_4500 = (param1.getNumber(RoomObjectVariableEnum.var_513) > 0);
                this.var_3800 = param1.getString(RoomObjectVariableEnum.var_750);
                this.var_4575 = param1.getString(RoomObjectVariableEnum.var_751);
                this.var_4576 = param1.getString(RoomObjectVariableEnum.var_752);
                this.var_4566 = param1.getNumber(RoomObjectVariableEnum.var_510);
                this.var_4731 = param1.getNumber(RoomObjectVariableEnum.AVATAR_EXPERIENCE_TIMESTAMP);
                this.var_3836 = param1.getNumber(RoomObjectVariableEnum.var_518);
                this.validateActions();
                _loc3_ = param1.getString(RoomObjectVariableEnum.var_522);
                if (this.var_2994 != _loc3_)
                {
                    this.var_2994 = _loc3_;
                    this.resetAvatarImages();
                };
                var_1457 = param1.getUpdateID();
                return (true);
            };
            return (false);
        }

        private function resetAvatarImages():void
        {
            var _loc1_:IAvatarImage;
            for each (_loc1_ in this.var_4560)
            {
                if (_loc1_)
                {
                    _loc1_.dispose();
                };
            };
            this.var_4560.reset();
            this.var_4589 = null;
        }

        private function validateActions():void
        {
            var _loc1_:int;
            this.var_4743 = false;
            switch (this.var_4575)
            {
                case AvatarAction.var_992:
                case AvatarAction.var_994:
                case AvatarAction.var_995:
                case AvatarAction.var_999:
                case AvatarAction.var_1000:
                case AvatarAction.var_1003:
                case AvatarAction.var_1004:
                case AvatarAction.var_1017:
                case AvatarAction.var_1018:
                    this.var_4743 = true;
                    break;
            };
            this.var_4584 = false;
            this.var_4583 = false;
            if (this.var_4575 == "lay")
            {
                this.var_4583 = true;
                _loc1_ = int(this.var_4576);
                if (_loc1_ < 0)
                {
                    this.var_4584 = true;
                };
            };
        }

        private function updateObject(param1:IRoomObject, param2:IRoomGeometry, param3:Boolean=false):Boolean
        {
            var _loc4_:int;
            var _loc5_:int;
            if ((((param3) || (!(var_1455 == param1.getUpdateID()))) || (!(this.var_4574 == param2.updateId))))
            {
                _loc4_ = (param1.getDirection().x - param2.direction.x);
                _loc4_ = (((_loc4_ % 360) + 360) % 360);
                _loc5_ = this.var_4566;
                if (isNaN(this.var_4566))
                {
                    _loc5_ = _loc4_;
                }
                else
                {
                    _loc5_ = (_loc5_ - param2.direction.x);
                    _loc5_ = (((_loc5_ % 360) + 360) % 360);
                };
                if (((!(_loc4_ == this.var_4567)) || (param3)))
                {
                    this.var_4567 = _loc4_;
                    _loc4_ = (_loc4_ - (135 - 22.5));
                    _loc4_ = ((_loc4_ + 360) % 360);
                    this.var_4589.setDirectionAngle(AvatarSetType.var_129, _loc4_);
                };
                if (((!(_loc5_ == this.var_4568)) || (param3)))
                {
                    this.var_4568 = _loc5_;
                    _loc5_ = (_loc5_ - (135 - 22.5));
                    _loc5_ = ((_loc5_ + 360) % 360);
                    this.var_4589.setDirectionAngle(AvatarSetType.var_130, _loc5_);
                };
                var_1455 = param1.getUpdateID();
                this.var_4574 = param2.updateId;
                return (true);
            };
            return (false);
        }

        private function getAvatarImage(param1:Number):IAvatarImage
        {
            var _loc2_:String = ("avatarImage" + param1.toString());
            var _loc3_:IAvatarImage = (this.var_4560.getValue(_loc2_) as IAvatarImage);
            if (_loc3_ == null)
            {
                _loc3_ = this.var_4559.getAvatar(this.var_2994, param1, this);
                if (_loc3_ != null)
                {
                    this.var_4560.add(_loc2_, _loc3_);
                };
            };
            return (_loc3_);
        }

        private function updateShadow(param1:Number):void
        {
            var _loc2_:IRoomObjectSprite = getSprite(this.var_4570);
            this.var_4564 = null;
            _loc2_ = getSprite(this.var_4570);
            var _loc3_:int;
            var _loc4_:int;
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
            if (this.var_4564)
            {
                _loc2_.asset = (this.var_4564.content as BitmapData);
                _loc2_.offsetX = _loc3_;
                _loc2_.offsetY = _loc4_;
                _loc2_.alpha = 50;
                _loc2_.relativeDepth = 0.005;
            }
            else
            {
                _loc2_.asset = null;
            };
        }

        override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean):void
        {
            var _loc13_:int;
            var _loc14_:IRoomObjectSprite;
            var _loc15_:Array;
            var _loc16_:int;
            var _loc17_:int;
            var _loc18_:ISpriteDataContainer;
            var _loc19_:BitmapData;
            var _loc20_:IAnimationLayerData;
            var _loc21_:int;
            var _loc22_:int;
            var _loc23_:int;
            var _loc24_:int;
            var _loc25_:int;
            var _loc26_:String;
            var _loc27_:BitmapDataAsset;
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
            if (this.var_4741)
            {
                this.var_4741 = false;
                this.var_4562 = 0;
                this.var_4563 = 1;
                this.resetAvatarImages();
            };
            var _loc7_:Number = param1.scale;
            var _loc8_:Boolean;
            var _loc9_:Boolean;
            var _loc10_:Boolean = this.updateModel(_loc6_, _loc7_);
            if ((((_loc10_) || (!(_loc7_ == var_1456))) || (this.var_4589 == null)))
            {
                if (_loc7_ != var_1456)
                {
                    var_1456 = _loc7_;
                    _loc8_ = true;
                };
                if (((_loc8_) || (this.var_4589 == null)))
                {
                    this.var_4589 = this.getAvatarImage(_loc7_);
                };
                if (this.var_4589 == null)
                {
                    return;
                };
                if (_loc8_)
                {
                    this.updateShadow(_loc7_);
                };
                _loc9_ = this.updateObject(_loc5_, param1, true);
                this.updateActions(this.var_4589);
            }
            else
            {
                _loc9_ = this.updateObject(_loc5_, param1);
            };
            var _loc11_:Boolean = (((_loc9_) || (_loc10_)) || (_loc8_));
            var _loc12_:Boolean = (((this.var_3029) || (this.var_4563 > 0)) || (this.var_4743));
            this.var_4730.alpha = 0;
            if (this.var_4731 > 0)
            {
                _loc13_ = (param2 - this.var_4731);
                if (_loc13_ < AvatarAction.var_1463)
                {
                    this.var_4730.alpha = int((Math.sin(((_loc13_ / AvatarAction.var_1463) * Math.PI)) * 0xFF));
                    this.var_4730.setExperience(this.var_3836);
                    this.var_4563 = this.var_4742;
                }
                else
                {
                    this.var_4731 = 0;
                };
                _loc14_ = getSprite(this.var_4571);
                if (_loc14_ != null)
                {
                    if (this.var_4730.alpha > 0)
                    {
                        _loc14_.asset = this.var_4730.image;
                        _loc14_.offsetX = -20;
                        _loc14_.offsetY = -80;
                        _loc14_.alpha = this.var_4730.alpha;
                        _loc14_.visible = true;
                    }
                    else
                    {
                        _loc14_.asset = null;
                        _loc14_.visible = false;
                    };
                };
            };
            if (((_loc11_) || (_loc12_)))
            {
                increaseUpdateId();
                this.var_4563--;
                this.var_1094++;
                this.var_4562--;
                if (((this.var_4562 <= 0) || (_loc8_)))
                {
                    this.var_4589.updateAnimationByFrames(1);
                    this.var_4562 = var_1512;
                }
                else
                {
                    return;
                };
                this.var_3029 = this.var_4589.isAnimating();
                _loc15_ = this.var_4589.getCanvasOffsets();
                if (((_loc15_ == null) || (_loc15_.length < 3)))
                {
                    _loc15_ = var_1513;
                };
                _loc16_ = 0;
                if (object.getLocation().z > 0)
                {
                    _loc16_ = int(Math.min((_loc7_ / 2.75), 0));
                };
                _loc14_ = getSprite(this.var_4569);
                if (_loc14_)
                {
                    _loc19_ = this.var_4589.getImage(AvatarSetType.var_129, false);
                    if (_loc19_ != null)
                    {
                        _loc14_.asset = _loc19_;
                    };
                    if (_loc7_ < 48)
                    {
                        _loc14_.offsetX = ((-32 / 2) + _loc15_[0]);
                        _loc14_.offsetY = (((-(_loc14_.asset.height) + (32 / 4)) + _loc15_[1]) + _loc16_);
                    }
                    else
                    {
                        _loc14_.offsetX = ((-64 / 2) + _loc15_[0]);
                        _loc14_.offsetY = (((-(_loc14_.asset.height) + (64 / 4)) + _loc15_[1]) + _loc16_);
                    };
                };
                _loc17_ = this.var_4573;
                for each (_loc18_ in this.var_4589.getSprites())
                {
                    _loc14_ = getSprite(_loc17_);
                    if (_loc14_ != null)
                    {
                        _loc20_ = this.var_4589.getLayerData(_loc18_);
                        _loc21_ = 0;
                        _loc22_ = _loc18_.getDirectionOffsetX(this.var_4589.getDirection());
                        _loc23_ = _loc18_.getDirectionOffsetY(this.var_4589.getDirection());
                        _loc24_ = _loc18_.getDirectionOffsetZ(this.var_4589.getDirection());
                        _loc25_ = 0;
                        if (_loc18_.hasDirections)
                        {
                            _loc25_ = this.var_4589.getDirection();
                        };
                        if (_loc20_ != null)
                        {
                            _loc21_ = _loc20_.animationFrame;
                            _loc22_ = (_loc22_ + _loc20_.dx);
                            _loc23_ = (_loc23_ + _loc20_.dy);
                            _loc25_ = (_loc25_ + _loc20_.directionOffset);
                        };
                        if (_loc7_ < 48)
                        {
                            _loc22_ = int((_loc22_ / 2));
                            _loc23_ = int((_loc23_ / 2));
                        };
                        if (_loc25_ < 0)
                        {
                            _loc25_ = (_loc25_ + 8);
                        };
                        if (_loc25_ > 7)
                        {
                            _loc25_ = (_loc25_ - 8);
                        };
                        _loc26_ = ((((((this.var_4589.getScale() + "_") + _loc18_.member) + "_") + _loc25_) + "_") + _loc21_);
                        _loc27_ = this.var_4589.getAsset(_loc26_);
                        if (_loc27_ != null)
                        {
                            _loc14_.asset = (_loc27_.content as BitmapData);
                            _loc14_.offsetX = (((-1 * _loc27_.offset.x) - (_loc7_ / 2)) + _loc22_);
                            _loc14_.offsetY = ((-1 * _loc27_.offset.y) + _loc23_);
                            _loc14_.relativeDepth = (-0.01 - ((0.1 * _loc17_) * _loc24_));
                            if (_loc18_.ink == 33)
                            {
                                _loc14_.blendMode = BlendMode.ADD;
                            }
                            else
                            {
                                _loc14_.blendMode = BlendMode.NORMAL;
                            };
                            _loc17_++;
                        };
                    };
                };
            };
        }

        private function updateActions(param1:IAvatarImage):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.initActionAppends();
            param1.appendAction(AvatarAction.var_1015, this.var_4575, this.var_4576);
            if (((!(this.var_3800 == null)) && (!(this.var_3800 == ""))))
            {
                param1.appendAction(AvatarAction.var_1016, this.var_3800);
            };
            if (((this.var_4500) || (this.var_4578)))
            {
                param1.appendAction(AvatarAction.var_1020);
            };
            param1.endActionAppends();
            var _loc2_:int = (param1.getSprites().length + this.var_4573);
            if (_loc2_ != spriteCount)
            {
                createSprites(_loc2_);
            };
        }

        public function imageReady():void
        {
            this.var_4741 = true;
        }

        public function petImageReady(param1:String):void
        {
            this.resetAvatarImages();
        }


    }
}