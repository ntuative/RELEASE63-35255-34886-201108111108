package com.sulake.room.renderer
{
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;

    public interface IRoomRenderingCanvasMouseListener 
    {

        function processRoomCanvasMouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomObject, param3:IRoomGeometry):void;

    }
}