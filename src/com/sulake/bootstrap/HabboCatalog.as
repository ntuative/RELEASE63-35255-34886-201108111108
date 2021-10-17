package com.sulake.bootstrap
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboCatalog extends com.sulake.habbo.catalog.HabboCatalog 
    {

        public function HabboCatalog(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
        }

    }
}