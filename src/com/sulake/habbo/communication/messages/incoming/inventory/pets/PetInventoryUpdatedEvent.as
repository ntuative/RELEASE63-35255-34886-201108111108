package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryUpdatedParser;

    public class PetInventoryUpdatedEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetInventoryUpdatedEvent(param1:Function)
        {
            super(param1, PetInventoryUpdatedParser);
        }

    }
}