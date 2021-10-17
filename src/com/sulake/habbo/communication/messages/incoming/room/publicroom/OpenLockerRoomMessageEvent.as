package com.sulake.habbo.communication.messages.incoming.room.publicroom
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.publicroom.OpenLockerRoomMessageParser;

    public class OpenLockerRoomMessageEvent extends MessageEvent 
    {

        public function OpenLockerRoomMessageEvent(param1:Function)
        {
            super(param1, OpenLockerRoomMessageParser);
        }

        public function getParser():OpenLockerRoomMessageParser
        {
            return (var_334 as OpenLockerRoomMessageParser);
        }


    }
}