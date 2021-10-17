package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.ClubGiftNotificationParser;

    public class ClubGiftNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function ClubGiftNotificationEvent(param1:Function)
        {
            super(param1, ClubGiftNotificationParser);
        }

        public function getParser():ClubGiftNotificationParser
        {
            return (var_334 as ClubGiftNotificationParser);
        }


    }
}