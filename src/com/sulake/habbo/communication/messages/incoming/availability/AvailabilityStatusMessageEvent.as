package com.sulake.habbo.communication.messages.incoming.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.AvailabilityStatusMessageParser;

    public class AvailabilityStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function AvailabilityStatusMessageEvent(param1:Function)
        {
            super(param1, AvailabilityStatusMessageParser);
        }

        public function getParser():AvailabilityStatusMessageParser
        {
            return (var_334 as AvailabilityStatusMessageParser);
        }


    }
}