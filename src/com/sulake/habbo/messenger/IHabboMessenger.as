package com.sulake.habbo.messenger
{
    import com.sulake.core.runtime.IUnknown;

    public interface IHabboMessenger extends IUnknown 
    {

        function isOpen():Boolean;
        function toggleMessenger():void;
        function startConversation(param1:int):void;
        function getActiveConversation():IConversation;
        function setFollowingAllowed(param1:int, param2:Boolean):void;
        function setOnlineStatus(param1:int, param2:Boolean):void;

    }
}