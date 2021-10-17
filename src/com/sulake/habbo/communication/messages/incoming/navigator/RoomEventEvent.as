package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomEventMessageParser;

    public class RoomEventEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomEventEvent(param1:Function)
        {
            super(param1, RoomEventMessageParser);
        }

        public function getParser():RoomEventMessageParser
        {
            return (this.var_334 as RoomEventMessageParser);
        }


    }
}