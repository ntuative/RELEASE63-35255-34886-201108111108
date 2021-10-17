package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;

    public class HabboAchievementNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboAchievementNotificationMessageEvent(param1:Function)
        {
            super(param1, HabboAchievementNotificationMessageParser);
        }

        public function getParser():HabboAchievementNotificationMessageParser
        {
            return (var_334 as HabboAchievementNotificationMessageParser);
        }


    }
}