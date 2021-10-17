package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetAddedToInventoryParser;

    public class PetAddedToInventoryEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetAddedToInventoryEvent(param1:Function)
        {
            super(param1, PetAddedToInventoryParser);
        }

        public function getParser():PetAddedToInventoryParser
        {
            return (var_334 as PetAddedToInventoryParser);
        }


    }
}