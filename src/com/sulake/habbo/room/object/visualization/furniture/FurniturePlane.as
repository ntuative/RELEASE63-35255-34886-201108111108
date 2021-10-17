package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.utils.Vector3d;
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    public class FurniturePlane 
    {

        private var var_4574:int = -1;
        private var var_4675:Number = 0;
        private var var_4676:Number = 0;
        private var var_4677:Number = 0;
        private var var_4678:Number = 0;
        private var var_4679:Vector3d = null;
        private var var_3543:Vector3d = null;
        private var var_4671:Vector3d = null;
        private var var_4672:Vector3d = null;
        private var var_4673:Vector3d = null;
        private var var_4674:Vector3d = null;
        private var _normal:Vector3d = null;
        private var _isVisible:Boolean = true;
        private var _bitmapData:BitmapData = null;
        private var var_4680:Map = null;
        private var _offset:Point = null;
        private var var_4681:Number = 0;
        private var _color:uint = 0;
        private var var_4682:Boolean = false;
        private var _id:String = null;
        private var var_4683:Vector3d = null;
        private var var_4684:Vector3d = null;
        private var var_4685:Vector3d = null;
        private var var_4686:Vector3d = null;
        private var var_2731:Number = 0;
        private var _height:Number = 0;

        public function FurniturePlane(param1:IVector3d, param2:IVector3d, param3:IVector3d)
        {
            this.var_4679 = new Vector3d();
            this.var_3543 = new Vector3d();
            this.var_3543.assign(param1);
            this.var_4671 = new Vector3d();
            this.var_4671.assign(param2);
            this.var_4672 = new Vector3d();
            this.var_4672.assign(param3);
            this.var_4673 = new Vector3d();
            this.var_4673.assign(param2);
            this.var_4674 = new Vector3d();
            this.var_4674.assign(param3);
            this._normal = Vector3d.crossProduct(this.var_4671, this.var_4672);
            if (this._normal.length > 0)
            {
                this._normal.mul((1 / this._normal.length));
            };
            this._offset = new Point();
            this.var_4683 = new Vector3d();
            this.var_4684 = new Vector3d();
            this.var_4685 = new Vector3d();
            this.var_4686 = new Vector3d();
            this.var_4680 = new Map();
        }

        public function get bitmapData():BitmapData
        {
            if (this._isVisible)
            {
                if (this._bitmapData != null)
                {
                    return (this._bitmapData.clone());
                };
            };
            return (null);
        }

        public function get visible():Boolean
        {
            return (this._isVisible);
        }

        public function get offset():Point
        {
            return (this._offset);
        }

        public function get relativeDepth():Number
        {
            return (this.var_4681);
        }

        public function get color():uint
        {
            return (this._color);
        }

        public function set color(param1:uint):void
        {
            this._color = param1;
        }

        public function get leftSide():IVector3d
        {
            return (this.var_4671);
        }

        public function get rightSide():IVector3d
        {
            return (this.var_4672);
        }

        public function get location():IVector3d
        {
            return (this.var_3543);
        }

        public function get normal():IVector3d
        {
            return (this._normal);
        }

        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:BitmapData;
            if (this._bitmapData != null)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
            if (this.var_4680 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4680.length)
                {
                    _loc2_ = (this.var_4680.getWithIndex(_loc1_) as BitmapData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4680.dispose();
                this.var_4680 = null;
            };
            this.var_4679 = null;
            this.var_3543 = null;
            this.var_4671 = null;
            this.var_4672 = null;
            this.var_4673 = null;
            this.var_4674 = null;
            this._normal = null;
            this.var_4683 = null;
            this.var_4684 = null;
            this.var_4685 = null;
            this.var_4686 = null;
        }

        public function setRotation(param1:Boolean):void
        {
            if (param1 != this.var_4682)
            {
                if (!param1)
                {
                    this.var_4671.assign(this.var_4673);
                    this.var_4672.assign(this.var_4674);
                }
                else
                {
                    this.var_4671.assign(this.var_4673);
                    this.var_4671.mul((this.var_4674.length / this.var_4673.length));
                    this.var_4672.assign(this.var_4674);
                    this.var_4672.mul((this.var_4673.length / this.var_4674.length));
                };
                this.var_4574 = -1;
                this.var_4675 = (this.var_4675 - 1);
                this.var_4682 = param1;
                this.resetTextureCache();
            };
        }

        private function cacheTexture(param1:String, param2:BitmapData):Boolean
        {
            var _loc3_:BitmapData = (this.var_4680.remove(param1) as BitmapData);
            if (((!(_loc3_ == null)) && (!(param2 == _loc3_))))
            {
                _loc3_.dispose();
            };
            this.var_4680.add(param1, param2);
            return (true);
        }

        private function resetTextureCache():void
        {
            var _loc1_:int;
            var _loc2_:BitmapData;
            if (this.var_4680 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4680.length)
                {
                    _loc2_ = (this.var_4680.getWithIndex(_loc1_) as BitmapData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4680.reset();
            };
        }

        private function getTextureIdentifier(param1:IRoomGeometry):String
        {
            if (param1 == null)
            {
                return (null);
            };
            return (String(param1.scale));
        }

        private function needsNewTexture(param1:IRoomGeometry):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:String = this.getTextureIdentifier(param1);
            var _loc3_:BitmapData = (this.var_4680.getValue(_loc2_) as BitmapData);
            if (((this.var_2731 > 0) && (this._height > 0)))
            {
                if (_loc3_ == null)
                {
                    return (true);
                };
            };
            return (false);
        }

        private function getTexture(param1:IRoomGeometry, param2:int):BitmapData
        {
            var _loc5_:Number;
            var _loc6_:Number;
            var _loc7_:IVector3d;
            if (param1 == null)
            {
                return (null);
            };
            var _loc3_:String = this.getTextureIdentifier(param1);
            var _loc4_:BitmapData;
            if (this.needsNewTexture(param1))
            {
                _loc5_ = (this.var_4671.length * param1.scale);
                _loc6_ = (this.var_4672.length * param1.scale);
                if (_loc5_ < 1)
                {
                    _loc5_ = 1;
                };
                if (_loc6_ < 1)
                {
                    _loc6_ = 1;
                };
                _loc7_ = param1.getCoordinatePosition(this._normal);
                _loc4_ = (this.var_4680.getValue(_loc3_) as BitmapData);
                if (_loc4_ == null)
                {
                    _loc4_ = new BitmapData(_loc5_, _loc6_, true, (0xFF000000 | this._color));
                    if (_loc4_ != null)
                    {
                        this.cacheTexture(_loc3_, _loc4_);
                    };
                };
            }
            else
            {
                _loc4_ = (this.var_4680.getValue(_loc3_) as BitmapData);
            };
            if (_loc4_ != null)
            {
                return (_loc4_);
            };
            return (null);
        }

        public function update(param1:IRoomGeometry, param2:int):Boolean
        {
            var _loc4_:IVector3d;
            var _loc5_:Number;
            var _loc6_:IVector3d;
            var _loc7_:Number;
            var _loc8_:Number;
            var _loc9_:BitmapData;
            if ((((((param1 == null) || ((this.var_3543 == null) && (!(this.var_4679 == null)))) || (this.var_4671 == null)) || (this.var_4672 == null)) || (this._normal == null)))
            {
                return (false);
            };
            var _loc3_:Boolean;
            if (param1.updateId != this.var_4574)
            {
                this.var_4574 = param1.updateId;
                _loc4_ = param1.direction;
                if (((!(_loc4_ == null)) && ((((!(_loc4_.x == this.var_4675)) || (!(_loc4_.y == this.var_4676))) || (!(_loc4_.z == this.var_4677))) || (!(param1.scale == this.var_4678)))))
                {
                    this.var_4675 = _loc4_.x;
                    this.var_4676 = _loc4_.y;
                    this.var_4677 = _loc4_.z;
                    this.var_4678 = param1.scale;
                    _loc3_ = true;
                    _loc5_ = 0;
                    _loc5_ = Vector3d.cosAngle(param1.directionAxis, this.normal);
                    if (_loc5_ > -0.001)
                    {
                        if (this._isVisible)
                        {
                            this._isVisible = false;
                            return (true);
                        };
                        return (false);
                    };
                    this.updateCorners(param1);
                    _loc6_ = param1.getScreenPosition(this.var_4679);
                    _loc7_ = _loc6_.z;
                    _loc8_ = Math.max((this.var_4683.z - _loc7_), (this.var_4684.z - _loc7_), (this.var_4685.z - _loc7_), (this.var_4686.z - _loc7_));
                    this.var_4681 = _loc8_;
                    this._isVisible = true;
                };
            };
            if (((this.needsNewTexture(param1)) || (_loc3_)))
            {
                if ((((this._bitmapData == null) || (!(this.var_2731 == this._bitmapData.width))) || (!(this._height == this._bitmapData.height))))
                {
                    if (this._bitmapData != null)
                    {
                        this._bitmapData.dispose();
                        this._bitmapData = null;
                        if (((this.var_2731 < 1) || (this._height < 1)))
                        {
                            return (true);
                        };
                    }
                    else
                    {
                        if (((this.var_2731 < 1) || (this._height < 1)))
                        {
                            return (false);
                        };
                    };
                    this._bitmapData = new BitmapData(this.var_2731, this._height, true, 0xFFFFFF);
                    this._bitmapData.lock();
                }
                else
                {
                    this._bitmapData.lock();
                    this._bitmapData.fillRect(this._bitmapData.rect, 0xFFFFFF);
                };
                _loc9_ = this.getTexture(param1, param2);
                if (_loc9_ != null)
                {
                    this.renderTexture(param1, _loc9_);
                };
                this._bitmapData.unlock();
                return (true);
            };
            return (false);
        }

        private function updateCorners(param1:IRoomGeometry):void
        {
            this.var_4683.assign(param1.getScreenPosition(this.var_3543));
            this.var_4684.assign(param1.getScreenPosition(Vector3d.sum(this.var_3543, this.var_4672)));
            this.var_4685.assign(param1.getScreenPosition(Vector3d.sum(Vector3d.sum(this.var_3543, this.var_4671), this.var_4672)));
            this.var_4686.assign(param1.getScreenPosition(Vector3d.sum(this.var_3543, this.var_4671)));
            this._offset = param1.getScreenPoint(this.var_4679);
            this.var_4683.x = Math.round(this.var_4683.x);
            this.var_4683.y = Math.round(this.var_4683.y);
            this.var_4684.x = Math.round(this.var_4684.x);
            this.var_4684.y = Math.round(this.var_4684.y);
            this.var_4685.x = Math.round(this.var_4685.x);
            this.var_4685.y = Math.round(this.var_4685.y);
            this.var_4686.x = Math.round(this.var_4686.x);
            this.var_4686.y = Math.round(this.var_4686.y);
            this._offset.x = Math.round(this._offset.x);
            this._offset.y = Math.round(this._offset.y);
            var _loc2_:Number = Math.min(this.var_4683.x, this.var_4684.x, this.var_4685.x, this.var_4686.x);
            var _loc3_:Number = Math.max(this.var_4683.x, this.var_4684.x, this.var_4685.x, this.var_4686.x);
            var _loc4_:Number = Math.min(this.var_4683.y, this.var_4684.y, this.var_4685.y, this.var_4686.y);
            var _loc5_:Number = Math.max(this.var_4683.y, this.var_4684.y, this.var_4685.y, this.var_4686.y);
            _loc3_ = (_loc3_ - _loc2_);
            this._offset.x = (this._offset.x - _loc2_);
            this.var_4683.x = (this.var_4683.x - _loc2_);
            this.var_4684.x = (this.var_4684.x - _loc2_);
            this.var_4685.x = (this.var_4685.x - _loc2_);
            this.var_4686.x = (this.var_4686.x - _loc2_);
            _loc5_ = (_loc5_ - _loc4_);
            this._offset.y = (this._offset.y - _loc4_);
            this.var_4683.y = (this.var_4683.y - _loc4_);
            this.var_4684.y = (this.var_4684.y - _loc4_);
            this.var_4685.y = (this.var_4685.y - _loc4_);
            this.var_4686.y = (this.var_4686.y - _loc4_);
            this.var_2731 = _loc3_;
            this._height = _loc5_;
        }

        private function renderTexture(param1:IRoomGeometry, param2:BitmapData):void
        {
            if (((((((this.var_4683 == null) || (this.var_4684 == null)) || (this.var_4685 == null)) || (this.var_4686 == null)) || (param2 == null)) || (this._bitmapData == null)))
            {
                return;
            };
            var _loc3_:Number = (this.var_4686.x - this.var_4685.x);
            var _loc4_:Number = (this.var_4686.y - this.var_4685.y);
            var _loc5_:Number = (this.var_4684.x - this.var_4685.x);
            var _loc6_:Number = (this.var_4684.y - this.var_4685.y);
            if (Math.abs((_loc5_ - param2.width)) <= 1)
            {
                _loc5_ = param2.width;
            };
            if (Math.abs((_loc6_ - param2.width)) <= 1)
            {
                _loc6_ = param2.width;
            };
            if (Math.abs((_loc3_ - param2.height)) <= 1)
            {
                _loc3_ = param2.height;
            };
            if (Math.abs((_loc4_ - param2.height)) <= 1)
            {
                _loc4_ = param2.height;
            };
            var _loc7_:Number = (_loc5_ / param2.width);
            var _loc8_:Number = (_loc6_ / param2.width);
            var _loc9_:Number = (_loc3_ / param2.height);
            var _loc10_:Number = (_loc4_ / param2.height);
            var _loc11_:Matrix = new Matrix();
            _loc11_.a = _loc7_;
            _loc11_.b = _loc8_;
            _loc11_.c = _loc9_;
            _loc11_.d = _loc10_;
            _loc11_.translate(this.var_4685.x, this.var_4685.y);
            this.draw(param2, _loc11_);
        }

        private function draw(param1:BitmapData, param2:Matrix):void
        {
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:Number;
            var _loc6_:int;
            var _loc7_:int;
            if (this._bitmapData != null)
            {
                if ((((((param2.a == 1) && (param2.d == 1)) && (param2.c == 0)) && (!(param2.b == 0))) && (Math.abs(param2.b) <= 1)))
                {
                    _loc3_ = 0;
                    _loc4_ = 0;
                    _loc5_ = 0;
                    _loc6_ = 0;
                    if (param2.b > 0)
                    {
                        param2.ty++;
                    };
                    _loc7_ = 0;
                    while (_loc3_ < param1.width)
                    {
                        _loc3_++;
                        _loc5_ = (_loc5_ + Math.abs(param2.b));
                        if (_loc5_ >= 1)
                        {
                            this._bitmapData.copyPixels(param1, new Rectangle((_loc4_ + _loc6_), 0, (_loc3_ - _loc4_), param1.height), new Point((param2.tx + _loc4_), (param2.ty + _loc7_)), null, null, true);
                            _loc4_ = _loc3_;
                            if (param2.b > 0)
                            {
                                _loc7_++;
                            }
                            else
                            {
                                _loc7_--;
                            };
                            _loc5_ = 0;
                        };
                    };
                    if (_loc5_ > 0)
                    {
                        this._bitmapData.copyPixels(param1, new Rectangle(_loc4_, 0, (_loc3_ - _loc4_), param1.height), new Point((param2.tx + _loc4_), (param2.ty + _loc7_)), null, null, true);
                    };
                    return;
                };
                this._bitmapData.draw(param1, param2, null, null, null, false);
            };
        }


    }
}