package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.OfficialRoomsMessageParser;

    public class OfficialRoomsEvent extends MessageEvent implements IMessageEvent 
    {

        public function OfficialRoomsEvent(param1:Function)
        {
            super(param1, OfficialRoomsMessageParser);
        }

        public function getParser():OfficialRoomsMessageParser
        {
            return (this.var_334 as OfficialRoomsMessageParser);
        }


    }
}