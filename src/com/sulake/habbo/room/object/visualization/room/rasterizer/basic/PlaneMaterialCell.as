package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.geom.Matrix;
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;

    public class PlaneMaterialCell 
    {

        private var var_4776:BitmapData = null;
        private var var_4777:PlaneTexture;
        private var _extraItemOffsets:Array = [];
        private var var_4775:Array = [];
        private var var_4778:int = 0;

        public function PlaneMaterialCell(param1:PlaneTexture, param2:Array=null, param3:Array=null, param4:int=0)
        {
            var _loc5_:int;
            var _loc6_:IGraphicAsset;
            var _loc7_:Point;
            super();
            this.var_4777 = param1;
            if ((((!(param2 == null)) && (param2.length > 0)) && (param4 > 0)))
            {
                _loc5_ = 0;
                _loc5_ = 0;
                while (_loc5_ < param2.length)
                {
                    _loc6_ = (param2[_loc5_] as IGraphicAsset);
                    if (_loc6_ != null)
                    {
                        this.var_4775.push(_loc6_);
                    };
                    _loc5_++;
                };
                if (this.var_4775.length > 0)
                {
                    if (param3 != null)
                    {
                        _loc5_ = 0;
                        while (_loc5_ < param3.length)
                        {
                            _loc7_ = (param3[_loc5_] as Point);
                            if (_loc7_ != null)
                            {
                                this._extraItemOffsets.push(new Point(_loc7_.x, _loc7_.y));
                            };
                            _loc5_++;
                        };
                    };
                    this.var_4778 = param4;
                };
            };
        }

        public function get isStatic():Boolean
        {
            return (this.var_4778 == 0);
        }

        public function dispose():void
        {
            if (this.var_4777 != null)
            {
                this.var_4777.dispose();
                this.var_4777 = null;
            };
            if (this.var_4776 != null)
            {
                this.var_4776.dispose();
                this.var_4776 = null;
            };
            this.var_4775 = null;
            this._extraItemOffsets = null;
        }

        public function clearCache():void
        {
            if (this.var_4776 != null)
            {
                this.var_4776.dispose();
                this.var_4776 = null;
            };
        }

        public function getHeight(param1:IVector3d):int
        {
            var _loc2_:BitmapData;
            if (this.var_4777 != null)
            {
                _loc2_ = this.var_4777.getBitmap(param1);
                if (_loc2_ != null)
                {
                    return (_loc2_.height);
                };
            };
            return (0);
        }

        public function render(param1:IVector3d):BitmapData
        {
            var _loc2_:BitmapData;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:Array;
            var _loc6_:int;
            var _loc7_:Point;
            var _loc8_:IGraphicAsset;
            var _loc9_:BitmapDataAsset;
            var _loc10_:BitmapData;
            var _loc11_:Point;
            var _loc12_:Matrix;
            var _loc13_:Number;
            var _loc14_:Number;
            var _loc15_:Number;
            var _loc16_:Number;
            var _loc17_:int;
            if (this.var_4777 != null)
            {
                _loc2_ = this.var_4777.getBitmap(param1);
                if (_loc2_ != null)
                {
                    if (!this.isStatic)
                    {
                        if (this.var_4776 != null)
                        {
                            if (((!(this.var_4776.width == _loc2_.width)) || (!(this.var_4776.height == _loc2_.height))))
                            {
                                this.var_4776.dispose();
                                this.var_4776 = null;
                            }
                            else
                            {
                                this.var_4776.copyPixels(_loc2_, _loc2_.rect, new Point(0, 0));
                            };
                        };
                        if (this.var_4776 == null)
                        {
                            this.var_4776 = _loc2_.clone();
                        };
                        _loc3_ = Math.min(this.var_4778, this._extraItemOffsets.length);
                        _loc4_ = Math.max(this.var_4778, this._extraItemOffsets.length);
                        _loc5_ = Randomizer.getArray(this.var_4778, _loc4_);
                        _loc6_ = 0;
                        while (_loc6_ < _loc3_)
                        {
                            _loc7_ = (this._extraItemOffsets[_loc5_[_loc6_]] as Point);
                            _loc8_ = (this.var_4775[(_loc6_ % this.var_4775.length)] as IGraphicAsset);
                            if (((!(_loc7_ == null)) && (!(_loc8_ == null))))
                            {
                                _loc9_ = (_loc8_.asset as BitmapDataAsset);
                                if (_loc9_ != null)
                                {
                                    _loc10_ = (_loc9_.content as BitmapData);
                                    if (_loc10_ != null)
                                    {
                                        _loc11_ = new Point((_loc7_.x + _loc8_.offsetX), (_loc7_.y + _loc8_.offsetY));
                                        _loc12_ = new Matrix();
                                        _loc13_ = 1;
                                        _loc14_ = 1;
                                        _loc15_ = 0;
                                        _loc16_ = 0;
                                        if (_loc8_.flipH)
                                        {
                                            _loc13_ = -1;
                                            _loc15_ = _loc10_.width;
                                        };
                                        if (_loc8_.flipV)
                                        {
                                            _loc14_ = -1;
                                            _loc16_ = _loc10_.height;
                                        };
                                        _loc17_ = (_loc11_.x + _loc15_);
                                        _loc17_ = ((_loc17_ >> 1) << 1);
                                        _loc12_.scale(_loc13_, _loc14_);
                                        _loc12_.translate(_loc17_, (_loc11_.y + _loc16_));
                                        this.var_4776.draw(_loc10_, _loc12_);
                                    };
                                };
                            };
                            _loc6_++;
                        };
                        return (this.var_4776);
                    };
                    return (_loc2_);
                };
            };
            return (null);
        }


    }
}