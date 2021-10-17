package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageParser;

    public class ObjectRemoveMessageEvent extends MessageEvent 
    {

        public function ObjectRemoveMessageEvent(param1:Function)
        {
            super(param1, ObjectRemoveMessageParser);
        }

        public function getParser():ObjectRemoveMessageParser
        {
            return (var_334 as ObjectRemoveMessageParser);
        }


    }
}