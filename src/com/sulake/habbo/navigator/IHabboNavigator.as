package com.sulake.habbo.navigator
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IHabboNavigator extends IUnknown 
    {

        function get events():IEventDispatcher;
        function goToHomeRoom():Boolean;
        function performTagSearch(param1:String):void;
        function showOwnRooms():void;
        function goToRoom(param1:int, param2:Boolean, param3:String="", param4:int=-1):void;

    }
}