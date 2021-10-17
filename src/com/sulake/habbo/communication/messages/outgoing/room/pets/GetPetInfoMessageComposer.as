package com.sulake.habbo.communication.messages.outgoing.room.pets
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetPetInfoMessageComposer implements IMessageComposer 
    {

        private var var_3606:int;

        public function GetPetInfoMessageComposer(param1:int)
        {
            this.var_3606 = param1;
        }

        public function getMessageArray():Array
        {
            return ([this.var_3606]);
        }

        public function dispose():void
        {
        }


    }
}