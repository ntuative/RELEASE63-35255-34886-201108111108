package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;

    public class GetGuestRoomResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function GetGuestRoomResultEvent(param1:Function)
        {
            super(param1, GetGuestRoomResultMessageParser);
        }

        public function getParser():GetGuestRoomResultMessageParser
        {
            return (this.var_334 as GetGuestRoomResultMessageParser);
        }


    }
}