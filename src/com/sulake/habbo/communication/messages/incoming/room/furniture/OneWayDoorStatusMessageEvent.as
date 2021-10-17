package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OneWayDoorStatusMessageParser;

    public class OneWayDoorStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function OneWayDoorStatusMessageEvent(param1:Function)
        {
            super(param1, OneWayDoorStatusMessageParser);
        }

        public function getParser():OneWayDoorStatusMessageParser
        {
            return (var_334 as OneWayDoorStatusMessageParser);
        }


    }
}