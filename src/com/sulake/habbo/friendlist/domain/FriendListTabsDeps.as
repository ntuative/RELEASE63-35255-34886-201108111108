package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;

    public class FriendListTabsDeps implements IFriendListTabsDeps 
    {

        private var _friendList:HabboFriendList;

        public function FriendListTabsDeps(param1:HabboFriendList)
        {
            this._friendList = param1;
        }

        public function getFriendList():HabboFriendList
        {
            return (this._friendList);
        }

        public function getWindowHeight():int
        {
            return (this._friendList.view.mainWindow.height);
        }


    }
}