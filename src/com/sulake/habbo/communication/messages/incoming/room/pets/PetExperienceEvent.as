package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetExperienceParser;

    public class PetExperienceEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetExperienceEvent(param1:Function)
        {
            super(param1, PetExperienceParser);
        }

        public function getParser():PetExperienceParser
        {
            return (var_334 as PetExperienceParser);
        }


    }
}