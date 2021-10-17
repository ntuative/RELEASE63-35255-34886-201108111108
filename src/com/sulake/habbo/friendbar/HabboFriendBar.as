package com.sulake.habbo.friendbar
{
    import com.sulake.core.runtime.ComponentContext;
    import com.sulake.habbo.friendbar.utils.LinkResolver;
    import com.sulake.habbo.friendbar.data.HabboFriendBarData;
    import com.sulake.iid.IIDHabboFriendBarData;
    import com.sulake.habbo.friendbar.view.HabboFriendBarView;
    import com.sulake.iid.IIDHabboFriendBarView;
    import com.sulake.habbo.friendbar.stream.HabboEventStream;
    import com.sulake.iid.IIDHabboEventStream;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboFriendBar extends ComponentContext 
    {

        public function HabboFriendBar(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            LinkResolver.unknown = this;
            attachComponent(new HabboFriendBarData(this, 0, param3), [new IIDHabboFriendBarData()]);
            attachComponent(new HabboFriendBarView(this, 0, param3), [new IIDHabboFriendBarView()]);
            attachComponent(new HabboEventStream(this, 0, param3), [new IIDHabboEventStream()]);
        }

    }
}