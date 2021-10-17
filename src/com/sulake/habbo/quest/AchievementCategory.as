package com.sulake.habbo.quest
{
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;

    public class AchievementCategory 
    {

        private var var_4404:String;
        private var _achievements:Array = new Array();

        public function AchievementCategory(param1:String)
        {
            this.var_4404 = param1;
        }

        public function add(param1:AchievementData):void
        {
            this._achievements.push(param1);
        }

        public function update(param1:AchievementData):void
        {
            var _loc3_:AchievementData;
            var _loc2_:int;
            while (_loc2_ < this._achievements.length)
            {
                _loc3_ = this._achievements[_loc2_];
                if (_loc3_.type == param1.type)
                {
                    this._achievements[_loc2_] = param1;
                };
                _loc2_++;
            };
        }

        public function getProgress():int
        {
            var _loc2_:AchievementData;
            var _loc1_:int;
            for each (_loc2_ in this._achievements)
            {
                _loc1_ = (_loc1_ + ((_loc2_.finalLevel) ? _loc2_.level : (_loc2_.level - 1)));
            };
            return (_loc1_);
        }

        public function getMaxProgress():int
        {
            var _loc2_:AchievementData;
            var _loc1_:int;
            for each (_loc2_ in this._achievements)
            {
                _loc1_ = (_loc1_ + _loc2_.levelCount);
            };
            return (_loc1_);
        }

        public function get code():String
        {
            return (this.var_4404);
        }

        public function get achievements():Array
        {
            return (this._achievements);
        }


    }
}