package com.sulake.bootstrap
{
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboInventory extends com.sulake.habbo.inventory.HabboInventory 
    {

        public function HabboInventory(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
        }

    }
}