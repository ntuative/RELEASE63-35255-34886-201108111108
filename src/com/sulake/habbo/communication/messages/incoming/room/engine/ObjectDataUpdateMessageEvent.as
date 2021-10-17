package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectDataUpdateMessageParser;

    public class ObjectDataUpdateMessageEvent extends MessageEvent 
    {

        public function ObjectDataUpdateMessageEvent(param1:Function)
        {
            super(param1, ObjectDataUpdateMessageParser);
        }

        public function getParser():ObjectDataUpdateMessageParser
        {
            return (var_334 as ObjectDataUpdateMessageParser);
        }


    }
}