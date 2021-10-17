package com.sulake.habbo.communication.messages.outgoing.help
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetFaqCategoryMessageComposer implements IMessageComposer 
    {

        private var var_2930:int;

        public function GetFaqCategoryMessageComposer(param1:int)
        {
            this.var_2930 = param1;
        }

        public function getMessageArray():Array
        {
            return ([this.var_2930]);
        }

        public function dispose():void
        {
        }


    }
}