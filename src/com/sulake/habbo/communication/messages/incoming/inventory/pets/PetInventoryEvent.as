package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryMessageParser;

    public class PetInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetInventoryEvent(param1:Function)
        {
            super(param1, PetInventoryMessageParser);
        }

        public function getParser():PetInventoryMessageParser
        {
            return (var_334 as PetInventoryMessageParser);
        }


    }
}