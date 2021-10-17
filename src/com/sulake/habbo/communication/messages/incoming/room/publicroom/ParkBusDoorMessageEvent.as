package com.sulake.habbo.communication.messages.incoming.room.publicroom
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.publicroom.ParkBusDoorMessageParser;

    public class ParkBusDoorMessageEvent extends MessageEvent 
    {

        public function ParkBusDoorMessageEvent(param1:Function)
        {
            super(param1, ParkBusDoorMessageParser);
        }

        public function getParser():ParkBusDoorMessageParser
        {
            return (var_334 as ParkBusDoorMessageParser);
        }


    }
}