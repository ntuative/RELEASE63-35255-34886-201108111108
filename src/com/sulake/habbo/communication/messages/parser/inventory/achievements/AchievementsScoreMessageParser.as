package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementsScoreMessageParser implements IMessageParser 
    {

        private var var_3478:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3478 = param1.readInteger();
            return (true);
        }

        public function get score():int
        {
            return (this.var_3478);
        }


    }
}