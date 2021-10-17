package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SetEventStreamingAllowedComposer implements IMessageComposer 
    {

        private var var_1198:Boolean;

        public function SetEventStreamingAllowedComposer(param1:Boolean)
        {
            this.var_1198 = param1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_1198]);
        }


    }
}