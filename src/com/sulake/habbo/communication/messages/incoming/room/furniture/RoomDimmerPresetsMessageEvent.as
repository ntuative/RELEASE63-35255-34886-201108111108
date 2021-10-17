package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RoomDimmerPresetsMessageParser;

    public class RoomDimmerPresetsMessageEvent extends MessageEvent 
    {

        public function RoomDimmerPresetsMessageEvent(param1:Function)
        {
            super(param1, RoomDimmerPresetsMessageParser);
        }

        public function getParser():RoomDimmerPresetsMessageParser
        {
            return (var_334 as RoomDimmerPresetsMessageParser);
        }


    }
}