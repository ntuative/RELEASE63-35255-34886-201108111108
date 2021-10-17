package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class OpenPetPackageMessageComposer implements IMessageComposer 
    {

        private var var_1678:int;
        private var var_3609:String;

        public function OpenPetPackageMessageComposer(param1:int, param2:String)
        {
            this.var_1678 = param1;
            this.var_3609 = param2;
        }

        public function getMessageArray():Array
        {
            return ([this.var_1678, this.var_3609]);
        }

        public function dispose():void
        {
        }


    }
}