package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;

    public class RoomReadyMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomReadyMessageEvent(param1:Function)
        {
            super(param1, RoomReadyMessageParser);
        }

        public function getParser():RoomReadyMessageParser
        {
            return (var_334 as RoomReadyMessageParser);
        }


    }
}