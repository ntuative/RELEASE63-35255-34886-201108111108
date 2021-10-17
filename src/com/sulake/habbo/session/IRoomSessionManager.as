package com.sulake.habbo.session
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IRoomSessionManager extends IUnknown 
    {

        function set roomEngineReady(param1:Boolean):void;
        function gotoRoom(param1:Boolean, param2:int, param3:String="", param4:String=""):Boolean;
        function startSession(param1:IRoomSession):Boolean;
        function getSession(param1:int, param2:int):IRoomSession;
        function get events():IEventDispatcher;
        function get sessionStarting():Boolean;

    }
}