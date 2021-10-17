package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementMessageParser;

    public class AchievementEvent extends MessageEvent implements IMessageEvent 
    {

        public function AchievementEvent(param1:Function)
        {
            super(param1, AchievementMessageParser);
        }

        public function getParser():AchievementMessageParser
        {
            return (var_334 as AchievementMessageParser);
        }


    }
}