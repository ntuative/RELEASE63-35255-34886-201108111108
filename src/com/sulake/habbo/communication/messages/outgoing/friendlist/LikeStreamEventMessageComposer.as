package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class LikeStreamEventMessageComposer implements IMessageComposer 
    {

        private var var_3586:int;
        private var var_3408:int;

        public function LikeStreamEventMessageComposer(param1:int, param2:int)
        {
            this.var_3586 = param1;
            this.var_3408 = param2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3586, this.var_3408]);
        }


    }
}