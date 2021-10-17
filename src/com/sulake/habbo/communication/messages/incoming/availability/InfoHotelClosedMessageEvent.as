package com.sulake.habbo.communication.messages.incoming.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosedMessageParser;

    public class InfoHotelClosedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function InfoHotelClosedMessageEvent(param1:Function)
        {
            super(param1, InfoHotelClosedMessageParser);
        }

        public function getParser():InfoHotelClosedMessageParser
        {
            return (var_334 as InfoHotelClosedMessageParser);
        }


    }
}