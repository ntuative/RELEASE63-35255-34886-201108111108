package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectUpdateMessageParser;

    public class ObjectUpdateMessageEvent extends MessageEvent 
    {

        public function ObjectUpdateMessageEvent(param1:Function)
        {
            super(param1, ObjectUpdateMessageParser);
        }

        public function getParser():ObjectUpdateMessageParser
        {
            return (var_334 as ObjectUpdateMessageParser);
        }


    }
}