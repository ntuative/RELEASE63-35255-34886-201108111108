package com.sulake.room.object.visualization
{
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;

    public interface IRoomObjectGraphicVisualization extends IRoomObjectVisualization 
    {

        function get assetCollection():IGraphicAssetCollection;
        function set assetCollection(param1:IGraphicAssetCollection):void;

    }
}