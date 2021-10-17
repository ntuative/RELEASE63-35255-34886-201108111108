package com.sulake.habbo.friendlist
{
    import com.sulake.habbo.friendlist.domain.FriendRequest;

    public interface IFriendRequestsView 
    {

        function refreshShading(param1:FriendRequest, param2:Boolean):void;
        function refreshRequestEntry(param1:FriendRequest):void;
        function addRequest(param1:FriendRequest):void;
        function removeRequest(param1:FriendRequest):void;
        function acceptRequest(param1:int):void;
        function acceptAllRequests():void;
        function declineRequest(param1:int):void;
        function declineAllRequests():void;

    }
}