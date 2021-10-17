package com.sulake.room.object.logic
{
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public interface IRoomObjectMouseHandler 
    {

        function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry):void;

    }
}