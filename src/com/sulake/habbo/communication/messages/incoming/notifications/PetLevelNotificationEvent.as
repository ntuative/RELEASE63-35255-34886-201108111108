package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.PetLevelNotificationParser;

    public class PetLevelNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetLevelNotificationEvent(param1:Function)
        {
            super(param1, PetLevelNotificationParser);
        }

        public function getParser():PetLevelNotificationParser
        {
            return (var_334 as PetLevelNotificationParser);
        }


    }
}