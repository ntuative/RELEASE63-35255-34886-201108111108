package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;
    import com.sulake.room.utils.IVector3d;

    public class PlaneTexture 
    {

        public static const var_2218:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var var_4751:Array = [];


        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:PlaneTextureBitmap;
            if (this.var_4751 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4751.length)
                {
                    _loc2_ = (this.var_4751[_loc1_] as PlaneTextureBitmap);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4751 = null;
            };
        }

        public function addBitmap(param1:BitmapData, param2:Number=-1, param3:Number=1, param4:Number=-1, param5:Number=1):void
        {
            var _loc6_:PlaneTextureBitmap = new PlaneTextureBitmap(param1, param2, param3, param4, param5);
            this.var_4751.push(_loc6_);
        }

        public function getBitmap(param1:IVector3d):BitmapData
        {
            var _loc3_:PlaneTextureBitmap;
            if (param1 == null)
            {
                return (null);
            };
            var _loc2_:int;
            while (_loc2_ < this.var_4751.length)
            {
                _loc3_ = (this.var_4751[_loc2_] as PlaneTextureBitmap);
                if (_loc3_ != null)
                {
                    if (((((param1.x >= _loc3_.normalMinX) && (param1.x <= _loc3_.normalMaxX)) && (param1.y >= _loc3_.normalMinY)) && (param1.y <= _loc3_.normalMaxY)))
                    {
                        return (_loc3_.bitmap);
                    };
                };
                _loc2_++;
            };
            return (null);
        }


    }
}