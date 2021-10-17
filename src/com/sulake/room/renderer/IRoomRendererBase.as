package com.sulake.room.renderer
{
    import com.sulake.room.object.IRoomObject;

    public interface IRoomRendererBase 
    {

        function dispose():void;
        function reset():void;
        function feedRoomObject(param1:IRoomObject):void;
        function removeRoomObject(param1:int):void;
        function update(param1:uint):void;

    }
}