package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueStatusMessageParser;

    public class RoomQueueStatusMessageEvent extends MessageEvent 
    {

        public function RoomQueueStatusMessageEvent(param1:Function)
        {
            super(param1, RoomQueueStatusMessageParser);
        }

        public function getParser():RoomQueueStatusMessageParser
        {
            return (var_334 as RoomQueueStatusMessageParser);
        }


    }
}