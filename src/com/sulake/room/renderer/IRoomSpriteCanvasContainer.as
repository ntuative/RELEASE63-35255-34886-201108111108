package com.sulake.room.renderer
{
    import com.sulake.room.object.IRoomObject;

    public interface IRoomSpriteCanvasContainer 
    {

        function get roomObjectVariableAccurateZ():String;
        function getRoomObject(param1:String):IRoomObject;
        function getRoomObjectWithIndex(param1:int):IRoomObject;
        function getRoomObjectIdWithIndex(param1:int):String;
        function getRoomObjectCount():int;

    }
}