package com.sulake.room.object.visualization
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public interface IRoomObjectVisualization 
    {

        function set object(param1:IRoomObject):void;
        function get object():IRoomObject;
        function dispose():void;
        function initialize(param1:IRoomObjectVisualizationData):Boolean;
        function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean):void;
        function get image():BitmapData;
        function getImage(param1:int):BitmapData;
        function get boundingRectangle():Rectangle;
        function getInstanceId():int;
        function getUpdateID():int;

    }
}