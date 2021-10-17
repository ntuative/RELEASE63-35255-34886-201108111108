package com.sulake.habbo.session
{
    import flash.events.IEventDispatcher;

    public interface IRoomHandlerListener 
    {

        function sessionUpdate(param1:int, param2:int, param3:String):void;
        function sessionReinitialize(param1:int, param2:int, param3:int, param4:int):void;
        function getSession(param1:int, param2:int):IRoomSession;
        function get events():IEventDispatcher;

    }
}