package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SignMessageComposer implements IMessageComposer 
    {

        private var var_3603:int;

        public function SignMessageComposer(param1:int)
        {
            this.var_3603 = param1;
        }

        public function getMessageArray():Array
        {
            return ([this.var_3603]);
        }

        public function dispose():void
        {
        }


    }
}