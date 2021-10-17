package com.sulake.habbo.communication.messages.incoming.room.publicroom
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.publicroom.ParkBusCannotEnterMessageParser;

    public class ParkBusCannotEnterMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ParkBusCannotEnterMessageEvent(param1:Function)
        {
            super(param1, ParkBusCannotEnterMessageParser);
        }

        public function getParser():ParkBusCannotEnterMessageParser
        {
            return (var_334 as ParkBusCannotEnterMessageParser);
        }


    }
}