package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsDataUpdateMessageParser;

    public class ObjectsDataUpdateMessageEvent extends MessageEvent 
    {

        public function ObjectsDataUpdateMessageEvent(param1:Function)
        {
            super(param1, ObjectsDataUpdateMessageParser);
        }

        public function getParser():ObjectsDataUpdateMessageParser
        {
            return (var_334 as ObjectsDataUpdateMessageParser);
        }


    }
}