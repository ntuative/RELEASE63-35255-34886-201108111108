package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.RoomVisitsMessageParser;

    public class RoomVisitsEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomVisitsEvent(param1:Function)
        {
            super(param1, RoomVisitsMessageParser);
        }

        public function getParser():RoomVisitsMessageParser
        {
            return (var_334 as RoomVisitsMessageParser);
        }


    }
}