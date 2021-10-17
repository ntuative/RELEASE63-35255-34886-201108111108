package com.sulake.habbo.communication.messages.incoming.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.SleepMessageParser;

    public class SleepMessageEvent extends MessageEvent 
    {

        public function SleepMessageEvent(param1:Function)
        {
            super(param1, SleepMessageParser);
        }

        public function getParser():SleepMessageParser
        {
            return (var_334 as SleepMessageParser);
        }


    }
}