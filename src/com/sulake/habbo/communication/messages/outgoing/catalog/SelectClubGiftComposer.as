package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SelectClubGiftComposer implements IMessageComposer 
    {

        private var var_3083:String;

        public function SelectClubGiftComposer(param1:String)
        {
            this.var_3083 = param1;
        }

        public function getMessageArray():Array
        {
            return ([this.var_3083]);
        }

        public function dispose():void
        {
            this.var_3083 = null;
        }


    }
}