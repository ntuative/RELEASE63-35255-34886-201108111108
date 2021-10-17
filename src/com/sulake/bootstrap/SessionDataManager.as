package com.sulake.bootstrap
{
    import com.sulake.habbo.session.SessionDataManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class SessionDataManager extends com.sulake.habbo.session.SessionDataManager 
    {

        public function SessionDataManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
        }

    }
}