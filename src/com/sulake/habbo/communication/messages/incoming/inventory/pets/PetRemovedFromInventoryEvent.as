package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetRemovedFromInventoryParser;

    public class PetRemovedFromInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetRemovedFromInventoryEvent(param1:Function)
        {
            super(param1, PetRemovedFromInventoryParser);
        }

        public function getParser():PetRemovedFromInventoryParser
        {
            return (var_334 as PetRemovedFromInventoryParser);
        }


    }
}