package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.FurnitureAliasesMessageParser;

    public class FurnitureAliasesMessageEvent extends MessageEvent 
    {

        public function FurnitureAliasesMessageEvent(param1:Function)
        {
            super(param1, FurnitureAliasesMessageParser);
        }

        public function getParser():FurnitureAliasesMessageParser
        {
            return (var_334 as FurnitureAliasesMessageParser);
        }


    }
}