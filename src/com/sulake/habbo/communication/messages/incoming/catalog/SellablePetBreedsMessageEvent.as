package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.SellablePetBreedsParser;

    public class SellablePetBreedsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function SellablePetBreedsMessageEvent(param1:Function)
        {
            super(param1, SellablePetBreedsParser);
        }

        public function getParser():SellablePetBreedsParser
        {
            return (this.var_334 as SellablePetBreedsParser);
        }


    }
}