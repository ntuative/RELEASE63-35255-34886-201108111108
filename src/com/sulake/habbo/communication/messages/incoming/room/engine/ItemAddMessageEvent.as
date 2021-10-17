package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemAddMessageParser;

    public class ItemAddMessageEvent extends MessageEvent 
    {

        public function ItemAddMessageEvent(param1:Function)
        {
            super(param1, ItemAddMessageParser);
        }

        public function getParser():ItemAddMessageParser
        {
            return (var_334 as ItemAddMessageParser);
        }


    }
}