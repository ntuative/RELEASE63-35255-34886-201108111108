package com.sulake.room.object
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.room.object.visualization.IRoomObjectGraphicVisualization;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;

    public interface IRoomObjectVisualizationFactory extends IUnknown 
    {

        function createRoomObjectVisualization(param1:String):IRoomObjectGraphicVisualization;
        function createGraphicAssetCollection():IGraphicAssetCollection;
        function getRoomObjectVisualizationData(param1:String, param2:String, param3:XML):IRoomObjectVisualizationData;

    }
}