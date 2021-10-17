package com.sulake.habbo.friendlist
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;

    public interface IHabboFriendList extends IUnknown 
    {

        function get events():IEventDispatcher;
        function canBeAskedForAFriend(param1:int):Boolean;
        function askForAFriend(param1:int, param2:String):Boolean;
        function getFriend(param1:int):IFriend;
        function openFriendList():void;
        function openFriendRequests():void;
        function openFriendSearch():void;
        function close():void;
        function isOpen():Boolean;
        function getFriendCount(param1:Boolean, param2:Boolean):int;
        function openHabboWebPage(param1:String, param2:Dictionary, param3:int, param4:int):void;
        function getFriendNames():Array;
        function acceptFriendRequest(param1:int):void;
        function acceptAllFriendRequests():void;
        function declineFriendRequest(param1:int):void;
        function declineAllFriendRequests():void;
        function get mainWindow():IWindowContainer;

    }
}