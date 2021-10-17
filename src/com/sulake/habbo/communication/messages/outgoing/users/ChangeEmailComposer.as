package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ChangeEmailComposer implements IMessageComposer 
    {

        private var var_3634:String;

        public function ChangeEmailComposer(param1:String)
        {
            this.var_3634 = param1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3634]);
        }


    }
}