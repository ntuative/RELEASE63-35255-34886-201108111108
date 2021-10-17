package com.sulake.habbo.room.object.visualization.room
{
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.FloorRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallAdRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.animated.LandscapeRasterizer;
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;

    public class RoomVisualizationData implements IRoomObjectVisualizationData 
    {

        private var var_4825:WallRasterizer;
        private var var_4826:FloorRasterizer;
        private var var_4827:WallAdRasterizer;
        private var var_4828:LandscapeRasterizer;
        private var var_4795:PlaneMaskManager;
        private var var_2709:Boolean = false;

        public function RoomVisualizationData()
        {
            this.var_4825 = new WallRasterizer();
            this.var_4826 = new FloorRasterizer();
            this.var_4827 = new WallAdRasterizer();
            this.var_4828 = new LandscapeRasterizer();
            this.var_4795 = new PlaneMaskManager();
        }

        public function get initialized():Boolean
        {
            return (this.var_2709);
        }

        public function get floorRasterizer():IPlaneRasterizer
        {
            return (this.var_4826);
        }

        public function get wallRasterizer():IPlaneRasterizer
        {
            return (this.var_4825);
        }

        public function get wallAdRasterizr():WallAdRasterizer
        {
            return (this.var_4827);
        }

        public function get landscapeRasterizer():IPlaneRasterizer
        {
            return (this.var_4828);
        }

        public function get maskManager():PlaneMaskManager
        {
            return (this.var_4795);
        }

        public function dispose():void
        {
            if (this.var_4825 != null)
            {
                this.var_4825.dispose();
                this.var_4825 = null;
            };
            if (this.var_4826 != null)
            {
                this.var_4826.dispose();
                this.var_4826 = null;
            };
            if (this.var_4827 != null)
            {
                this.var_4827.dispose();
                this.var_4827 = null;
            };
            if (this.var_4828 != null)
            {
                this.var_4828.dispose();
                this.var_4828 = null;
            };
            if (this.var_4795 != null)
            {
                this.var_4795.dispose();
                this.var_4795 = null;
            };
        }

        public function clearCache():void
        {
            if (this.var_4825 != null)
            {
                this.var_4825.clearCache();
            };
            if (this.var_4826 != null)
            {
                this.var_4826.clearCache();
            };
            if (this.var_4828 != null)
            {
                this.var_4828.clearCache();
            };
        }

        public function initialize(param1:XML):Boolean
        {
            var _loc7_:XML;
            var _loc8_:XML;
            var _loc9_:XML;
            var _loc10_:XML;
            var _loc11_:XML;
            this.reset();
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:XMLList = param1.wallData;
            if (_loc2_.length() > 0)
            {
                _loc7_ = _loc2_[0];
                this.var_4825.initialize(_loc7_);
            };
            var _loc3_:XMLList = param1.floorData;
            if (_loc3_.length() > 0)
            {
                _loc8_ = _loc3_[0];
                this.var_4826.initialize(_loc8_);
            };
            var _loc4_:XMLList = param1.wallAdData;
            if (_loc4_.length() > 0)
            {
                _loc9_ = _loc4_[0];
                this.var_4827.initialize(_loc9_);
            };
            var _loc5_:XMLList = param1.landscapeData;
            if (_loc5_.length() > 0)
            {
                _loc10_ = _loc5_[0];
                this.var_4828.initialize(_loc10_);
            };
            var _loc6_:XMLList = param1.maskData;
            if (_loc6_.length() > 0)
            {
                _loc11_ = _loc6_[0];
                this.var_4795.initialize(_loc11_);
            };
            return (true);
        }

        public function initializeAssetCollection(param1:IGraphicAssetCollection):void
        {
            if (this.var_2709)
            {
                return;
            };
            this.var_4825.initializeAssetCollection(param1);
            this.var_4826.initializeAssetCollection(param1);
            this.var_4827.initializeAssetCollection(param1);
            this.var_4828.initializeAssetCollection(param1);
            this.var_4795.initializeAssetCollection(param1);
            this.var_2709 = true;
        }

        protected function reset():void
        {
        }


    }
}