package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.ViralFurniStatusMessageParser;

    public class ViralFurniStatusEvent extends MessageEvent 
    {

        public function ViralFurniStatusEvent(param1:Function)
        {
            super(param1, ViralFurniStatusMessageParser);
        }

        public function getParser():ViralFurniStatusMessageParser
        {
            return (var_334 as ViralFurniStatusMessageParser);
        }


    }
}