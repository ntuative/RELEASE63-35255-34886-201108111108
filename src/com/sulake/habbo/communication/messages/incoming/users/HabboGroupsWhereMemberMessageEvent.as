package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboGroupsWhereMemberMessageParser;

    public class HabboGroupsWhereMemberMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboGroupsWhereMemberMessageEvent(param1:Function)
        {
            super(param1, HabboGroupsWhereMemberMessageParser);
        }

        public function get groups():Array
        {
            return (HabboGroupsWhereMemberMessageParser(var_334).groups);
        }


    }
}