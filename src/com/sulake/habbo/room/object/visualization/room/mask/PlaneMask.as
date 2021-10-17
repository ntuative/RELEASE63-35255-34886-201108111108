package com.sulake.habbo.room.object.visualization.room.mask
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;

    public class PlaneMask 
    {

        private var var_4744:Map;
        private var _sizes:Array = [];
        private var var_4745:PlaneMaskVisualization = null;
        private var var_4719:int = -1;

        public function PlaneMask()
        {
            this.var_4744 = new Map();
        }

        public function dispose():void
        {
            var _loc1_:PlaneMaskVisualization;
            var _loc2_:int;
            if (this.var_4744 != null)
            {
                _loc1_ = null;
                _loc2_ = 0;
                while (_loc2_ < this.var_4744.length)
                {
                    _loc1_ = (this.var_4744.getWithIndex(_loc2_) as PlaneMaskVisualization);
                    if (_loc1_ != null)
                    {
                        _loc1_.dispose();
                    };
                    _loc2_++;
                };
                this.var_4744.dispose();
                this.var_4744 = null;
            };
            this.var_4745 = null;
            this._sizes = null;
        }

        public function createMaskVisualization(param1:int):PlaneMaskVisualization
        {
            if (this.var_4744.getValue(String(param1)) != null)
            {
                return (null);
            };
            var _loc2_:PlaneMaskVisualization = new PlaneMaskVisualization();
            this.var_4744.add(String(param1), _loc2_);
            this._sizes.push(param1);
            this._sizes.sort();
            return (_loc2_);
        }

        private function getSizeIndex(param1:int):int
        {
            var _loc2_:int;
            var _loc3_:int = 1;
            while (_loc3_ < this._sizes.length)
            {
                if (this._sizes[_loc3_] > param1)
                {
                    if ((this._sizes[_loc3_] - param1) < (param1 - this._sizes[(_loc3_ - 1)]))
                    {
                        _loc2_ = _loc3_;
                    };
                    break;
                };
                _loc2_ = _loc3_;
                _loc3_++;
            };
            return (_loc2_);
        }

        protected function getMaskVisualization(param1:int):PlaneMaskVisualization
        {
            if (param1 == this.var_4719)
            {
                return (this.var_4745);
            };
            var _loc2_:int = this.getSizeIndex(param1);
            if (_loc2_ < this._sizes.length)
            {
                this.var_4745 = (this.var_4744.getValue(String(this._sizes[_loc2_])) as PlaneMaskVisualization);
            }
            else
            {
                this.var_4745 = null;
            };
            this.var_4719 = param1;
            return (this.var_4745);
        }

        public function getGraphicAsset(param1:Number, param2:IVector3d):IGraphicAsset
        {
            var _loc3_:PlaneMaskVisualization = this.getMaskVisualization(param1);
            if (_loc3_ == null)
            {
                return (null);
            };
            return (_loc3_.getAsset(param2));
        }


    }
}