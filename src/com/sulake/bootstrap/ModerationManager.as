﻿package com.sulake.bootstrap
{
    import com.sulake.habbo.moderation.ModerationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class ModerationManager extends com.sulake.habbo.moderation.ModerationManager 
    {

        public function ModerationManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
        }

    }
}