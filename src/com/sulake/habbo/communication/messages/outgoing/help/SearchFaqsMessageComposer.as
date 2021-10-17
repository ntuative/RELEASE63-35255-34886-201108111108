package com.sulake.habbo.communication.messages.outgoing.help
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SearchFaqsMessageComposer implements IMessageComposer 
    {

        private var var_3126:String;

        public function SearchFaqsMessageComposer(param1:String)
        {
            this.var_3126 = param1;
        }

        public function getMessageArray():Array
        {
            return ([this.var_3126]);
        }

        public function dispose():void
        {
        }


    }
}