package com.sulake.room
{
    import com.sulake.room.object.IRoomObject;

    public interface IRoomInstanceContainer 
    {

        function createRoomObject(param1:String, param2:int, param3:String, param4:int):IRoomObject;
        function createRoomObjectManager():IRoomObjectManager;

    }
}