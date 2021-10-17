package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.FloorHeightMapMessageParser;

    public class FloorHeightMapMessageEvent extends MessageEvent 
    {

        public function FloorHeightMapMessageEvent(param1:Function)
        {
            super(param1, FloorHeightMapMessageParser);
        }

        public function getParser():FloorHeightMapMessageParser
        {
            return (var_334 as FloorHeightMapMessageParser);
        }


    }
}