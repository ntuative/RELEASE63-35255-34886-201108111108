package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementBonusMessageParser;

    public class HabboAchievementBonusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboAchievementBonusMessageEvent(param1:Function)
        {
            super(param1, HabboAchievementBonusMessageParser);
        }

        public function get bonusPoints():int
        {
            return ((var_334 as HabboAchievementBonusMessageParser).bonusPoints);
        }

        public function get realName():String
        {
            return ((var_334 as HabboAchievementBonusMessageParser).realName);
        }


    }
}