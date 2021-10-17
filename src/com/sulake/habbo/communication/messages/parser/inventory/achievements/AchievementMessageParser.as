package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementMessageParser implements IMessageParser 
    {

        private var var_3703:AchievementData;


        public function flush():Boolean
        {
            this.var_3703 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3703 = new AchievementData(param1);
            return (true);
        }

        public function get achievement():AchievementData
        {
            return (this.var_3703);
        }


    }
}