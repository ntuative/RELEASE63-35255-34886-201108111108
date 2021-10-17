package com.sulake.room
{
    import com.sulake.room.object.IRoomObjectController;

    public interface IRoomObjectManager 
    {

        function dispose():void;
        function createObject(param1:int, param2:uint, param3:String):IRoomObjectController;
        function getObject(param1:int):IRoomObjectController;
        function disposeObject(param1:int):Boolean;
        function getObjectCount():int;
        function getObjectWithIndex(param1:int):IRoomObjectController;
        function getObjectCountForType(param1:String):int;
        function getObjectWithIndexAndType(param1:int, param2:String):IRoomObjectController;
        function reset():void;

    }
}