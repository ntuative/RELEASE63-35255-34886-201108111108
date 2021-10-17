package com.sulake.habbo.communication.messages.incoming.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageParser;

    public class DanceMessageEvent extends MessageEvent 
    {

        public function DanceMessageEvent(param1:Function)
        {
            super(param1, DanceMessageParser);
        }

        public function getParser():DanceMessageParser
        {
            return (var_334 as DanceMessageParser);
        }


    }
}