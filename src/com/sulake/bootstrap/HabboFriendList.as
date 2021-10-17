package com.sulake.bootstrap
{
    import com.sulake.habbo.friendlist.HabboFriendList;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboFriendList extends com.sulake.habbo.friendlist.HabboFriendList 
    {

        public function HabboFriendList(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
        }

    }
}