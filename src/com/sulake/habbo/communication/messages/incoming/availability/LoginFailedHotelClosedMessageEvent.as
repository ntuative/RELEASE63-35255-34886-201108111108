package com.sulake.habbo.communication.messages.incoming.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageParser;

    public class LoginFailedHotelClosedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function LoginFailedHotelClosedMessageEvent(param1:Function)
        {
            super(param1, LoginFailedHotelClosedMessageParser);
        }

        public function getParser():LoginFailedHotelClosedMessageParser
        {
            return (var_334 as LoginFailedHotelClosedMessageParser);
        }


    }
}