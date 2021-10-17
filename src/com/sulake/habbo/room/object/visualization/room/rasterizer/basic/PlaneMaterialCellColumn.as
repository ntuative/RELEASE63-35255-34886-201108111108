package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import flash.geom.Point;

    public class PlaneMaterialCellColumn 
    {

        public static const var_2227:int = 0;
        public static const var_2226:int = 1;
        public static const var_2220:int = 2;
        public static const var_2221:int = 3;
        public static const var_2222:int = 4;
        public static const var_2223:int = 5;

        private var var_4779:Array = [];
        private var var_4780:int = 1;
        private var var_2731:int = 1;
        private var var_4776:BitmapData;
        private var _cachedBitmapNormal:Vector3d = null;
        private var var_4774:Boolean = false;
        private var var_4781:Boolean = true;

        public function PlaneMaterialCellColumn(param1:int, param2:Array, param3:int=1)
        {
            var _loc4_:int;
            var _loc5_:PlaneMaterialCell;
            super();
            if (param1 < 1)
            {
                param1 = 1;
            };
            this.var_2731 = param1;
            if (param2 != null)
            {
                _loc4_ = 0;
                while (_loc4_ < param2.length)
                {
                    _loc5_ = (param2[_loc4_] as PlaneMaterialCell);
                    if (_loc5_ != null)
                    {
                        this.var_4779.push(_loc5_);
                        if (!_loc5_.isStatic)
                        {
                            this.var_4781 = false;
                        };
                    };
                    _loc4_++;
                };
            };
            this.var_4780 = param3;
        }

        public function get isStatic():Boolean
        {
            return (this.var_4781);
        }

        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:PlaneMaterialCell;
            if (this.var_4779 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4779.length)
                {
                    _loc2_ = (this.var_4779[_loc1_] as PlaneMaterialCell);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4779 = null;
            };
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
            var _loc1_:int;
            var _loc2_:PlaneMaterialCell;
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
            if (this.var_4779 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4779.length)
                {
                    _loc2_ = (this.var_4779[_loc1_] as PlaneMaterialCell);
                    if (_loc2_ != null)
                    {
                        _loc2_.clearCache();
                    };
                    _loc1_++;
                };
            };
            this.var_4774 = false;
        }

        public function render(param1:int, param2:IVector3d):BitmapData
        {
            var _loc3_:int;
            if (this.var_4780 == var_2227)
            {
                _loc3_ = this.getCellsHeight(this.var_4779, param2);
                param1 = _loc3_;
            };
            if (this._cachedBitmapNormal == null)
            {
                this._cachedBitmapNormal = new Vector3d();
            };
            if (this.isStatic)
            {
                if (this.var_4776 != null)
                {
                    if (((this.var_4776.height == param1) && (Vector3d.isEqual(this._cachedBitmapNormal, param2))))
                    {
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
                    if (this.var_4776.height == param1)
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
            if (this.var_4776 == null)
            {
                this.var_4776 = new BitmapData(this.var_2731, param1, true, 0xFFFFFF);
            };
            this._cachedBitmapNormal.assign(param2);
            if (this.var_4779.length == 0)
            {
                return (this.var_4776);
            };
            switch (this.var_4780)
            {
                case var_2227:
                    this.renderRepeatNone(param2);
                    break;
                case var_2220:
                    this.renderRepeatBorders(param2);
                    break;
                case var_2221:
                    this.renderRepeatCenter(param2);
                    break;
                case var_2222:
                    this.renderRepeatFirst(param2);
                    break;
                case var_2223:
                    this.renderRepeatLast(param2);
                    break;
                default:
                    this.renderRepeatAll(param2);
            };
            return (this.var_4776);
        }

        private function getCellsHeight(param1:Array, param2:IVector3d):int
        {
            var _loc5_:PlaneMaterialCell;
            var _loc6_:int;
            if (((param1 == null) || (param1.length == 0)))
            {
                return (0);
            };
            var _loc3_:int;
            var _loc4_:int;
            while (_loc4_ < param1.length)
            {
                _loc5_ = (param1[_loc4_] as PlaneMaterialCell);
                if (_loc5_ != null)
                {
                    _loc6_ = _loc5_.getHeight(param2);
                    _loc3_ = (_loc3_ + _loc6_);
                };
                _loc4_++;
            };
            return (_loc3_);
        }

        private function renderCells(param1:Array, param2:int, param3:Boolean, param4:IVector3d):int
        {
            if ((((param1 == null) || (param1.length == 0)) || (this.var_4776 == null)))
            {
                return (param2);
            };
            var _loc5_:PlaneMaterialCell;
            var _loc6_:BitmapData;
            var _loc7_:int;
            while (_loc7_ < param1.length)
            {
                if (param3)
                {
                    _loc5_ = (param1[_loc7_] as PlaneMaterialCell);
                }
                else
                {
                    _loc5_ = (param1[((param1.length - 1) - _loc7_)] as PlaneMaterialCell);
                };
                if (_loc5_ != null)
                {
                    _loc6_ = _loc5_.render(param4);
                    if (_loc6_ != null)
                    {
                        if (!param3)
                        {
                            param2 = (param2 - _loc6_.height);
                        };
                        this.var_4776.copyPixels(_loc6_, _loc6_.rect, new Point(0, param2), _loc6_, null, true);
                        if (param3)
                        {
                            param2 = (param2 + _loc6_.height);
                        };
                        if ((((param3) && (param2 >= this.var_4776.height)) || ((!(param3)) && (param2 <= 0))))
                        {
                            return (param2);
                        };
                    };
                };
                _loc7_++;
            };
            return (param2);
        }

        private function renderRepeatNone(param1:IVector3d):void
        {
            if (((this.var_4779.length == 0) || (this.var_4776 == null)))
            {
                return;
            };
            this.renderCells(this.var_4779, 0, true, param1);
        }

        private function renderRepeatAll(param1:IVector3d):void
        {
            if (((this.var_4779.length == 0) || (this.var_4776 == null)))
            {
                return;
            };
            var _loc2_:int = this.getCellsHeight(this.var_4779, param1);
            var _loc3_:int;
            if (_loc2_ > this.var_4776.height)
            {
            };
            while (_loc3_ < this.var_4776.height)
            {
                _loc3_ = this.renderCells(this.var_4779, _loc3_, true, param1);
                if (_loc3_ == 0)
                {
                    return;
                };
            };
        }

        private function renderRepeatBorders(param1:IVector3d):void
        {
            if (((this.var_4779.length == 0) || (this.var_4776 == null)))
            {
                return;
            };
            var _loc2_:PlaneMaterialCell;
            var _loc3_:BitmapData;
            var _loc4_:Array = [];
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:int;
            _loc7_ = 1;
            while (_loc7_ < (this.var_4779.length - 1))
            {
                _loc2_ = (this.var_4779[_loc7_] as PlaneMaterialCell);
                if (_loc2_ != null)
                {
                    _loc6_ = _loc2_.getHeight(param1);
                    if (_loc6_ > 0)
                    {
                        _loc5_ = (_loc5_ + _loc6_);
                        _loc4_.push(_loc2_);
                    };
                };
                _loc7_++;
            };
            if (this.var_4779.length == 1)
            {
                _loc2_ = (this.var_4779[0] as PlaneMaterialCell);
                if (_loc2_ != null)
                {
                    _loc6_ = _loc2_.getHeight(param1);
                    if (_loc6_ > 0)
                    {
                        _loc5_ = (_loc5_ + _loc6_);
                        _loc4_.push(_loc2_);
                    };
                };
            };
            var _loc8_:* = ((this.var_4776.height - _loc5_) >> 1);
            var _loc9_:int = this.renderCells(_loc4_, _loc8_, true, param1);
            _loc2_ = (this.var_4779[0] as PlaneMaterialCell);
            if (_loc2_ != null)
            {
                _loc4_ = [_loc2_];
                while (_loc8_ >= 0)
                {
                    _loc8_ = this.renderCells(_loc4_, _loc8_, false, param1);
                };
            };
            _loc2_ = (this.var_4779[(this.var_4779.length - 1)] as PlaneMaterialCell);
            if (_loc2_ != null)
            {
                _loc4_ = [_loc2_];
                while (_loc9_ < this.var_4776.height)
                {
                    _loc9_ = this.renderCells(_loc4_, _loc9_, true, param1);
                };
            };
        }

        private function renderRepeatCenter(param1:IVector3d):void
        {
            var _loc13_:int;
            var _loc14_:int;
            var _loc15_:int;
            var _loc16_:Array;
            if (((this.var_4779.length == 0) || (this.var_4776 == null)))
            {
                return;
            };
            var _loc2_:PlaneMaterialCell;
            var _loc3_:BitmapData;
            var _loc4_:Array = [];
            var _loc5_:Array = [];
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:int;
            _loc9_ = 0;
            while (_loc9_ < (this.var_4779.length >> 1))
            {
                _loc2_ = (this.var_4779[_loc9_] as PlaneMaterialCell);
                if (_loc2_ != null)
                {
                    _loc8_ = _loc2_.getHeight(param1);
                    if (_loc8_ > 0)
                    {
                        _loc6_ = (_loc6_ + _loc8_);
                        _loc4_.push(_loc2_);
                    };
                };
                _loc9_++;
            };
            _loc9_ = ((this.var_4779.length >> 1) + 1);
            while (_loc9_ < this.var_4779.length)
            {
                _loc2_ = (this.var_4779[_loc9_] as PlaneMaterialCell);
                if (_loc2_ != null)
                {
                    _loc8_ = _loc2_.getHeight(param1);
                    if (_loc8_ > 0)
                    {
                        _loc7_ = (_loc7_ + _loc8_);
                        _loc5_.push(_loc2_);
                    };
                };
                _loc9_++;
            };
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:int = this.var_4776.height;
            if ((_loc6_ + _loc7_) > this.var_4776.height)
            {
                _loc10_ = ((_loc6_ + _loc7_) - this.var_4776.height);
                _loc11_ = (_loc11_ - (_loc10_ >> 1));
                _loc12_ = (_loc12_ + (_loc10_ - (_loc10_ >> 1)));
            };
            if (_loc10_ == 0)
            {
                _loc2_ = (this.var_4779[(this.var_4779.length >> 1)] as PlaneMaterialCell);
                if (_loc2_ != null)
                {
                    _loc8_ = _loc2_.getHeight(param1);
                    if (_loc8_ > 0)
                    {
                        _loc13_ = (this.var_4776.height - (_loc6_ + _loc7_));
                        _loc14_ = int((Math.ceil((_loc13_ / _loc8_)) * _loc8_));
                        _loc11_ = (_loc6_ - ((_loc14_ - _loc13_) >> 1));
                        _loc15_ = (_loc11_ + _loc14_);
                        _loc16_ = [_loc2_];
                        while (_loc11_ < _loc15_)
                        {
                            _loc11_ = this.renderCells(_loc16_, _loc11_, true, param1);
                        };
                    };
                };
            };
            _loc11_ = 0;
            this.renderCells(_loc4_, _loc11_, true, param1);
            this.renderCells(_loc5_, _loc12_, false, param1);
        }

        private function renderRepeatFirst(param1:IVector3d):void
        {
            var _loc4_:Array;
            if (((this.var_4779.length == 0) || (this.var_4776 == null)))
            {
                return;
            };
            var _loc2_:PlaneMaterialCell;
            var _loc3_:int = this.var_4776.height;
            _loc3_ = this.renderCells(this.var_4779, _loc3_, false, param1);
            _loc2_ = (this.var_4779[0] as PlaneMaterialCell);
            if (_loc2_ != null)
            {
                _loc4_ = [_loc2_];
                while (_loc3_ >= 0)
                {
                    _loc3_ = this.renderCells(_loc4_, _loc3_, false, param1);
                };
            };
        }

        private function renderRepeatLast(param1:IVector3d):void
        {
            var _loc4_:Array;
            if (((this.var_4779.length == 0) || (this.var_4776 == null)))
            {
                return;
            };
            var _loc2_:PlaneMaterialCell;
            var _loc3_:int;
            _loc3_ = this.renderCells(this.var_4779, _loc3_, true, param1);
            _loc2_ = (this.var_4779[(this.var_4779.length - 1)] as PlaneMaterialCell);
            if (_loc2_ != null)
            {
                _loc4_ = [_loc2_];
                while (_loc3_ < this.var_4776.height)
                {
                    _loc3_ = this.renderCells(_loc4_, _loc3_, true, param1);
                };
            };
        }


    }
}