package com.sulake.habbo.quest
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;

    public class AchievementCategories 
    {

        private var var_4001:Dictionary = new Dictionary();
        private var var_4403:Array = new Array();

        public function AchievementCategories(param1:Array)
        {
            var _loc2_:AchievementData;
            var _loc3_:AchievementCategory;
            super();
            for each (_loc2_ in param1)
            {
                _loc3_ = this.var_4001[_loc2_.category];
                if (_loc3_ == null)
                {
                    _loc3_ = new AchievementCategory(_loc2_.category);
                    this.var_4001[_loc2_.category] = _loc3_;
                    this.var_4403.push(_loc3_);
                };
                _loc3_.add(_loc2_);
            };
        }

        public function update(param1:AchievementData):void
        {
            var _loc2_:AchievementCategory = this.var_4001[param1.category];
            _loc2_.update(param1);
        }

        public function get categoryList():Array
        {
            return (this.var_4403);
        }

        public function getMaxProgress():int
        {
            var _loc2_:AchievementCategory;
            var _loc1_:int;
            for each (_loc2_ in this.var_4403)
            {
                _loc1_ = (_loc1_ + _loc2_.getMaxProgress());
            };
            return (_loc1_);
        }

        public function getProgress():int
        {
            var _loc2_:AchievementCategory;
            var _loc1_:int;
            for each (_loc2_ in this.var_4403)
            {
                _loc1_ = (_loc1_ + _loc2_.getProgress());
            };
            return (_loc1_);
        }

        public function getCategoryByCode(param1:String):AchievementCategory
        {
            var _loc2_:AchievementCategory;
            for each (_loc2_ in this.var_4403)
            {
                if (_loc2_.code == param1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }


    }
}