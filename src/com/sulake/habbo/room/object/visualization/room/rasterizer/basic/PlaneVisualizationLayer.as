package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;

    public class PlaneVisualizationLayer implements IDisposable 
    {

        public static const var_2230:int = 0;
        public static const var_2225:int = 1;
        public static const var_2111:int = 2;
        public static const ALIGN_DEFAULT:int = var_2225;//1

        private var _material:PlaneMaterial = null;
        private var _color:uint = 0;
        private var _offset:int = 0;
        private var _align:int = 1;
        private var _bitmapData:BitmapData = null;
        private var var_1023:Boolean = false;

        public function PlaneVisualizationLayer(param1:PlaneMaterial, param2:uint, param3:int, param4:int=0)
        {
            this._material = param1;
            this._offset = param4;
            this._align = param3;
            this._color = param2;
        }

        public function get offset():int
        {
            return (this._offset);
        }

        public function get align():int
        {
            return (this._align);
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function dispose():void
        {
            this.var_1023 = true;
            this._material = null;
            if (this._bitmapData != null)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
        }

        public function clearCache():void
        {
            if (this._bitmapData != null)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
        }

        public function render(param1:BitmapData, param2:int, param3:int, param4:IVector3d, param5:Boolean):BitmapData
        {
            var _loc11_:Number;
            var _loc12_:Number;
            var _loc13_:Number;
            var _loc14_:ColorTransform;
            var _loc6_:uint = (this._color >> 16);
            var _loc7_:uint = ((this._color >> 8) & 0xFF);
            var _loc8_:uint = (this._color & 0xFF);
            var _loc9_:Boolean;
            if ((((_loc6_ < 0xFF) || (_loc7_ < 0xFF)) || (_loc8_ < 0xFF)))
            {
                _loc9_ = true;
            };
            if ((((param1 == null) || (!(param1.width == param2))) || (!(param1.height == param3))))
            {
                param1 = null;
            };
            var _loc10_:BitmapData;
            if (this._material != null)
            {
                if (_loc9_)
                {
                    _loc10_ = this._material.render(null, param2, param3, param4, param5, this.offset, (this.align == var_2225));
                }
                else
                {
                    _loc10_ = this._material.render(param1, param2, param3, param4, param5, this.offset, (this.align == var_2225));
                };
                if (((!(_loc10_ == null)) && (!(_loc10_ == param1))))
                {
                    if (this._bitmapData != null)
                    {
                        this._bitmapData.dispose();
                    };
                    this._bitmapData = _loc10_.clone();
                    _loc10_ = this._bitmapData;
                };
            }
            else
            {
                if (param1 == null)
                {
                    if ((((!(this._bitmapData == null)) && (this._bitmapData.width == param2)) && (this._bitmapData.height == param3)))
                    {
                        return (this._bitmapData);
                    };
                    if (this._bitmapData != null)
                    {
                        this._bitmapData.dispose();
                    };
                    this._bitmapData = new BitmapData(param2, param3, true, 0xFFFFFFFF);
                    _loc10_ = this._bitmapData;
                }
                else
                {
                    param1.fillRect(param1.rect, 0xFFFFFFFF);
                    _loc10_ = param1;
                };
            };
            if (_loc10_ != null)
            {
                if (_loc9_)
                {
                    _loc11_ = (_loc6_ / 0xFF);
                    _loc12_ = (_loc7_ / 0xFF);
                    _loc13_ = (_loc8_ / 0xFF);
                    _loc14_ = new ColorTransform(_loc11_, _loc12_, _loc13_);
                    _loc10_.colorTransform(_loc10_.rect, _loc14_);
                    if (((!(param1 == null)) && (!(_loc10_ == param1))))
                    {
                        param1.copyPixels(_loc10_, _loc10_.rect, new Point(0, 0), null, null, true);
                        _loc10_ = param1;
                    };
                };
            };
            return (_loc10_);
        }


    }
}