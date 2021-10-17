package com.sulake.habbo.communication.messages.incoming.recycler
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PrizeMessageData 
    {

        private var var_3176:String;
        private var var_3177:int;

        public function PrizeMessageData(param1:IMessageDataWrapper)
        {
            this.var_3176 = param1.readString();
            this.var_3177 = param1.readInteger();
        }

        public function get productItemType():String
        {
            return (this.var_3176);
        }

        public function get productItemTypeId():int
        {
            return (this.var_3177);
        }


    }
}