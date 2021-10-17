package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementsMessageParser implements IMessageParser 
    {

        private var _achievements:Array;
        private var var_3704:String;


        public function flush():Boolean
        {
            this._achievements = new Array();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._achievements = new Array();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this._achievements.push(new AchievementData(param1));
                _loc3_++;
            };
            this.var_3704 = param1.readString();
            return (true);
        }

        public function get achievements():Array
        {
            return (this._achievements);
        }

        public function get defaultCategory():String
        {
            return (this.var_3704);
        }


    }
}