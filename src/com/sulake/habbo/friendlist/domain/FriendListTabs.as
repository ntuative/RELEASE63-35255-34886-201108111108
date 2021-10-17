package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.FriendsView;
    import com.sulake.habbo.friendlist.FriendRequestsView;
    import com.sulake.habbo.friendlist.SearchView;
    import com.sulake.habbo.friendlist.*;

    public class FriendListTabs 
    {

        private var var_3950:IFriendListTabsDeps;
        private var var_3281:Array = new Array();
        private var var_3958:FriendListTab;
        private var var_3959:int = 200;
        private var var_3960:int = 200;
        private var var_3961:int = 200;

        public function FriendListTabs(param1:IFriendListTabsDeps)
        {
            this.var_3950 = param1;
            this.var_3281.push(new FriendListTab(this.var_3950.getFriendList(), FriendListTab.var_535, new FriendsView(), "${friendlist.friends}", "friends_footer", "hdr_friends"));
            this.var_3281.push(new FriendListTab(this.var_3950.getFriendList(), FriendListTab.var_536, new FriendRequestsView(), "${friendlist.tab.friendrequests}", "friend_requests_footer", "hdr_friend_requests"));
            this.var_3281.push(new FriendListTab(this.var_3950.getFriendList(), FriendListTab.var_537, new SearchView(), "${generic.search}", "search_footer", "hdr_search"));
            this.toggleSelected(null);
        }

        public function getTabs():Array
        {
            return (this.var_3281);
        }

        public function findTab(param1:int):FriendListTab
        {
            var _loc2_:FriendListTab;
            for each (_loc2_ in this.var_3281)
            {
                if (_loc2_.id == param1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }

        public function clearSelections():void
        {
            var _loc1_:FriendListTab;
            for each (_loc1_ in this.var_3281)
            {
                _loc1_.setSelected(false);
            };
        }

        public function findSelectedTab():FriendListTab
        {
            var _loc1_:FriendListTab;
            for each (_loc1_ in this.var_3281)
            {
                if (_loc1_.selected)
                {
                    return (_loc1_);
                };
            };
            return (null);
        }

        public function toggleSelected(param1:FriendListTab):void
        {
            var _loc2_:FriendListTab = this.findSelectedTab();
            if (_loc2_ == null)
            {
                this.var_3959 = this.var_3960;
                this.setSelected(this.determineDisplayedTab(param1), true);
            }
            else
            {
                if (((_loc2_ == param1) || (param1 == null)))
                {
                    this.var_3960 = this.var_3959;
                    this.var_3959 = 0;
                    this.clearSelections();
                }
                else
                {
                    this.setSelected(this.determineDisplayedTab(param1), true);
                };
            };
        }

        private function setSelected(param1:FriendListTab, param2:Boolean):void
        {
            var _loc3_:FriendListTab = this.findSelectedTab();
            this.clearSelections();
            param1.setSelected(param2);
            if (param2)
            {
                this.var_3958 = param1;
            };
        }

        private function determineDisplayedTab(param1:FriendListTab):FriendListTab
        {
            if (param1 != null)
            {
                return (param1);
            };
            if (this.var_3958 != null)
            {
                return (this.var_3958);
            };
            return (this.var_3281[0]);
        }

        public function get tabContentHeight():int
        {
            return (this.var_3959);
        }

        public function get windowWidth():int
        {
            return (this.var_3961);
        }

        public function get tabContentWidth():int
        {
            return (this.var_3961 - 2);
        }

        public function set tabContentHeight(param1:int):void
        {
            this.var_3959 = param1;
        }

        public function set windowWidth(param1:int):void
        {
            this.var_3961 = param1;
        }


    }
}