package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.GuestRoomSearchResultMessageParser;

    public class GuestRoomSearchResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuestRoomSearchResultEvent(param1:Function)
        {
            super(param1, GuestRoomSearchResultMessageParser);
        }

        public function getParser():GuestRoomSearchResultMessageParser
        {
            return (this.var_334 as GuestRoomSearchResultMessageParser);
        }


    }
}