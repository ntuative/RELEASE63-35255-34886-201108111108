package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class AnimationItem 
    {

        private var _x:Number = 0;
        private var var_2960:Number = 0;
        private var var_4767:Number = 0;
        private var var_4768:Number = 0;
        private var _bitmapData:BitmapData = null;

        public function AnimationItem(param1:Number, param2:Number, param3:Number, param4:Number, param5:BitmapData)
        {
            this._x = param1;
            this.var_2960 = param2;
            this.var_4767 = param3;
            this.var_4768 = param4;
            if (isNaN(this._x))
            {
                this._x = 0;
            };
            if (isNaN(this.var_2960))
            {
                this.var_2960 = 0;
            };
            if (isNaN(this.var_4767))
            {
                this.var_4767 = 0;
            };
            if (isNaN(this.var_4768))
            {
                this.var_4768 = 0;
            };
            this._bitmapData = param5;
        }

        public function get bitmapData():BitmapData
        {
            return (this._bitmapData);
        }

        public function dispose():void
        {
            this._bitmapData = null;
        }

        public function getPosition(param1:int, param2:int, param3:Number, param4:Number, param5:int):Point
        {
            var _loc6_:Number = this._x;
            var _loc7_:Number = this.var_2960;
            if (param3 > 0)
            {
                _loc6_ = (_loc6_ + (((this.var_4767 / param3) * param5) / 1000));
            };
            if (param4 > 0)
            {
                _loc7_ = (_loc7_ + (((this.var_4768 / param4) * param5) / 1000));
            };
            var _loc8_:int = ((_loc6_ % 1) * param1);
            var _loc9_:int = ((_loc7_ % 1) * param2);
            return (new Point(_loc8_, _loc9_));
        }


    }
}