package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsMessageParser;

    public class ObjectsMessageEvent extends MessageEvent 
    {

        public function ObjectsMessageEvent(param1:Function)
        {
            super(param1, ObjectsMessageParser);
        }

        public function getParser():ObjectsMessageParser
        {
            return (var_334 as ObjectsMessageParser);
        }


    }
}