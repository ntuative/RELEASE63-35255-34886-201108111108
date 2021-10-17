package com.sulake.habbo.groups
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboGroupsManager extends Component implements IHabboGroupsManager 
    {

        public function HabboGroupsManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            Logger.log(("HabboGroupsManager initialized: " + param3));
        }

        override public function dispose():void
        {
            super.dispose();
        }


    }
}