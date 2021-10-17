package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboGroupDetailsMessageParser;

    public class HabboGroupDetailsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboGroupDetailsMessageEvent(param1:Function)
        {
            super(param1, HabboGroupDetailsMessageParser);
        }

        public function get data():HabboGroupDetailsData
        {
            return (HabboGroupDetailsMessageParser(var_334).data);
        }


    }
}