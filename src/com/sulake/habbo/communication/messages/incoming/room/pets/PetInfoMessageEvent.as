package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetInfoMessageParser;

    public class PetInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetInfoMessageEvent(param1:Function)
        {
            super(param1, PetInfoMessageParser);
        }

        public function getParser():PetInfoMessageParser
        {
            return (var_334 as PetInfoMessageParser);
        }


    }
}