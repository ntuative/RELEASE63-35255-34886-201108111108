package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapUpdateMessageParser;

    public class HeightMapUpdateMessageEvent extends MessageEvent 
    {

        public function HeightMapUpdateMessageEvent(param1:Function)
        {
            super(param1, HeightMapUpdateMessageParser);
        }

        public function getParser():HeightMapUpdateMessageParser
        {
            return (var_334 as HeightMapUpdateMessageParser);
        }


    }
}