package com.sulake.habbo.friendlist.domain
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;

    public class AvatarSearchResults 
    {

        private var var_3950:IAvatarSearchDeps;
        private var var_3154:Array;
        private var var_3663:Array;
        private var var_3951:Dictionary = new Dictionary();

        public function AvatarSearchResults(param1:IAvatarSearchDeps)
        {
            this.var_3950 = param1;
        }

        public function getResult(param1:int):HabboSearchResultData
        {
            var _loc2_:HabboSearchResultData;
            var _loc3_:HabboSearchResultData;
            for each (_loc2_ in this.var_3154)
            {
                if (_loc2_.avatarId == param1)
                {
                    return (_loc2_);
                };
            };
            for each (_loc3_ in this.var_3663)
            {
                if (_loc3_.avatarId == param1)
                {
                    return (_loc3_);
                };
            };
            return (null);
        }

        public function searchReceived(param1:Array, param2:Array):void
        {
            this.var_3154 = param1;
            this.var_3663 = param2;
            this.var_3950.view.refreshList();
        }

        public function get friends():Array
        {
            return (this.var_3154);
        }

        public function get others():Array
        {
            return (this.var_3663);
        }

        public function setFriendRequestSent(param1:int):void
        {
            this.var_3951[param1] = "yes";
        }

        public function isFriendRequestSent(param1:int):Boolean
        {
            return (!(this.var_3951[param1] == null));
        }


    }
}