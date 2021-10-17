package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectAddMessageParser;

    public class ObjectAddMessageEvent extends MessageEvent 
    {

        public function ObjectAddMessageEvent(param1:Function)
        {
            super(param1, ObjectAddMessageParser);
        }

        public function getParser():ObjectAddMessageParser
        {
            return (var_334 as ObjectAddMessageParser);
        }


    }
}