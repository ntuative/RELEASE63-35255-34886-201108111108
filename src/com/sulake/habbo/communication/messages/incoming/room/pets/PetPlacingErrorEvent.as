package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetPlacingErrorParser;

    public class PetPlacingErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetPlacingErrorEvent(param1:Function)
        {
            super(param1, PetPlacingErrorParser);
        }

        public function getParser():PetPlacingErrorParser
        {
            return (var_334 as PetPlacingErrorParser);
        }


    }
}