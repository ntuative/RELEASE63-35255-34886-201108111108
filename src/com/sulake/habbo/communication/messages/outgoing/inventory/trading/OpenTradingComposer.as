package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class OpenTradingComposer implements IMessageComposer 
    {

        private var var_3598:int;

        public function OpenTradingComposer(param1:int)
        {
            this.var_3598 = param1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3598]);
        }


    }
}