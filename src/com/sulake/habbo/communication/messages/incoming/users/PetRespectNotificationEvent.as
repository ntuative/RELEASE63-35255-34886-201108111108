package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.PetRespectNotificationParser;

    public class PetRespectNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetRespectNotificationEvent(param1:Function)
        {
            super(param1, PetRespectNotificationParser);
        }

        public function getParser():PetRespectNotificationParser
        {
            return (var_334 as PetRespectNotificationParser);
        }


    }
}