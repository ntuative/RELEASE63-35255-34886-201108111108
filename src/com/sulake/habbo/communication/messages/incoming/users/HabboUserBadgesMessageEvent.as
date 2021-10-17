package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboUserBadgesMessageParser;

    public class HabboUserBadgesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboUserBadgesMessageEvent(param1:Function)
        {
            super(param1, HabboUserBadgesMessageParser);
        }

        public function get badges():Array
        {
            return ((var_334 as HabboUserBadgesMessageParser).badges);
        }

        public function get userId():int
        {
            return ((var_334 as HabboUserBadgesMessageParser).userId);
        }


    }
}