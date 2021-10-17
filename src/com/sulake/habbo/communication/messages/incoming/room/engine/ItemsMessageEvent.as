package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemsMessageParser;

    public class ItemsMessageEvent extends MessageEvent 
    {

        public function ItemsMessageEvent(param1:Function)
        {
            super(param1, ItemsMessageParser);
        }

        public function getParser():ItemsMessageParser
        {
            return (var_334 as ItemsMessageParser);
        }


    }
}