package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;

    public interface IFriendListTabsDeps 
    {

        function getFriendList():HabboFriendList;
        function getWindowHeight():int;

    }
}