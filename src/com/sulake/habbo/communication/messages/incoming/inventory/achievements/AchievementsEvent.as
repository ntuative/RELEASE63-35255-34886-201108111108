package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsMessageParser;

    public class AchievementsEvent extends MessageEvent implements IMessageEvent 
    {

        public function AchievementsEvent(param1:Function)
        {
            super(param1, AchievementsMessageParser);
        }

        public function getParser():AchievementsMessageParser
        {
            return (var_334 as AchievementsMessageParser);
        }


    }
}