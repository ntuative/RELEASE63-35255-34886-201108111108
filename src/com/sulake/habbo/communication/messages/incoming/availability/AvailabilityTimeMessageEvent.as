package com.sulake.habbo.communication.messages.incoming.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.AvailabilityTimeMessageParser;

    public class AvailabilityTimeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function AvailabilityTimeMessageEvent(param1:Function)
        {
            super(param1, AvailabilityTimeMessageParser);
        }

        public function getParser():AvailabilityTimeMessageParser
        {
            return (var_334 as AvailabilityTimeMessageParser);
        }


    }
}