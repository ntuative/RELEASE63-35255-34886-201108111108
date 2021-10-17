package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class KickBotMessageComposer implements IMessageComposer 
    {

        private var var_3600:int;

        public function KickBotMessageComposer(param1:int)
        {
            this.var_3600 = param1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3600]);
        }


    }
}