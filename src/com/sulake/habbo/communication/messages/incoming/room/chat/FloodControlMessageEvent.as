package com.sulake.habbo.communication.messages.incoming.room.chat
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.FloodControlMessageParser;

    public class FloodControlMessageEvent extends MessageEvent 
    {

        public function FloodControlMessageEvent(param1:Function)
        {
            super(param1, FloodControlMessageParser);
        }

        public function getParser():FloodControlMessageParser
        {
            return (var_334 as FloodControlMessageParser);
        }


    }
}