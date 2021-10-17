package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListUpdateParser;

    public class FurniListUpdateEvent extends MessageEvent implements IMessageEvent 
    {

        public function FurniListUpdateEvent(param1:Function)
        {
            super(param1, FurniListUpdateParser);
        }

        public function getParser():FurniListUpdateParser
        {
            return (this.var_334 as FurniListUpdateParser);
        }


    }
}