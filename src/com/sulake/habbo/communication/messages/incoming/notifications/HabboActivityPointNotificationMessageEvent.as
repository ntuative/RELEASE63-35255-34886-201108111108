package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboActivityPointNotificationMessageParser;

    public class HabboActivityPointNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboActivityPointNotificationMessageEvent(param1:Function)
        {
            super(param1, HabboActivityPointNotificationMessageParser);
        }

        public function get amount():int
        {
            return ((var_334 as HabboActivityPointNotificationMessageParser).amount);
        }

        public function get change():int
        {
            return ((var_334 as HabboActivityPointNotificationMessageParser).change);
        }

        public function get type():int
        {
            return ((var_334 as HabboActivityPointNotificationMessageParser).type);
        }


    }
}