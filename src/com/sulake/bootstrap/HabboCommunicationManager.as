package com.sulake.bootstrap
{
    import com.sulake.habbo.communication.HabboCommunicationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboCommunicationManager extends com.sulake.habbo.communication.HabboCommunicationManager 
    {

        public function HabboCommunicationManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
        }

    }
}