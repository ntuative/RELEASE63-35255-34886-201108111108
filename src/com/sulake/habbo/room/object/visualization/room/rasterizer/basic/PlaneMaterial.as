package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils.IVector3d;
    import flash.display.BitmapData;

    public class PlaneMaterial 
    {

        public static const var_2218:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var var_4773:Array = [];
        private var var_4774:Boolean = false;


        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:PlaneMaterialCellMatrix;
            if (this.var_4773 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4773.length)
                {
                    _loc2_ = (this.var_4773[_loc1_] as PlaneMaterialCellMatrix);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4773 = null;
            };
        }

        public function clearCache():void
        {
            var _loc1_:int;
            var _loc2_:PlaneMaterialCellMatrix;
            if (!this.var_4774)
            {
                return;
            };
            if (this.var_4773 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4773.length)
                {
                    _loc2_ = (this.var_4773[_loc1_] as PlaneMaterialCellMatrix);
                    if (_loc2_ != null)
                    {
                        _loc2_.clearCache();
                    };
                    _loc1_++;
                };
            };
            this.var_4774 = false;
        }

        public function addMaterialCellMatrix(param1:int, param2:int, param3:int, param4:Number=-1, param5:Number=1, param6:Number=-1, param7:Number=1):PlaneMaterialCellMatrix
        {
            var _loc8_:PlaneMaterialCellMatrix;
            _loc8_ = new PlaneMaterialCellMatrix(param1, param2, param3, param4, param5, param6, param7);
            this.var_4773.push(_loc8_);
            return (_loc8_);
        }

        private function getMaterialCellMatrix(param1:IVector3d):PlaneMaterialCellMatrix
        {
            var _loc3_:PlaneMaterialCellMatrix;
            if (param1 == null)
            {
                return (null);
            };
            var _loc2_:int;
            while (_loc2_ < this.var_4773.length)
            {
                _loc3_ = (this.var_4773[_loc2_] as PlaneMaterialCellMatrix);
                if (_loc3_ != null)
                {
                    if (((((param1.x >= _loc3_.normalMinX) && (param1.x <= _loc3_.normalMaxX)) && (param1.y >= _loc3_.normalMinY)) && (param1.y <= _loc3_.normalMaxY)))
                    {
                        return (_loc3_);
                    };
                };
                _loc2_++;
            };
            return (null);
        }

        public function render(param1:BitmapData, param2:int, param3:int, param4:IVector3d, param5:Boolean, param6:int, param7:Boolean):BitmapData
        {
            if (param2 < 1)
            {
                param2 = 1;
            };
            if (param3 < 1)
            {
                param3 = 1;
            };
            var _loc8_:PlaneMaterialCellMatrix = this.getMaterialCellMatrix(param4);
            if (_loc8_ != null)
            {
                this.var_4774 = true;
                return (_loc8_.render(param1, param2, param3, param4, param5, param6, param7));
            };
            return (null);
        }


    }
}