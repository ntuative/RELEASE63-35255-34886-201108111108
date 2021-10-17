package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import com.sulake.habbo.room.object.visualization.data.LayerData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.object.visualization.data.ColorData;

    public class FurnitureVisualization extends RoomObjectSpriteVisualization 
    {

        protected static const var_1452:Number = Math.sqrt(0.5);

        private var _direction:int;
        private var var_4696:Number = NaN;
        private var var_4697:int = -1;
        private var _alphaMultiplier:Number = 1;
        private var var_2820:String = null;
        private var var_4698:Boolean = false;
        private var _data:FurnitureVisualizationData = null;
        private var _type:String = "";
        private var var_4699:Array = [];
        private var var_4700:Array = [];
        private var var_4701:Number = 0;
        private var var_4702:int = -1;
        private var var_4703:int = -1;
        private var var_4704:Array = [];
        private var var_4705:Array = [];
        private var var_4706:Array = [];
        private var var_4707:Array = [];
        private var var_4708:Array = [];
        private var var_4709:Array = [];
        private var var_4710:Array = [];
        private var var_4711:Array = [];
        private var var_4712:Boolean = true;
        private var var_4613:int = 0;
        private var var_4713:int = -1;
        private var var_4714:int = 0;
        private var var_4715:Number = 0;

        public function FurnitureVisualization()
        {
            this.reset();
        }

        protected function set direction(param1:int):void
        {
            this._direction = param1;
        }

        protected function get direction():int
        {
            return (this._direction);
        }

        protected function get type():String
        {
            return (this._type);
        }

        override public function dispose():void
        {
            super.dispose();
            this._data = null;
            this.var_4699 = null;
            this.var_4700 = null;
            this.var_4704 = null;
            this.var_4705 = null;
            this.var_4706 = null;
            this.var_4707 = null;
            this.var_4708 = null;
            this.var_4709 = null;
            this.var_4710 = null;
            this.var_4711 = null;
        }

        override protected function reset():void
        {
            super.reset();
            this.direction = -1;
            this._data = null;
            this.var_4699 = [];
            this.var_4700 = [];
            this.var_4704 = [];
            this.var_4705 = [];
            this.var_4706 = [];
            this.var_4707 = [];
            this.var_4708 = [];
            this.var_4709 = [];
            this.var_4710 = [];
            this.var_4711 = [];
            this.createSprites(0);
        }

        override public function initialize(param1:IRoomObjectVisualizationData):Boolean
        {
            this.reset();
            if (((param1 == null) || (!(param1 is FurnitureVisualizationData))))
            {
                return (false);
            };
            this._data = (param1 as FurnitureVisualizationData);
            this._type = this._data.getType();
            return (true);
        }

        override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc5_:Boolean;
            var _loc6_:Number = param1.scale;
            if (this.updateObject(_loc6_, param1.direction.x))
            {
                _loc5_ = true;
            };
            if (this.updateModel(_loc6_))
            {
                _loc5_ = true;
            };
            var _loc7_:int;
            if (param4)
            {
                this.var_4714 = (this.var_4714 | this.updateAnimation(_loc6_));
            }
            else
            {
                _loc7_ = (this.updateAnimation(_loc6_) | this.var_4714);
                this.var_4714 = 0;
            };
            if (((_loc5_) || (!(_loc7_ == 0))))
            {
                this.updateSprites(_loc6_, _loc5_, _loc7_);
                var_1456 = _loc6_;
                increaseUpdateId();
            };
        }

        protected function updateSprites(param1:int, param2:Boolean, param3:int):void
        {
            var _loc4_:int;
            var _loc5_:int;
            if (this.var_4613 != spriteCount)
            {
                createSprites(this.var_4613);
            };
            if (param2)
            {
                _loc4_ = (spriteCount - 1);
                while (_loc4_ >= 0)
                {
                    this.updateSprite(param1, _loc4_);
                    _loc4_--;
                };
            }
            else
            {
                _loc5_ = 0;
                while (param3 > 0)
                {
                    if ((param3 & 0x01))
                    {
                        this.updateSprite(param1, _loc5_);
                    };
                    _loc5_++;
                    param3 = (param3 >> 1);
                };
            };
            this.var_4712 = false;
        }

        private function updateSprite(param1:int, param2:int):void
        {
            var _loc5_:IGraphicAsset;
            var _loc6_:Number;
            var _loc7_:int;
            var _loc3_:String = this.getSpriteAssetName(param1, param2);
            var _loc4_:IRoomObjectSprite = getSprite(param2);
            if (((!(_loc4_ == null)) && (!(_loc3_ == null))))
            {
                _loc5_ = this.getAsset(_loc3_);
                if (((!(_loc5_ == null)) && (!(_loc5_.asset == null))))
                {
                    _loc4_.visible = true;
                    _loc4_.asset = (_loc5_.asset.content as BitmapData);
                    _loc4_.flipH = _loc5_.flipH;
                    _loc4_.flipV = _loc5_.flipV;
                    _loc6_ = 0;
                    if (param2 != this.var_4713)
                    {
                        _loc4_.tag = this.getSpriteTag(param1, this._direction, param2);
                        _loc4_.alpha = this.getSpriteAlpha(param1, this._direction, param2);
                        _loc4_.color = this.getSpriteColor(param1, param2, this.var_4697);
                        _loc4_.offsetX = (_loc5_.offsetX + this.getSpriteXOffset(param1, this._direction, param2));
                        _loc4_.offsetY = (_loc5_.offsetY + this.getSpriteYOffset(param1, this._direction, param2));
                        _loc4_.capturesMouse = this.getSpriteMouseCapture(param1, this._direction, param2);
                        _loc4_.blendMode = this.getBlendMode(this.getSpriteInk(param1, this._direction, param2));
                        _loc6_ = this.getSpriteZOffset(param1, this._direction, param2);
                        _loc6_ = (_loc6_ - (param2 * 0.001));
                    }
                    else
                    {
                        _loc4_.offsetX = _loc5_.offsetX;
                        _loc4_.offsetY = (_loc5_.offsetY + this.getSpriteYOffset(param1, this._direction, param2));
                        _loc7_ = 48;
                        _loc7_ = (_loc7_ * this._alphaMultiplier);
                        _loc4_.alpha = _loc7_;
                        _loc4_.capturesMouse = false;
                        _loc6_ = 1;
                    };
                    _loc6_ = (_loc6_ * var_1452);
                    _loc4_.relativeDepth = _loc6_;
                    _loc4_.assetName = _loc5_.assetName;
                    _loc4_.clickHandling = this.var_4698;
                }
                else
                {
                    this.resetSprite(_loc4_);
                };
            }
            else
            {
                if (_loc4_ != null)
                {
                    this.resetSprite(_loc4_);
                };
            };
        }

        private function resetSprite(param1:IRoomObjectSprite):void
        {
            param1.asset = null;
            param1.assetName = "";
            param1.tag = "";
            param1.flipH = false;
            param1.flipV = false;
            param1.offsetX = 0;
            param1.offsetY = 0;
            param1.relativeDepth = 0;
            param1.clickHandling = false;
        }

        protected function getBlendMode(param1:int):String
        {
            var _loc2_:String = BlendMode.NORMAL;
            switch (param1)
            {
                case LayerData.var_1444:
                    break;
                case LayerData.var_1453:
                    _loc2_ = BlendMode.ADD;
                    break;
                case LayerData.INK_DARKEN:
                    _loc2_ = BlendMode.DARKEN;
                    break;
                case LayerData.var_1454:
                    _loc2_ = BlendMode.SUBTRACT;
                    break;
            };
            return (_loc2_);
        }

        protected function updateObject(param1:Number, param2:Number):Boolean
        {
            var _loc4_:Number;
            var _loc5_:int;
            var _loc3_:IRoomObject = object;
            if (_loc3_ == null)
            {
                return (false);
            };
            if ((((!(var_1455 == _loc3_.getUpdateID())) || (!(param1 == var_1456))) || (!(param2 == this.var_4696))))
            {
                _loc4_ = (_loc3_.getDirection().x - (param2 + 135));
                _loc4_ = (((_loc4_ % 360) + 360) % 360);
                if (this._data != null)
                {
                    _loc5_ = this._data.getDirectionValue(param1, _loc4_);
                    this.direction = _loc5_;
                };
                var_1455 = _loc3_.getUpdateID();
                this.var_4696 = param2;
                var_1456 = param1;
                this.updateAssetAndSpriteCache(param1, this._direction);
                return (true);
            };
            return (false);
        }

        protected function updateModel(param1:Number):Boolean
        {
            var _loc4_:Number;
            var _loc2_:IRoomObject = object;
            if (_loc2_ == null)
            {
                return (false);
            };
            var _loc3_:IRoomObjectModel = _loc2_.getModel();
            if (_loc3_ == null)
            {
                return (false);
            };
            if (var_1457 != _loc3_.getUpdateID())
            {
                this.var_4697 = _loc3_.getNumber(RoomObjectVariableEnum.var_499);
                _loc4_ = _loc3_.getNumber(RoomObjectVariableEnum.var_150);
                if (isNaN(_loc4_))
                {
                    _loc4_ = 1;
                };
                if (_loc4_ != this._alphaMultiplier)
                {
                    this._alphaMultiplier = _loc4_;
                    this.var_4712 = true;
                };
                this.var_2820 = this.getAdClickUrl(_loc3_);
                if (((this.var_2820 == null) || (!(this.var_2820.indexOf("http") == 0))))
                {
                    this.var_2820 = null;
                };
                this.var_4698 = (!(this.var_2820 == null));
                this.var_4715 = _loc3_.getNumber(RoomObjectVariableEnum.var_761);
                var_1457 = _loc3_.getUpdateID();
                return (true);
            };
            return (false);
        }

        protected function getAdClickUrl(param1:IRoomObjectModel):String
        {
            return (param1.getString(RoomObjectVariableEnum.var_501));
        }

        protected function updateAnimation(param1:Number):int
        {
            return (0);
        }

        private function updateAssetAndSpriteCache(param1:Number, param2:int):void
        {
            if (((!(this.var_4703 == param2)) || (!(this.var_4701 == param1))))
            {
                this.var_4699 = [];
                this.var_4700 = [];
                this.var_4704 = [];
                this.var_4705 = [];
                this.var_4706 = [];
                this.var_4707 = [];
                this.var_4708 = [];
                this.var_4709 = [];
                this.var_4710 = [];
                this.var_4711 = [];
                this.var_4703 = param2;
                this.var_4701 = param1;
                this.var_4702 = this.getSize(param1);
                this.updateLayerCount((this._data.getLayerCount(param1) + this.getAdditionalSpriteCount()));
            };
        }

        protected function updateLayerCount(param1:int):void
        {
            this.var_4613 = param1;
            this.var_4713 = (this.var_4613 - this.getAdditionalSpriteCount());
        }

        protected function getAdditionalSpriteCount():int
        {
            return (1);
        }

        protected function getFrameNumber(param1:int, param2:int):int
        {
            return (0);
        }

        protected function getAsset(param1:String):IGraphicAsset
        {
            var _loc2_:IGraphicAsset;
            if (assetCollection != null)
            {
                return (assetCollection.getAsset(param1));
            };
            return (null);
        }

        protected function getSpriteAssetName(param1:int, param2:int):String
        {
            var _loc5_:int;
            var _loc6_:String;
            if (((this._data == null) || (param2 >= FurnitureVisualizationData.var_1442.length)))
            {
                return ("");
            };
            var _loc3_:String = this.var_4699[param2];
            var _loc4_:Boolean = this.var_4700[param2];
            if (((_loc3_ == null) || (_loc3_.length == 0)))
            {
                _loc5_ = this.var_4702;
                _loc3_ = this._type;
                _loc6_ = "";
                if (param2 != this.var_4713)
                {
                    _loc6_ = FurnitureVisualizationData.var_1442[param2];
                }
                else
                {
                    _loc6_ = "sd";
                };
                if (_loc5_ == 1)
                {
                    _loc3_ = (_loc3_ + ("_icon_" + _loc6_));
                    _loc4_ = false;
                }
                else
                {
                    _loc3_ = (_loc3_ + (((((("_" + _loc5_) + "_") + _loc6_) + "_") + this._direction) + "_"));
                    _loc4_ = true;
                };
                this.var_4699[param2] = _loc3_;
                this.var_4700[param2] = _loc4_;
            };
            if (_loc4_)
            {
                _loc3_ = (_loc3_ + this.getFrameNumber(param1, param2));
            };
            return (_loc3_);
        }

        protected function getSpriteTag(param1:int, param2:int, param3:int):String
        {
            if (this.var_4704[param3] != null)
            {
                return (this.var_4704[param3]);
            };
            if (this._data == null)
            {
                return ("");
            };
            var _loc4_:String = this._data.getTag(param1, param2, param3);
            this.var_4704[param3] = _loc4_;
            return (_loc4_);
        }

        protected function getSpriteAlpha(param1:int, param2:int, param3:int):int
        {
            if (((!(this.var_4705[param3] == null)) && (!(this.var_4712))))
            {
                return (this.var_4705[param3]);
            };
            if (this._data == null)
            {
                return (LayerData.var_1445);
            };
            var _loc4_:int = this._data.getAlpha(param1, param2, param3);
            _loc4_ = (_loc4_ * this._alphaMultiplier);
            this.var_4705[param3] = _loc4_;
            return (_loc4_);
        }

        protected function getSpriteColor(param1:int, param2:int, param3:int):int
        {
            if (this.var_4706[param2] != null)
            {
                return (this.var_4706[param2]);
            };
            if (this._data == null)
            {
                return (ColorData.var_1446);
            };
            var _loc4_:int = this._data.getColor(param1, param2, param3);
            this.var_4706[param2] = _loc4_;
            return (_loc4_);
        }

        protected function getSpriteXOffset(param1:int, param2:int, param3:int):int
        {
            if (this.var_4707[param3] != null)
            {
                return (this.var_4707[param3]);
            };
            if (this._data == null)
            {
                return (LayerData.var_1448);
            };
            var _loc4_:int = this._data.getXOffset(param1, param2, param3);
            this.var_4707[param3] = _loc4_;
            return (_loc4_);
        }

        protected function getSpriteYOffset(param1:int, param2:int, param3:int):int
        {
            var _loc4_:int;
            if (param3 != this.var_4713)
            {
                if (this.var_4708[param3] != null)
                {
                    return (this.var_4708[param3]);
                };
                if (this._data != null)
                {
                    _loc4_ = this._data.getYOffset(param1, param2, param3);
                    this.var_4708[param3] = _loc4_;
                    return (_loc4_);
                };
                return (LayerData.var_1449);
            };
            return (Math.ceil((this.var_4715 * (param1 / 2))));
        }

        protected function getSpriteMouseCapture(param1:int, param2:int, param3:int):Boolean
        {
            if (this.var_4710[param3] != null)
            {
                return (this.var_4710[param3]);
            };
            if (this._data == null)
            {
                return (true);
            };
            var _loc4_:* = (!(this._data.getIgnoreMouse(param1, param2, param3)));
            this.var_4710[param3] = _loc4_;
            return (_loc4_);
        }

        protected function getSpriteInk(param1:int, param2:int, param3:int):int
        {
            if (this.var_4711[param3] != null)
            {
                return (this.var_4711[param3]);
            };
            if (this._data == null)
            {
                return (LayerData.var_1444);
            };
            var _loc4_:int = this._data.getInk(param1, param2, param3);
            this.var_4711[param3] = _loc4_;
            return (_loc4_);
        }

        protected function getSpriteZOffset(param1:int, param2:int, param3:int):Number
        {
            if (this.var_4709[param3] != null)
            {
                return (this.var_4709[param3]);
            };
            if (this._data == null)
            {
                return (LayerData.var_1450);
            };
            var _loc4_:Number = this._data.getZOffset(param1, param2, param3);
            this.var_4709[param3] = _loc4_;
            return (_loc4_);
        }

        protected function getSize(param1:int):int
        {
            if (this._data != null)
            {
                return (this._data.getSize(param1));
            };
            return (param1);
        }


    }
}