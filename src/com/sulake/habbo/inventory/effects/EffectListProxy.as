package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.inventory.common.IThumbListDataProvider;

    public class EffectListProxy implements IThumbListDataProvider 
    {

        private var var_2533:EffectsModel;
        private var var_4066:int;

        public function EffectListProxy(param1:EffectsModel, param2:int)
        {
            this.var_2533 = param1;
            this.var_4066 = param2;
        }

        public function dispose():void
        {
            this.var_2533 = null;
        }

        public function getDrawableList():Array
        {
            return (this.var_2533.getEffects(this.var_4066));
        }


    }
}