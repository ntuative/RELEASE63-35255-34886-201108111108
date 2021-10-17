package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;

    public class PlaneTextureBitmap 
    {

        public static const var_2218:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var _bitmap:BitmapData = null;
        private var var_4746:Number = -1;
        private var _normalMaxX:Number = 1;
        private var var_4747:Number = -1;
        private var var_4748:Number = 1;

        public function PlaneTextureBitmap(param1:BitmapData, param2:Number=-1, param3:Number=1, param4:Number=-1, param5:Number=1)
        {
            this.var_4746 = param2;
            this._normalMaxX = param3;
            this.var_4747 = param4;
            this.var_4748 = param5;
            this._bitmap = param1;
        }

        public function get bitmap():BitmapData
        {
            return (this._bitmap);
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

        public function dispose():void
        {
            this._bitmap = null;
        }


    }
}