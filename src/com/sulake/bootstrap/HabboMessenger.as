package com.sulake.bootstrap
{
    import com.sulake.habbo.messenger.HabboMessenger;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboMessenger extends com.sulake.habbo.messenger.HabboMessenger 
    {

        public function HabboMessenger(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
        }

    }
}