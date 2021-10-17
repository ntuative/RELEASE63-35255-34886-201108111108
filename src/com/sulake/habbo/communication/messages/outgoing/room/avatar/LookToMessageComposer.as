package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class LookToMessageComposer implements IMessageComposer 
    {

        private var var_3601:int;
        private var var_3602:int;

        public function LookToMessageComposer(param1:int, param2:int)
        {
            this.var_3601 = param1;
            this.var_3602 = param2;
        }

        public function getMessageArray():Array
        {
            return ([this.var_3601, this.var_3602]);
        }

        public function dispose():void
        {
        }


    }
}