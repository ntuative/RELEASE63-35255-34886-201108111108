package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.visualization.data.ColorData;

    public class FurnitureStickieVisualization extends FurnitureVisualization 
    {

        private var _data:FurnitureVisualizationData = null;


        override public function initialize(param1:IRoomObjectVisualizationData):Boolean
        {
            this._data = (param1 as FurnitureVisualizationData);
            return (super.initialize(param1));
        }

        override protected function getSpriteColor(param1:int, param2:int, param3:int):int
        {
            if (this._data == null)
            {
                return (ColorData.var_1446);
            };
            return (this._data.getColor(param1, param2, param3));
        }


    }
}