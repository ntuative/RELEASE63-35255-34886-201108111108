package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class UniqueIDMessageComposer implements IMessageComposer 
    {

        private var var_3592:String;

        public function UniqueIDMessageComposer(param1:String)
        {
            this.var_3592 = param1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3592]);
        }


    }
}