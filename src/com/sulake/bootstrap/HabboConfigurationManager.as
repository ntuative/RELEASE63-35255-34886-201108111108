package com.sulake.bootstrap
{
    import com.sulake.habbo.configuration.HabboConfigurationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboConfigurationManager extends com.sulake.habbo.configuration.HabboConfigurationManager 
    {

        public function HabboConfigurationManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
        }

    }
}