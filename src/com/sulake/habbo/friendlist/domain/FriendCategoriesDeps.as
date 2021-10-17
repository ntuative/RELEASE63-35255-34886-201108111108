package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.HabboFriendList;
    import com.sulake.habbo.friendlist.IFriendsView;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.notifications.IHabboNotifications;

    public class FriendCategoriesDeps implements IFriendCategoriesDeps 
    {

        private var _friendList:HabboFriendList;

        public function FriendCategoriesDeps(param1:HabboFriendList)
        {
            this._friendList = param1;
        }

        public function get view():IFriendsView
        {
            return (this._friendList.tabs.findTab(FriendListTab.var_535).tabView as IFriendsView);
        }

        public function get messenger():IHabboMessenger
        {
            return (this._friendList.messenger);
        }

        public function get notifications():IHabboNotifications
        {
            return (this._friendList.notifications);
        }


    }
}