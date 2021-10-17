package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventMessageParser;

    public class CanCreateRoomEventEvent extends MessageEvent implements IMessageEvent 
    {

        public function CanCreateRoomEventEvent(param1:Function)
        {
            super(param1, CanCreateRoomEventMessageParser);
        }

        public function getParser():CanCreateRoomEventMessageParser
        {
            return (this.var_334 as CanCreateRoomEventMessageParser);
        }


    }
}