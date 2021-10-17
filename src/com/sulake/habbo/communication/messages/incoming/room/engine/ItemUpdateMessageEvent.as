package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemUpdateMessageParser;

    public class ItemUpdateMessageEvent extends MessageEvent 
    {

        public function ItemUpdateMessageEvent(param1:Function)
        {
            super(param1, ItemUpdateMessageParser);
        }

        public function getParser():ItemUpdateMessageParser
        {
            return (var_334 as ItemUpdateMessageParser);
        }


    }
}