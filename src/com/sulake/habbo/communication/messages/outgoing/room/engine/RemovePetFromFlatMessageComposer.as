package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RemovePetFromFlatMessageComposer implements IMessageComposer 
    {

        private var var_3606:int;

        public function RemovePetFromFlatMessageComposer(param1:int)
        {
            this.var_3606 = param1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3606]);
        }


    }
}