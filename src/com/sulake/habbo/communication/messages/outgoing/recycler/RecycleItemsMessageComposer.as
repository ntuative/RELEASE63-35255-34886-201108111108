package com.sulake.habbo.communication.messages.outgoing.recycler
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RecycleItemsMessageComposer implements IMessageComposer 
    {

        private var var_3599:Array;

        public function RecycleItemsMessageComposer(param1:Array)
        {
            this.var_3599 = new Array();
            this.var_3599.push(param1.length);
            this.var_3599 = this.var_3599.concat(param1);
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return (this.var_3599);
        }


    }
}