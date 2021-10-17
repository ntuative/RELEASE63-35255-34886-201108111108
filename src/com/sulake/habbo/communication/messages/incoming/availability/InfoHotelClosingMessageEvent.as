package com.sulake.habbo.communication.messages.incoming.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosingMessageParser;

    public class InfoHotelClosingMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function InfoHotelClosingMessageEvent(param1:Function)
        {
            super(param1, InfoHotelClosingMessageParser);
        }

        public function getParser():InfoHotelClosingMessageParser
        {
            return (var_334 as InfoHotelClosingMessageParser);
        }


    }
}