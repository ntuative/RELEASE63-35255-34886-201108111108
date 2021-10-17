package com.sulake.habbo.room.object.visualization.room.publicroom
{
    import com.sulake.habbo.room.object.visualization.room.RoomVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer.LayoutRasterizer;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;

    public class PublicRoomVisualizationData extends RoomVisualizationData 
    {

        private var _layoutRasterizer:LayoutRasterizer;
        private var var_2709:Boolean = false;

        public function PublicRoomVisualizationData()
        {
            this._layoutRasterizer = new LayoutRasterizer();
        }

        public function get layoutRasterizer():LayoutRasterizer
        {
            return (this._layoutRasterizer);
        }

        override public function dispose():void
        {
            super.dispose();
            if (this._layoutRasterizer != null)
            {
                this._layoutRasterizer.dispose();
                this._layoutRasterizer = null;
            };
        }

        override public function initialize(param1:XML):Boolean
        {
            var _loc4_:XML;
            if (!super.initialize(param1))
            {
                return (false);
            };
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:XMLList = param1.layoutData;
            var _loc3_:int;
            while (_loc3_ < _loc2_.length())
            {
                _loc4_ = _loc2_[_loc3_];
                this._layoutRasterizer.initialize(_loc4_);
                _loc3_++;
            };
            return (true);
        }

        override public function initializeAssetCollection(param1:IGraphicAssetCollection):void
        {
            if (initialized)
            {
                return;
            };
            super.initializeAssetCollection(param1);
            this._layoutRasterizer.initializeAssetCollection(param1);
        }

        override protected function reset():void
        {
            super.reset();
        }


    }
}