package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapMessageParser;

    public class HeightMapMessageEvent extends MessageEvent 
    {

        public function HeightMapMessageEvent(param1:Function)
        {
            super(param1, HeightMapMessageParser);
        }

        public function getParser():HeightMapMessageParser
        {
            return (var_334 as HeightMapMessageParser);
        }


    }
}