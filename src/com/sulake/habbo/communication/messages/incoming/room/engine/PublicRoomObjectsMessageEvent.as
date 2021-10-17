package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.PublicRoomObjectsMessageParser;

    public class PublicRoomObjectsMessageEvent extends MessageEvent 
    {

        public function PublicRoomObjectsMessageEvent(param1:Function)
        {
            super(param1, PublicRoomObjectsMessageParser);
        }

        public function getParser():PublicRoomObjectsMessageParser
        {
            return (var_334 as PublicRoomObjectsMessageParser);
        }


    }
}