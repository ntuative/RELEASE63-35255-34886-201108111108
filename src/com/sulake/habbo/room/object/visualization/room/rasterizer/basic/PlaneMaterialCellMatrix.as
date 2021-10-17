package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;

    public class PlaneMaterialCellMatrix 
    {

        public static const var_2226:int = 1;
        public static const var_2220:int = 2;
        public static const var_2221:int = 3;
        public static const var_2222:int = 4;
        public static const var_2223:int = 5;
        public static const var_2224:int = 6;
        public static const var_2219:int = var_2226;//1
        public static const var_2218:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
        public static const var_2225:int = 1;
        public static const var_2111:int = 2;
        public static const ALIGN_DEFAULT:int = var_2225;//1

        private var var_4782:Array = [];
        private var var_4780:int = 1;
        private var _align:int = 1;
        private var var_4776:BitmapData;
        private var _cachedBitmapNormal:Vector3d = null;
        private var var_4783:int = 0;
        private var var_4774:Boolean = false;
        private var var_4781:Boolean = true;
        private var var_4746:Number = -1;
        private var _normalMaxX:Number = 1;
        private var var_4747:Number = -1;
        private var var_4748:Number = 1;

        public function PlaneMaterialCellMatrix(param1:int, param2:int=1, param3:int=1, param4:Number=-1, param5:Number=1, param6:Number=-1, param7:Number=1)
        {
            if (param1 < 1)
            {
                param1 = 1;
            };
            var _loc8_:int;
            while (_loc8_ < param1)
            {
                this.var_4782.push(null);
                _loc8_++;
            };
            this.var_4780 = param2;
            this._align = param3;
            this.var_4746 = param4;
            this._normalMaxX = param5;
            this.var_4747 = param6;
            this.var_4748 = param7;
            if (this.var_4780 == var_2224)
            {
                this.var_4781 = false;
            };
        }

        public function get normalMinX():Number
        {
            return (this.var_4746);
        }

        public function get normalMaxX():Number
        {
            return (this._normalMaxX);
        }

        public function get normalMinY():Number
        {
            return (this.var_4747);
        }

        public function get normalMaxY():Number
        {
            return (this.var_4748);
        }

        public function get isStatic():Boolean
        {
            return (this.var_4781);
        }

        public function dispose():void
        {
            if (this.var_4776 != null)
            {
                this.var_4776.dispose();
                this.var_4776 = null;
            };
            if (this._cachedBitmapNormal != null)
            {
                this._cachedBitmapNormal = null;
            };
        }

        public function clearCache():void
        {
            var _loc2_:PlaneMaterialCellColumn;
            if (!this.var_4774)
            {
                return;
            };
            if (this.var_4776 != null)
            {
                this.var_4776.dispose();
                this.var_4776 = null;
            };
            if (this._cachedBitmapNormal != null)
            {
                this._cachedBitmapNormal.x = 0;
                this._cachedBitmapNormal.y = 0;
                this._cachedBitmapNormal.z = 0;
            };
            this.var_4783 = 0;
            var _loc1_:int;
            while (_loc1_ < this.var_4782.length)
            {
                _loc2_ = (this.var_4782[_loc1_] as PlaneMaterialCellColumn);
                if (_loc2_ != null)
                {
                    _loc2_.clearCache();
                };
                _loc1_++;
            };
            this.var_4774 = false;
        }

        public function createColumn(param1:int, param2:int, param3:Array, param4:int=1):Boolean
        {
            if (((param1 < 0) || (param1 >= this.var_4782.length)))
            {
                return (false);
            };
            var _loc5_:PlaneMaterialCellColumn = new PlaneMaterialCellColumn(param2, param3, param4);
            var _loc6_:PlaneMaterialCellColumn = (this.var_4782[param1] as PlaneMaterialCellColumn);
            if (_loc6_ != null)
            {
                _loc6_.dispose();
            };
            this.var_4782[param1] = _loc5_;
            if (((!(_loc5_ == null)) && (!(_loc5_.isStatic))))
            {
                this.var_4781 = false;
            };
            return (true);
        }

        public function render(param1:BitmapData, param2:int, param3:int, param4:IVector3d, param5:Boolean, param6:int, param7:Boolean):BitmapData
        {
            var _loc11_:PlaneMaterialCellColumn;
            var _loc12_:BitmapData;
            if (param2 < 1)
            {
                param2 = 1;
            };
            if (param3 < 1)
            {
                param3 = 1;
            };
            if ((((param1 == null) || (!(param1.width == param2))) || (!(param1.height == param3))))
            {
                param1 = null;
            };
            if (this._cachedBitmapNormal == null)
            {
                this._cachedBitmapNormal = new Vector3d();
            };
            if (this.isStatic)
            {
                if (this.var_4776 != null)
                {
                    if ((((this.var_4776.width == param2) && (this.var_4776.height == param3)) && (Vector3d.isEqual(this._cachedBitmapNormal, param4))))
                    {
                        if (param1 != null)
                        {
                            this.copyCachedBitmapOnCanvas(param1, this.var_4783, param6, param7);
                            return (param1);
                        };
                        return (this.var_4776);
                    };
                    this.var_4776.dispose();
                    this.var_4776 = null;
                };
            }
            else
            {
                if (this.var_4776 != null)
                {
                    if (((this.var_4776.width == param2) && (this.var_4776.height == param3)))
                    {
                        this.var_4776.fillRect(this.var_4776.rect, 0xFFFFFF);
                    }
                    else
                    {
                        this.var_4776.dispose();
                        this.var_4776 = null;
                    };
                };
            };
            this.var_4774 = true;
            this._cachedBitmapNormal.assign(param4);
            if (!param5)
            {
                this.var_4783 = param3;
                if (this.var_4776 == null)
                {
                    this.var_4776 = new BitmapData(param2, param3, true, 0xFFFFFFFF);
                }
                else
                {
                    this.var_4776.fillRect(this.var_4776.rect, 0xFFFFFFFF);
                };
                if (param1 != null)
                {
                    this.copyCachedBitmapOnCanvas(param1, param3, param6, param7);
                    return (param1);
                };
                return (this.var_4776);
            };
            if (this.var_4776 == null)
            {
                this.var_4783 = param3;
                this.var_4776 = new BitmapData(param2, param3, true, 0xFFFFFF);
            };
            var _loc8_:Array = [];
            var _loc9_:int;
            while (_loc9_ < this.var_4782.length)
            {
                _loc11_ = (this.var_4782[_loc9_] as PlaneMaterialCellColumn);
                if (_loc11_ != null)
                {
                    _loc12_ = _loc11_.render(param3, param4);
                    if (_loc12_ != null)
                    {
                        _loc8_.push(_loc12_);
                    };
                };
                _loc9_++;
            };
            if (_loc8_.length == 0)
            {
                if (param1 != null)
                {
                    return (param1);
                };
                return (this.var_4776);
            };
            var _loc10_:int;
            switch (this.var_4780)
            {
                case var_2220:
                    _loc10_ = this.renderRepeatBorders(this.var_4776, _loc8_);
                    break;
                case var_2221:
                    _loc10_ = this.renderRepeatCenter(this.var_4776, _loc8_);
                    break;
                case var_2222:
                    _loc10_ = this.renderRepeatFirst(this.var_4776, _loc8_);
                    break;
                case var_2223:
                    _loc10_ = this.renderRepeatLast(this.var_4776, _loc8_);
                    break;
                case var_2224:
                    _loc10_ = this.renderRepeatRandom(this.var_4776, _loc8_);
                    break;
                default:
                    _loc10_ = this.renderRepeatAll(this.var_4776, _loc8_);
            };
            this.var_4783 = _loc10_;
            if (param1 != null)
            {
                this.copyCachedBitmapOnCanvas(param1, _loc10_, param6, param7);
                return (param1);
            };
            return (this.var_4776);
        }

        private function copyCachedBitmapOnCanvas(param1:BitmapData, param2:int, param3:int, param4:Boolean):void
        {
            if ((((param1 == null) || (this.var_4776 == null)) || (param1 == this.var_4776)))
            {
                return;
            };
            if (!param4)
            {
                param3 = ((param1.height - param2) - param3);
            };
            var _loc5_:Rectangle;
            if (this._align == var_2225)
            {
                _loc5_ = new Rectangle(0, 0, this.var_4776.width, this.var_4783);
            }
            else
            {
                _loc5_ = new Rectangle(0, (this.var_4776.height - this.var_4783), this.var_4776.width, this.var_4783);
            };
            param1.copyPixels(this.var_4776, _loc5_, new Point(0, param3), null, null, true);
        }

        private function getColumnsWidth(param1:Array):int
        {
            var _loc4_:BitmapData;
            if (((param1 == null) || (param1.length == 0)))
            {
                return (0);
            };
            var _loc2_:int;
            var _loc3_:int;
            while (_loc3_ < param1.length)
            {
                _loc4_ = (param1[_loc3_] as BitmapData);
                if (_loc4_ != null)
                {
                    _loc2_ = (_loc2_ + _loc4_.width);
                };
                _loc3_++;
            };
            return (_loc2_);
        }

        private function renderColumns(param1:BitmapData, param2:Array, param3:int, param4:Boolean):Point
        {
            var _loc8_:int;
            if ((((param2 == null) || (param2.length == 0)) || (param1 == null)))
            {
                return (new Point(param3, 0));
            };
            var _loc5_:int;
            var _loc6_:BitmapData;
            var _loc7_:int;
            while (_loc7_ < param2.length)
            {
                if (param4)
                {
                    _loc6_ = (param2[_loc7_] as BitmapData);
                }
                else
                {
                    _loc6_ = (param2[((param2.length - 1) - _loc7_)] as BitmapData);
                };
                if (_loc6_ != null)
                {
                    if (!param4)
                    {
                        param3 = (param3 - _loc6_.width);
                    };
                    _loc8_ = 0;
                    if (this._align == var_2111)
                    {
                        _loc8_ = (param1.height - _loc6_.height);
                    };
                    param1.copyPixels(_loc6_, _loc6_.rect, new Point(param3, _loc8_), _loc6_, null, true);
                    if (_loc6_.height > _loc5_)
                    {
                        _loc5_ = _loc6_.height;
                    };
                    if (param4)
                    {
                        param3 = (param3 + _loc6_.width);
                    };
                    if ((((param4) && (param3 >= param1.width)) || ((!(param4)) && (param3 <= 0))))
                    {
                        return (new Point(param3, _loc5_));
                    };
                };
                _loc7_++;
            };
            return (new Point(param3, _loc5_));
        }

        private function renderRepeatAll(param1:BitmapData, param2:Array):int
        {
            var _loc6_:Point;
            if ((((param2 == null) || (param2.length == 0)) || (param1 == null)))
            {
                return (0);
            };
            var _loc3_:int;
            var _loc4_:int = this.getColumnsWidth(param2);
            var _loc5_:int;
            if (_loc4_ > param1.width)
            {
            };
            while (_loc5_ < param1.width)
            {
                _loc6_ = this.renderColumns(param1, param2, _loc5_, true);
                _loc5_ = _loc6_.x;
                if (_loc6_.y > _loc3_)
                {
                    _loc3_ = _loc6_.y;
                };
                if (_loc6_.x == 0)
                {
                    return (_loc3_);
                };
            };
            return (_loc3_);
        }

        private function renderRepeatBorders(param1:BitmapData, param2:Array):int
        {
            if ((((param2 == null) || (param2.length == 0)) || (param1 == null)))
            {
                return (0);
            };
            var _loc3_:int;
            var _loc4_:BitmapData;
            var _loc5_:Array = [];
            var _loc6_:int;
            var _loc7_:int;
            _loc7_ = 1;
            while (_loc7_ < (param2.length - 1))
            {
                _loc4_ = (param2[_loc7_] as BitmapData);
                if (_loc4_ != null)
                {
                    _loc6_ = (_loc6_ + _loc4_.width);
                    _loc5_.push(_loc4_);
                };
                _loc7_++;
            };
            if (this.var_4782.length == 1)
            {
                _loc4_ = (this.var_4782[0] as BitmapData);
                if (_loc4_ != null)
                {
                    _loc6_ = _loc4_.width;
                    _loc5_.push(_loc4_);
                };
            };
            var _loc8_:* = ((param1.width - _loc6_) >> 1);
            var _loc9_:Point;
            _loc9_ = this.renderColumns(param1, _loc5_, _loc8_, true);
            var _loc10_:int = _loc9_.x;
            if (_loc9_.y > _loc3_)
            {
                _loc3_ = _loc9_.y;
            };
            _loc4_ = (param2[0] as BitmapData);
            if (_loc4_ != null)
            {
                _loc5_ = [_loc4_];
                while (_loc8_ >= 0)
                {
                    _loc9_ = this.renderColumns(param1, _loc5_, _loc8_, false);
                    _loc8_ = _loc9_.x;
                    if (_loc9_.y > _loc3_)
                    {
                        _loc3_ = _loc9_.y;
                    };
                };
            };
            _loc4_ = (param2[(param2.length - 1)] as BitmapData);
            if (_loc4_ != null)
            {
                _loc5_ = [_loc4_];
                while (_loc10_ < param1.height)
                {
                    _loc9_ = this.renderColumns(param1, _loc5_, _loc10_, true);
                    _loc10_ = _loc9_.x;
                    if (_loc9_.y > _loc3_)
                    {
                        _loc3_ = _loc9_.y;
                    };
                };
            };
            return (_loc3_);
        }

        private function renderRepeatCenter(param1:BitmapData, param2:Array):int
        {
            var _loc14_:int;
            var _loc15_:int;
            var _loc16_:int;
            var _loc17_:int;
            var _loc18_:Array;
            if ((((param2 == null) || (param2.length == 0)) || (param1 == null)))
            {
                return (0);
            };
            var _loc3_:int;
            var _loc4_:BitmapData;
            var _loc5_:Array = [];
            var _loc6_:Array = [];
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:int;
            _loc9_ = 0;
            while (_loc9_ < (param2.length >> 1))
            {
                _loc4_ = (param2[_loc9_] as BitmapData);
                if (_loc4_ != null)
                {
                    _loc7_ = (_loc7_ + _loc4_.width);
                    _loc5_.push(_loc4_);
                };
                _loc9_++;
            };
            _loc9_ = ((param2.length >> 1) + 1);
            while (_loc9_ < param2.length)
            {
                _loc4_ = (param2[_loc9_] as BitmapData);
                if (_loc4_ != null)
                {
                    _loc8_ = (_loc8_ + _loc4_.width);
                    _loc6_.push(_loc4_);
                };
                _loc9_++;
            };
            var _loc10_:Point;
            var _loc11_:int;
            var _loc12_:int;
            var _loc13_:int = param1.width;
            if ((_loc7_ + _loc8_) > param1.width)
            {
                _loc11_ = ((_loc7_ + _loc8_) - param1.width);
                _loc12_ = (_loc12_ - (_loc11_ >> 1));
                _loc13_ = (_loc13_ + (_loc11_ - (_loc11_ >> 1)));
            };
            if (_loc11_ == 0)
            {
                _loc4_ = (param2[(param2.length >> 1)] as BitmapData);
                if (_loc4_ != null)
                {
                    _loc14_ = _loc4_.width;
                    _loc15_ = (param1.width - (_loc7_ + _loc8_));
                    _loc16_ = int((Math.ceil((_loc15_ / _loc14_)) * _loc14_));
                    _loc12_ = (_loc7_ - ((_loc16_ - _loc15_) >> 1));
                    _loc17_ = (_loc12_ + _loc16_);
                    _loc18_ = [_loc4_];
                    while (_loc12_ < _loc17_)
                    {
                        _loc10_ = this.renderColumns(param1, _loc18_, _loc12_, true);
                        _loc12_ = _loc10_.x;
                        if (_loc10_.y > _loc3_)
                        {
                            _loc3_ = _loc10_.y;
                        };
                    };
                };
            };
            _loc12_ = 0;
            _loc10_ = this.renderColumns(param1, _loc5_, _loc12_, true);
            if (_loc10_.y > _loc3_)
            {
                _loc3_ = _loc10_.y;
            };
            _loc10_ = this.renderColumns(param1, _loc6_, _loc13_, false);
            if (_loc10_.y > _loc3_)
            {
                _loc3_ = _loc10_.y;
            };
            return (_loc3_);
        }

        private function renderRepeatFirst(param1:BitmapData, param2:Array):int
        {
            var _loc7_:Array;
            if ((((param2 == null) || (param2.length == 0)) || (param1 == null)))
            {
                return (0);
            };
            var _loc3_:int;
            var _loc4_:BitmapData;
            var _loc5_:int = param1.width;
            var _loc6_:Point = this.renderColumns(param1, param2, _loc5_, false);
            _loc5_ = _loc6_.x;
            if (_loc6_.y > _loc3_)
            {
                _loc3_ = _loc6_.y;
            };
            _loc4_ = (param2[0] as BitmapData);
            if (_loc4_ != null)
            {
                _loc7_ = [_loc4_];
                while (_loc5_ >= 0)
                {
                    _loc6_ = this.renderColumns(param1, _loc7_, _loc5_, false);
                    _loc5_ = _loc6_.x;
                    if (_loc6_.y > _loc3_)
                    {
                        _loc3_ = _loc6_.y;
                    };
                };
            };
            return (_loc3_);
        }

        private function renderRepeatLast(param1:BitmapData, param2:Array):int
        {
            var _loc7_:Array;
            if ((((param2 == null) || (param2.length == 0)) || (param1 == null)))
            {
                return (0);
            };
            var _loc3_:int;
            var _loc4_:BitmapData;
            var _loc5_:int;
            var _loc6_:Point = this.renderColumns(param1, param2, _loc5_, true);
            _loc5_ = _loc6_.x;
            if (_loc6_.y > _loc3_)
            {
                _loc3_ = _loc6_.y;
            };
            _loc4_ = (param2[(param2.length - 1)] as BitmapData);
            if (_loc4_ != null)
            {
                _loc7_ = [_loc4_];
                while (_loc5_ < param1.width)
                {
                    _loc6_ = this.renderColumns(param1, _loc7_, _loc5_, true);
                    _loc5_ = _loc6_.x;
                    if (_loc6_.y > _loc3_)
                    {
                        _loc3_ = _loc6_.y;
                    };
                };
            };
            return (_loc3_);
        }

        private function renderRepeatRandom(param1:BitmapData, param2:Array):int
        {
            var _loc6_:Array;
            var _loc7_:int;
            var _loc8_:Array;
            var _loc9_:Point;
            if ((((param2 == null) || (param2.length == 0)) || (param1 == null)))
            {
                return (0);
            };
            var _loc3_:int;
            var _loc4_:BitmapData;
            var _loc5_:int;
            while (_loc5_ < param1.width)
            {
                _loc6_ = Randomizer.getValues(1, 0, (param2.length * 17631));
                _loc7_ = (_loc6_[0] % param2.length);
                _loc4_ = (param2[_loc7_] as BitmapData);
                if (_loc4_ != null)
                {
                    _loc8_ = [_loc4_];
                    _loc9_ = this.renderColumns(param1, _loc8_, _loc5_, true);
                    _loc5_ = _loc9_.x;
                    if (_loc9_.y > _loc3_)
                    {
                        _loc3_ = _loc9_.y;
                    };
                }
                else
                {
                    return (_loc3_);
                };
            };
            return (_loc3_);
        }


    }
}