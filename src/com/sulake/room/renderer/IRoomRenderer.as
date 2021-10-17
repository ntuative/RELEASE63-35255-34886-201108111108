package com.sulake.room.renderer
{
    public interface IRoomRenderer extends IRoomRendererBase 
    {

        function set roomObjectVariableAccurateZ(param1:String):void;
        function createCanvas(param1:int, param2:int, param3:int, param4:int):IRoomRenderingCanvas;
        function getCanvas(param1:int):IRoomRenderingCanvas;
        function disposeCanvas(param1:int):Boolean;

    }
}