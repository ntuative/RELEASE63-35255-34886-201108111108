package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListInsertParser;

    public class FurniListInsertEvent extends MessageEvent implements IMessageEvent 
    {

        public function FurniListInsertEvent(param1:Function)
        {
            super(param1, FurniListInsertParser);
        }

        public function getParser():FurniListInsertParser
        {
            return (this.var_334 as FurniListInsertParser);
        }


    }
}