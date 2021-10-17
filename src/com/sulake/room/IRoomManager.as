package com.sulake.room
{
    import com.sulake.core.runtime.IUnknown;

    public interface IRoomManager extends IUnknown 
    {

        function initialize(param1:XML, param2:IRoomManagerListener):Boolean;
        function update(param1:uint):void;
        function setContentLoader(param1:IRoomContentLoader):void;
        function addObjectUpdateCategory(param1:int):void;
        function removeObjectUpdateCategory(param1:int):void;
        function createRoom(param1:String, param2:XML):IRoomInstance;
        function disposeRoom(param1:String):Boolean;
        function getRoom(param1:String):IRoomInstance;
        function getRoomWithIndex(param1:int):IRoomInstance;
        function getRoomCount():int;
        function isContentAvailable(param1:String):Boolean;

    }
}