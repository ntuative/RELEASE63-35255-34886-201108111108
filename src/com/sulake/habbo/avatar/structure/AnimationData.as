package com.sulake.habbo.avatar.structure
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.structure.animation.AnimationAction;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import com.sulake.habbo.avatar.structure.animation.*;

    public class AnimationData implements IStructureData 
    {

        private var var_2856:Dictionary;

        public function AnimationData()
        {
            this.var_2856 = new Dictionary();
        }

        public function parse(param1:XML):Boolean
        {
            var _loc2_:XML;
            if (param1 == null)
            {
                return (false);
            };
            for each (_loc2_ in param1.action)
            {
                this.var_2856[String(_loc2_.@id)] = new AnimationAction(_loc2_);
            };
            return (true);
        }

        public function appendXML(param1:XML):Boolean
        {
            var _loc2_:XML;
            if (param1 == null)
            {
                return (false);
            };
            for each (_loc2_ in param1.action)
            {
                this.var_2856[String(_loc2_.@id)] = new AnimationAction(_loc2_);
            };
            return (true);
        }

        public function getAction(param1:IActionDefinition):AnimationAction
        {
            return (this.var_2856[param1.assetPartDefinition]);
        }


    }
}