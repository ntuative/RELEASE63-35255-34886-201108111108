package com.sulake.habbo.room.object.visualization.room
{
    import flash.geom.Point;
    import com.sulake.room.utils.Vector3d;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.display.BitmapDataChannel;
    import flash.display.BlendMode;

    public class RoomPlane 
    {

        private static const var_2217:Point = new Point(0, 0);
        public static const var_1493:int = 0;
        public static const var_807:int = 1;
        public static const var_806:int = 2;
        public static const TYPE_LANDSCAPE:int = 3;

        private var _disposed:Boolean = false;
        private var var_4792:int = 0;
        private var var_4679:Vector3d = null;
        private var var_3543:Vector3d = null;
        private var var_4671:Vector3d = null;
        private var var_4672:Vector3d = null;
        private var _normal:Vector3d = null;
        private var var_4791:Array = [];
        private var var_4574:int = -1;
        private var _type:int = 0;
        private var _isVisible:Boolean = false;
        private var _bitmapData:BitmapData = null;
        private var var_4793:Boolean = true;
        private var _offset:Point = null;
        private var var_4681:Number = 0;
        private var _color:uint = 0;
        private var var_4794:IPlaneRasterizer = null;
        private var var_4795:PlaneMaskManager = null;
        private var _id:String = null;
        private var var_4796:Number = 0;
        private var var_4797:Number = 0;
        private var var_4798:Number = 0;
        private var var_4799:Number = 0;
        private var var_4680:Map = null;
        private var var_4800:PlaneBitmapData = null;
        private var var_4801:Boolean = false;
        private var var_4802:Array = [];
        private var var_4803:Array = [];
        private var var_4804:Boolean = false;
        private var var_4728:BitmapData = null;
        private var var_4805:BitmapData = null;
        private var var_4806:Array = [];
        private var var_4807:Array = [];
        private var var_4683:Vector3d = null;
        private var var_4684:Vector3d = null;
        private var var_4685:Vector3d = null;
        private var var_4686:Vector3d = null;
        private var var_2731:Number = 0;
        private var _height:Number = 0;
        private var var_4808:Boolean = true;

        public function RoomPlane(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:int, param6:Boolean, param7:Array, param8:int, param9:Number=0, param10:Number=0, param11:Number=0, param12:Number=0)
        {
            var _loc13_:int;
            var _loc14_:IVector3d;
            var _loc15_:Vector3d;
            super();
            this.var_4792 = param8;
            this.var_4679 = new Vector3d();
            this.var_4679.assign(param1);
            this.var_3543 = new Vector3d();
            this.var_3543.assign(param2);
            this.var_4671 = new Vector3d();
            this.var_4671.assign(param3);
            this.var_4672 = new Vector3d();
            this.var_4672.assign(param4);
            this._normal = Vector3d.crossProduct(this.var_4671, this.var_4672);
            if (this._normal.length > 0)
            {
                this._normal.mul((1 / this._normal.length));
            };
            if (param7 != null)
            {
                _loc13_ = 0;
                while (_loc13_ < param7.length)
                {
                    _loc14_ = (param7[_loc13_] as IVector3d);
                    if (_loc14_ != null)
                    {
                        _loc15_ = new Vector3d();
                        _loc15_.assign(_loc14_);
                        this.var_4791.push(_loc15_);
                    };
                    _loc13_++;
                };
            };
            this._offset = new Point();
            this._type = param5;
            this.var_4680 = new Map();
            this.var_4683 = new Vector3d();
            this.var_4684 = new Vector3d();
            this.var_4685 = new Vector3d();
            this.var_4686 = new Vector3d();
            this.var_4796 = param9;
            this.var_4797 = param10;
            this.var_4798 = param11;
            this.var_4799 = param12;
            this.var_4801 = param6;
        }

        public function set canBeVisible(param1:Boolean):void
        {
            if (param1 != this.var_4808)
            {
                if (!this.var_4808)
                {
                    this.resetTextureCache();
                };
                this.var_4808 = param1;
            };
        }

        public function get canBeVisible():Boolean
        {
            return (this.var_4808);
        }

        public function get bitmapData():BitmapData
        {
            var bitmap:BitmapData;
            if (this.visible)
            {
                if (this._bitmapData != null)
                {
                    try
                    {
                        bitmap = this._bitmapData.clone();
                    }
                    catch(e:Error)
                    {
                    };
                };
            };
            return (bitmap);
        }

        public function get visible():Boolean
        {
            return ((this._isVisible) && (this.var_4808));
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

        public function get type():int
        {
            return (this._type);
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

        public function get hasTexture():Boolean
        {
            return (this.var_4793);
        }

        public function set hasTexture(param1:Boolean):void
        {
            this.var_4793 = param1;
        }

        public function set rasterizer(param1:IPlaneRasterizer):void
        {
            this.var_4794 = param1;
        }

        public function set maskManager(param1:PlaneMaskManager):void
        {
            this.var_4795 = param1;
        }

        public function set id(param1:String):void
        {
            if (param1 != this._id)
            {
                this.resetTextureCache();
                this._id = param1;
            };
        }

        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:PlaneBitmapData;
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
                    _loc2_ = (this.var_4680.getWithIndex(_loc1_) as PlaneBitmapData);
                    if (_loc2_ != null)
                    {
                        if (_loc2_.bitmap != null)
                        {
                            _loc2_.bitmap.dispose();
                        };
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4680.dispose();
                this.var_4680 = null;
            };
            this.var_4800 = null;
            this.var_3543 = null;
            this.var_4679 = null;
            this.var_4671 = null;
            this.var_4672 = null;
            this._normal = null;
            this.var_4794 = null;
            this.var_4683 = null;
            this.var_4684 = null;
            this.var_4685 = null;
            this.var_4686 = null;
            this.var_4802 = null;
            this.var_4803 = null;
            if (this.var_4728 != null)
            {
                this.var_4728.dispose();
                this.var_4728 = null;
            };
            if (this.var_4805 != null)
            {
                this.var_4805.dispose();
                this.var_4805 = null;
            };
            this._disposed = true;
        }

        public function copyBitmapData(param1:BitmapData):BitmapData
        {
            if (this.visible)
            {
                if (((!(this._bitmapData == null)) && (!(param1 == null))))
                {
                    if (((this._bitmapData.width == param1.width) && (this._bitmapData.height == param1.height)))
                    {
                        param1.copyPixels(this._bitmapData, this._bitmapData.rect, var_2217);
                        return (param1);
                    };
                };
            };
            return (null);
        }

        private function cacheTexture(param1:String, param2:PlaneBitmapData):Boolean
        {
            var _loc3_:PlaneBitmapData = (this.var_4680.remove(param1) as PlaneBitmapData);
            if (_loc3_ != null)
            {
                if (((!(param2 == null)) && (!(param2.bitmap == _loc3_.bitmap))))
                {
                    _loc3_.bitmap.dispose();
                };
                _loc3_.dispose();
            };
            this.var_4800 = param2;
            this.var_4680.add(param1, param2);
            return (true);
        }

        private function resetTextureCache(param1:BitmapData=null):void
        {
            var _loc2_:int;
            var _loc3_:PlaneBitmapData;
            if (this.var_4680 != null)
            {
                _loc2_ = 0;
                while (_loc2_ < this.var_4680.length)
                {
                    _loc3_ = (this.var_4680.getWithIndex(_loc2_) as PlaneBitmapData);
                    if (_loc3_ != null)
                    {
                        if (((!(_loc3_.bitmap == null)) && (!(_loc3_.bitmap == param1))))
                        {
                            _loc3_.bitmap.dispose();
                        };
                        _loc3_.dispose();
                    };
                    _loc2_++;
                };
                this.var_4680.reset();
            };
            this.var_4800 = null;
        }

        private function getTextureIdentifier(param1:Number):String
        {
            if (this.var_4794 != null)
            {
                return (this.var_4794.getTextureIdentifier(param1, this.normal));
            };
            return (String(param1));
        }

        private function needsNewTexture(param1:IRoomGeometry, param2:int):Boolean
        {
            var _loc4_:String;
            if (param1 == null)
            {
                return (false);
            };
            var _loc3_:PlaneBitmapData = this.var_4800;
            if (_loc3_ == null)
            {
                _loc4_ = this.getTextureIdentifier(param1.scale);
                _loc3_ = (this.var_4680.getValue(_loc4_) as PlaneBitmapData);
            };
            this.updateMaskChangeStatus();
            if (((this.var_4808) && (((_loc3_ == null) || ((_loc3_.timeStamp >= 0) && (param2 > _loc3_.timeStamp))) || (this.var_4804))))
            {
                return (true);
            };
            return (false);
        }

        private function getTexture(param1:IRoomGeometry, param2:int):BitmapData
        {
            var _loc5_:Number;
            var _loc6_:Number;
            var _loc7_:IVector3d;
            var _loc8_:BitmapData;
            var _loc9_:BitmapData;
            if (param1 == null)
            {
                return (null);
            };
            var _loc3_:PlaneBitmapData;
            var _loc4_:String;
            if (this.needsNewTexture(param1, param2))
            {
                _loc5_ = (this.var_4671.length * param1.scale);
                _loc6_ = (this.var_4672.length * param1.scale);
                _loc7_ = param1.getCoordinatePosition(this._normal);
                _loc4_ = this.getTextureIdentifier(param1.scale);
                if (this.var_4800 != null)
                {
                    _loc3_ = this.var_4800;
                }
                else
                {
                    _loc3_ = (this.var_4680.getValue(_loc4_) as PlaneBitmapData);
                };
                _loc8_ = null;
                if (_loc3_ != null)
                {
                    _loc8_ = _loc3_.bitmap;
                };
                if (this.var_4794 != null)
                {
                    _loc3_ = this.var_4794.render(_loc8_, this._id, _loc5_, _loc6_, param1.scale, _loc7_, this.var_4793, this.var_4796, this.var_4797, this.var_4798, this.var_4799, param2);
                    if (_loc3_ != null)
                    {
                        if (((!(_loc8_ == null)) && (!(_loc3_.bitmap == _loc8_))))
                        {
                            _loc8_.dispose();
                        };
                    };
                }
                else
                {
                    _loc9_ = new BitmapData(_loc5_, _loc6_, true, (0xFF000000 | this._color));
                    _loc3_ = new PlaneBitmapData(_loc9_, -1);
                };
                if (_loc3_ != null)
                {
                    this.updateMask(_loc3_.bitmap, param1);
                    this.cacheTexture(_loc4_, _loc3_);
                };
            }
            else
            {
                if (this.var_4800 != null)
                {
                    _loc3_ = this.var_4800;
                }
                else
                {
                    _loc4_ = this.getTextureIdentifier(param1.scale);
                    _loc3_ = (this.var_4680.getValue(_loc4_) as PlaneBitmapData);
                };
            };
            if (_loc3_ != null)
            {
                this.var_4800 = _loc3_;
                return (_loc3_.bitmap);
            };
            return (null);
        }

        private function addOutlines(param1:PlaneBitmapData):void
        {
        }

        public function update(geometry:IRoomGeometry, timeSinceStartMs:int):Boolean
        {
            var cosAngle:Number;
            var i:int;
            var originPos:IVector3d;
            var originZ:Number;
            var relativeDepth:Number;
            var texture:BitmapData;
            if (((geometry == null) || (this._disposed)))
            {
                return (false);
            };
            var geometryChanged:Boolean;
            if (this.var_4574 != geometry.updateId)
            {
                geometryChanged = true;
            };
            if (((!(geometryChanged)) || (!(this.var_4808))))
            {
                if (!this.visible)
                {
                    return (false);
                };
            };
            if (geometryChanged)
            {
                this.var_4800 = null;
                cosAngle = 0;
                cosAngle = Vector3d.cosAngle(geometry.directionAxis, this.normal);
                if (cosAngle > -0.001)
                {
                    if (this._isVisible)
                    {
                        this._isVisible = false;
                        return (true);
                    };
                    return (false);
                };
                i = 0;
                while (i < this.var_4791.length)
                {
                    cosAngle = Vector3d.cosAngle(geometry.directionAxis, this.var_4791[i]);
                    if (cosAngle > -0.001)
                    {
                        if (this._isVisible)
                        {
                            this._isVisible = false;
                            return (true);
                        };
                        return (false);
                    };
                    i = (i + 1);
                };
                this.updateCorners(geometry);
                originPos = geometry.getScreenPosition(this.var_4679);
                originZ = originPos.z;
                relativeDepth = Math.max((this.var_4683.z - originZ), (this.var_4684.z - originZ), (this.var_4685.z - originZ), (this.var_4686.z - originZ));
                if (this._type == TYPE_LANDSCAPE)
                {
                    relativeDepth = (relativeDepth + 0.02);
                };
                this.var_4681 = relativeDepth;
                this._isVisible = true;
                this.var_4574 = geometry.updateId;
            };
            if (((geometryChanged) || (this.needsNewTexture(geometry, timeSinceStartMs))))
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
                    try
                    {
                        this._bitmapData = new BitmapData(this.var_2731, this._height, true, 0xFFFFFF);
                    }
                    catch(e:Error)
                    {
                        _bitmapData = null;
                    };
                    if (this._bitmapData == null)
                    {
                        return (false);
                    };
                    this._bitmapData.lock();
                }
                else
                {
                    this._bitmapData.lock();
                    this._bitmapData.fillRect(this._bitmapData.rect, 0xFFFFFF);
                };
                Randomizer.setSeed(this.var_4792);
                texture = this.getTexture(geometry, timeSinceStartMs);
                if (texture != null)
                {
                    this.renderTexture(geometry, texture);
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
            if (((this._type == var_807) || (this._type == TYPE_LANDSCAPE)))
            {
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
                if (((((((param2.a == 1) && (param2.d == 1)) && (param2.c == 0)) && (!(param2.b == 0))) && (Math.abs(param2.b) <= 1)) && ((this._type == var_807) || (this._type == TYPE_LANDSCAPE))))
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

        public function resetBitmapMasks():void
        {
            if (this.var_4801)
            {
                if (this.var_4802.length == 0)
                {
                    return;
                };
                this.var_4804 = true;
                this.var_4802 = [];
            };
        }

        public function addBitmapMask(param1:String, param2:Number, param3:Number):Boolean
        {
            var _loc4_:RoomPlaneBitmapMask;
            var _loc5_:int;
            if (this.var_4801)
            {
                _loc4_ = null;
                _loc5_ = 0;
                while (_loc5_ < this.var_4802.length)
                {
                    _loc4_ = (this.var_4802[_loc5_] as RoomPlaneBitmapMask);
                    if (_loc4_ != null)
                    {
                        if ((((_loc4_.type == param1) && (_loc4_.leftSideLoc == param2)) && (_loc4_.rightSideLoc == param3)))
                        {
                            return (false);
                        };
                    };
                    _loc5_++;
                };
                _loc4_ = new RoomPlaneBitmapMask(param1, param2, param3);
                this.var_4802.push(_loc4_);
                this.var_4804 = true;
                return (true);
            };
            return (false);
        }

        public function resetRectangleMasks():void
        {
            if (this.var_4801)
            {
                if (this.var_4803.length == 0)
                {
                    return;
                };
                this.var_4804 = true;
                this.var_4803 = [];
            };
        }

        public function addRectangleMask(param1:Number, param2:Number, param3:Number, param4:Number):Boolean
        {
            var _loc5_:RoomPlaneRectangleMask;
            var _loc6_:int;
            if (this.var_4801)
            {
                _loc5_ = null;
                _loc6_ = 0;
                while (_loc6_ < this.var_4803.length)
                {
                    _loc5_ = (this.var_4803[_loc6_] as RoomPlaneRectangleMask);
                    if (_loc5_ != null)
                    {
                        if (((((_loc5_.leftSideLoc == param1) && (_loc5_.rightSideLoc == param2)) && (_loc5_.leftSideLength == param3)) && (_loc5_.rightSideLength == param4)))
                        {
                            return (false);
                        };
                    };
                    _loc6_++;
                };
                _loc5_ = new RoomPlaneRectangleMask(param1, param2, param3, param4);
                this.var_4803.push(_loc5_);
                this.var_4804 = true;
                return (true);
            };
            return (false);
        }

        private function updateMaskChangeStatus():void
        {
            var _loc6_:Boolean;
            var _loc7_:RoomPlaneBitmapMask;
            if (!this.var_4804)
            {
                return;
            };
            var _loc1_:int;
            var _loc2_:int;
            var _loc3_:Boolean = true;
            var _loc4_:RoomPlaneBitmapMask;
            var _loc5_:RoomPlaneRectangleMask;
            if (this.var_4802.length == this.var_4806.length)
            {
                while (_loc1_ < this.var_4802.length)
                {
                    _loc4_ = (this.var_4802[_loc1_] as RoomPlaneBitmapMask);
                    if (_loc4_ != null)
                    {
                        _loc6_ = false;
                        while (_loc2_ < this.var_4806.length)
                        {
                            _loc7_ = (this.var_4806[_loc2_] as RoomPlaneBitmapMask);
                            if (_loc7_ != null)
                            {
                                if ((((_loc7_.type == _loc4_.type) && (_loc7_.leftSideLoc == _loc4_.leftSideLoc)) && (_loc7_.rightSideLoc == _loc4_.rightSideLoc)))
                                {
                                    _loc6_ = true;
                                    break;
                                };
                            };
                            _loc2_++;
                        };
                        if (!_loc6_)
                        {
                            _loc3_ = false;
                            break;
                        };
                    };
                    _loc1_++;
                };
            }
            else
            {
                _loc3_ = false;
            };
            if (this.var_4803.length > this.var_4807.length)
            {
                _loc3_ = false;
            };
            if (_loc3_)
            {
                this.var_4804 = false;
            };
        }

        private function updateMask(param1:BitmapData, param2:IRoomGeometry):void
        {
            var _loc9_:IVector3d;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:String;
            var _loc13_:int;
            var _loc14_:int;
            if ((((!(this.var_4801)) || (((this.var_4802.length == 0) && (this.var_4803.length == 0)) && (!(this.var_4804)))) || (this.var_4795 == null)))
            {
                return;
            };
            if (((param1 == null) || (param2 == null)))
            {
                return;
            };
            var _loc3_:RoomPlaneBitmapMask;
            var _loc4_:RoomPlaneRectangleMask;
            var _loc5_:int;
            var _loc6_:int;
            this.updateMaskChangeStatus();
            var _loc7_:Number = param1.width;
            var _loc8_:Number = param1.height;
            if ((((this.var_4728 == null) || (!(this.var_4728.width == _loc7_))) || (!(this.var_4728.height == _loc8_))))
            {
                if (this.var_4728 != null)
                {
                    this.var_4728.dispose();
                    this.var_4728 = null;
                };
                this.var_4728 = new BitmapData(_loc7_, _loc8_, true, 0xFFFFFF);
                this.var_4804 = true;
            };
            if (this.var_4804)
            {
                this.var_4806 = [];
                this.var_4807 = [];
                if (this.var_4728 != null)
                {
                    this.var_4728.fillRect(this.var_4728.rect, 0xFFFFFF);
                };
                this.resetTextureCache(param1);
                _loc9_ = param2.getCoordinatePosition(this._normal);
                _loc10_ = 0;
                _loc11_ = 0;
                _loc5_ = 0;
                while (_loc5_ < this.var_4802.length)
                {
                    _loc3_ = (this.var_4802[_loc5_] as RoomPlaneBitmapMask);
                    if (_loc3_ != null)
                    {
                        _loc10_ = int((this.var_4728.width - ((this.var_4728.width * _loc3_.leftSideLoc) / this.var_4671.length)));
                        _loc11_ = int((this.var_4728.height - ((this.var_4728.height * _loc3_.rightSideLoc) / this.var_4672.length)));
                        _loc12_ = _loc3_.type;
                        this.var_4795.updateMask(this.var_4728, _loc12_, param2.scale, _loc9_, _loc10_, _loc11_);
                        this.var_4806.push(new RoomPlaneBitmapMask(_loc12_, _loc3_.leftSideLoc, _loc3_.rightSideLoc));
                    };
                    _loc5_++;
                };
                _loc6_ = 0;
                while (_loc6_ < this.var_4803.length)
                {
                    _loc4_ = (this.var_4803[_loc6_] as RoomPlaneRectangleMask);
                    if (_loc4_ != null)
                    {
                        _loc10_ = int((this.var_4728.width - ((this.var_4728.width * _loc4_.leftSideLoc) / this.var_4671.length)));
                        _loc11_ = int((this.var_4728.height - ((this.var_4728.height * _loc4_.rightSideLoc) / this.var_4672.length)));
                        _loc13_ = int(((this.var_4728.width * _loc4_.leftSideLength) / this.var_4671.length));
                        _loc14_ = int(((this.var_4728.height * _loc4_.rightSideLength) / this.var_4672.length));
                        this.var_4728.fillRect(new Rectangle((_loc10_ - _loc13_), (_loc11_ - _loc14_), _loc13_, _loc14_), 0xFF000000);
                        this.var_4807.push(new RoomPlaneRectangleMask(_loc4_.leftSideLength, _loc4_.rightSideLoc, _loc4_.leftSideLength, _loc4_.rightSideLength));
                    };
                    _loc6_++;
                };
                this.var_4804 = false;
            };
            this.combineTextureMask(param1, this.var_4728);
        }

        private function combineTextureMask(param1:BitmapData, param2:BitmapData):void
        {
            if (((param1 == null) || (param2 == null)))
            {
                return;
            };
            if (((!(this.var_4805 == null)) && ((!(this.var_4805.width == param1.width)) || (!(this.var_4805.height == param1.height)))))
            {
                this.var_4805.dispose();
                this.var_4805 = null;
            };
            if (this.var_4805 == null)
            {
                this.var_4805 = new BitmapData(param1.width, param1.height, true, 0xFFFFFFFF);
            };
            this.var_4805.copyChannel(param1, param1.rect, var_2217, BitmapDataChannel.ALPHA, BitmapDataChannel.RED);
            this.var_4805.draw(param2, null, null, BlendMode.DARKEN);
            param1.copyChannel(this.var_4805, this.var_4805.rect, var_2217, BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
        }


    }
}