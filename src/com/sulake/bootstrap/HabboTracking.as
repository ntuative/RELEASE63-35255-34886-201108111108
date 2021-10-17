package com.sulake.bootstrap
{
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboTracking extends com.sulake.habbo.tracking.HabboTracking 
    {

        public function HabboTracking(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
        }

    }
}