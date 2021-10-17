package com.sulake.room.object.visualization
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.display.BlendMode;
    import flash.geom.Point;
    import com.sulake.core.assets.IAsset;

    public class RoomObjectSpriteVisualization implements IRoomObjectSpriteVisualization 
    {

        private static var var_1451:int = 0;

        private var var_3028:Array;
        private var var_5510:IRoomObject;
        private var var_4749:IGraphicAssetCollection;
        protected var var_1455:int = -1;
        protected var var_1457:int = -1;
        protected var var_1456:int = -1;
        private var var_3062:int = 0;
        private var _updateID:int = 0;

        public function RoomObjectSpriteVisualization()
        {
            this.var_3062 = var_1451++;
            this.var_3028 = [];
            this.var_5510 = null;
            this.var_4749 = null;
        }

        public function dispose():void
        {
            var _loc1_:RoomObjectSprite;
            if (this.var_3028 != null)
            {
                while (this.var_3028.length > 0)
                {
                    _loc1_ = (this.var_3028[0] as RoomObjectSprite);
                    if (_loc1_ != null)
                    {
                        _loc1_.dispose();
                    };
                    this.var_3028.pop();
                };
                this.var_3028 = null;
            };
            this.var_5510 = null;
            this.assetCollection = null;
        }

        public function set assetCollection(param1:IGraphicAssetCollection):void
        {
            if (this.var_4749 != null)
            {
                this.var_4749.removeReference();
            };
            this.var_4749 = param1;
            if (this.var_4749 != null)
            {
                this.var_4749.addReference();
            };
        }

        public function get assetCollection():IGraphicAssetCollection
        {
            return (this.var_4749);
        }

        public function getUpdateID():int
        {
            return (this._updateID);
        }

        public function getInstanceId():int
        {
            return (this.var_3062);
        }

        protected function createSprites(param1:int):void
        {
            var _loc2_:RoomObjectSprite;
            while (this.var_3028.length > param1)
            {
                _loc2_ = (this.var_3028[(this.var_3028.length - 1)] as RoomObjectSprite);
                if (_loc2_ != null)
                {
                    _loc2_.dispose();
                };
                this.var_3028.pop();
            };
            while (this.var_3028.length < param1)
            {
                _loc2_ = new RoomObjectSprite();
                this.var_3028.push(_loc2_);
            };
        }

        public function get spriteCount():int
        {
            return (this.var_3028.length);
        }

        public function getSprite(param1:int):IRoomObjectSprite
        {
            if (((param1 >= 0) && (param1 < this.var_3028.length)))
            {
                return (this.var_3028[param1]);
            };
            return (null);
        }

        public function get object():IRoomObject
        {
            return (this.var_5510);
        }

        public function set object(param1:IRoomObject):void
        {
            this.var_5510 = param1;
        }

        public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean):void
        {
        }

        protected function increaseUpdateId():void
        {
            this._updateID++;
        }

        protected function reset():void
        {
            this.var_1455 = 0xFFFFFFFF;
            this.var_1457 = 0xFFFFFFFF;
            this.var_1456 = -1;
        }

        public function initialize(param1:IRoomObjectVisualizationData):Boolean
        {
            return (false);
        }

        public function get image():BitmapData
        {
            return (this.getImage(0));
        }

        public function getImage(param1:int):BitmapData
        {
            var _loc9_:Number;
            var _loc10_:Number;
            var _loc11_:Number;
            var _loc12_:int;
            var _loc13_:int;
            var _loc14_:int;
            var _loc15_:int;
            var _loc16_:ColorTransform;
            var _loc17_:Matrix;
            var _loc2_:Rectangle = this.boundingRectangle;
            if ((_loc2_.width * _loc2_.height) == 0)
            {
                return (null);
            };
            var _loc3_:int = this.spriteCount;
            var _loc4_:IRoomObjectSprite;
            var _loc5_:Array = [];
            var _loc6_:int;
            var _loc7_:BitmapData;
            _loc6_ = 0;
            while (_loc6_ < _loc3_)
            {
                _loc4_ = this.getSprite(_loc6_);
                if (((!(_loc4_ == null)) && (_loc4_.visible)))
                {
                    _loc7_ = _loc4_.asset;
                    if (_loc7_ != null)
                    {
                        _loc5_.push(_loc4_);
                    };
                };
                _loc6_++;
            };
            _loc5_.sortOn("relativeDepth", (Array.DESCENDING | Array.NUMERIC));
            var _loc8_:BitmapData = new BitmapData(_loc2_.width, _loc2_.height, true, param1);
            _loc6_ = 0;
            while (_loc6_ < _loc5_.length)
            {
                _loc4_ = (_loc5_[_loc6_] as IRoomObjectSprite);
                _loc7_ = _loc4_.asset;
                if (_loc7_ != null)
                {
                    _loc12_ = _loc4_.color;
                    _loc13_ = (_loc12_ >> 16);
                    _loc14_ = ((_loc12_ >> 8) & 0xFF);
                    _loc15_ = (_loc12_ & 0xFF);
                    _loc16_ = null;
                    if ((((_loc13_ < 0xFF) || (_loc14_ < 0xFF)) || (_loc15_ < 0xFF)))
                    {
                        _loc9_ = (_loc13_ / 0xFF);
                        _loc10_ = (_loc14_ / 0xFF);
                        _loc11_ = (_loc15_ / 0xFF);
                        _loc16_ = new ColorTransform(_loc9_, _loc10_, _loc11_, (_loc4_.alpha / 0xFF));
                    }
                    else
                    {
                        if (_loc4_.alpha < 0xFF)
                        {
                            _loc16_ = new ColorTransform(1, 1, 1, (_loc4_.alpha / 0xFF));
                        };
                    };
                    if (param1 == 0)
                    {
                        if (_loc4_.blendMode == BlendMode.ADD)
                        {
                            if (_loc16_ == null)
                            {
                                _loc16_ = new ColorTransform(1, 1, 1, 0);
                            }
                            else
                            {
                                _loc16_.alphaMultiplier = 0;
                            };
                        };
                    };
                    _loc17_ = new Matrix();
                    if (_loc4_.flipH)
                    {
                        _loc17_.scale(-1, 1);
                        _loc17_.translate(_loc7_.width, 0);
                    };
                    if (_loc4_.flipV)
                    {
                        _loc17_.scale(1, -1);
                        _loc17_.translate(0, _loc7_.height);
                    };
                    _loc17_.translate((_loc4_.offsetX - _loc2_.left), (_loc4_.offsetY - _loc2_.top));
                    _loc8_.draw(_loc7_, _loc17_, _loc16_, _loc4_.blendMode, null, false);
                };
                _loc6_++;
            };
            return (_loc8_);
        }

        public function get boundingRectangle():Rectangle
        {
            var _loc7_:Point;
            var _loc1_:int = this.spriteCount;
            var _loc2_:IRoomObjectSprite;
            var _loc3_:Rectangle = new Rectangle();
            var _loc4_:int;
            var _loc5_:IAsset;
            var _loc6_:BitmapData;
            _loc4_ = 0;
            while (_loc4_ < _loc1_)
            {
                _loc2_ = this.getSprite(_loc4_);
                if (((!(_loc2_ == null)) && (_loc2_.visible)))
                {
                    _loc6_ = _loc2_.asset;
                    if (_loc6_ != null)
                    {
                        _loc7_ = new Point(_loc2_.offsetX, _loc2_.offsetY);
                        if (_loc4_ == 0)
                        {
                            _loc3_.left = _loc7_.x;
                            _loc3_.top = _loc7_.y;
                            _loc3_.right = (_loc7_.x + _loc2_.width);
                            _loc3_.bottom = (_loc7_.y + _loc2_.height);
                        }
                        else
                        {
                            if (_loc7_.x < _loc3_.left)
                            {
                                _loc3_.left = _loc7_.x;
                            };
                            if (_loc7_.y < _loc3_.top)
                            {
                                _loc3_.top = _loc7_.y;
                            };
                            if ((_loc7_.x + _loc2_.width) > _loc3_.right)
                            {
                                _loc3_.right = (_loc7_.x + _loc2_.width);
                            };
                            if ((_loc7_.y + _loc2_.height) > _loc3_.bottom)
                            {
                                _loc3_.bottom = (_loc7_.y + _loc2_.height);
                            };
                        };
                    };
                };
                _loc4_++;
            };
            return (_loc3_);
        }


    }
}