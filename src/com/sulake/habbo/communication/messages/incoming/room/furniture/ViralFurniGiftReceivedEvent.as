package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.ViralFurniGiftReceivedMessageParser;

    public class ViralFurniGiftReceivedEvent extends MessageEvent 
    {

        public function ViralFurniGiftReceivedEvent(param1:Function)
        {
            super(param1, ViralFurniGiftReceivedMessageParser);
        }

        public function getParser():ViralFurniGiftReceivedMessageParser
        {
            return (var_334 as ViralFurniGiftReceivedMessageParser);
        }


    }
}