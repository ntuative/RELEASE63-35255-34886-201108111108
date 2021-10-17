package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomForwardMessageParser;

    public class RoomForwardMessageEvent extends MessageEvent 
    {

        public function RoomForwardMessageEvent(param1:Function)
        {
            super(param1, RoomForwardMessageParser);
        }

        public function getParser():RoomForwardMessageParser
        {
            return (var_334 as RoomForwardMessageParser);
        }


    }
}