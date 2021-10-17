package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.RoomChatlogMessageParser;

    public class RoomChatlogEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomChatlogEvent(param1:Function)
        {
            super(param1, RoomChatlogMessageParser);
        }

        public function getParser():RoomChatlogMessageParser
        {
            return (var_334 as RoomChatlogMessageParser);
        }


    }
}