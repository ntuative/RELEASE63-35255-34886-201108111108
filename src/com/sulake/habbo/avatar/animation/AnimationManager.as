package com.sulake.habbo.avatar.animation
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.AvatarStructure;

    public class AnimationManager implements IAnimationManager 
    {

        private var var_2876:Dictionary;

        public function AnimationManager()
        {
            this.var_2876 = new Dictionary();
        }

        public function registerAnimation(param1:AvatarStructure, param2:XML):Boolean
        {
            var _loc3_:String = String(param2.@name);
            this.var_2876[_loc3_] = new Animation(param1, param2);
            return (true);
        }

        public function getAnimation(param1:String):IAnimation
        {
            return (this.var_2876[param1]);
        }

        public function getLayerData(param1:String, param2:int, param3:String):IAnimationLayerData
        {
            var _loc4_:Animation = (this.var_2876[param1] as Animation);
            if (_loc4_ != null)
            {
                return (_loc4_.getLayerData(param2, param3));
            };
            return (null);
        }

        public function get animations():Dictionary
        {
            return (this.var_2876);
        }


    }
}