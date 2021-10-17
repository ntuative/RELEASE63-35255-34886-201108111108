package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.MOTDNotificationParser;

    public class MOTDNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function MOTDNotificationEvent(param1:Function)
        {
            super(param1, MOTDNotificationParser);
        }

        public function getParser():MOTDNotificationParser
        {
            return (var_334 as MOTDNotificationParser);
        }


    }
}