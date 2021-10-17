package com.sulake.habbo.communication.messages.incoming.avatar
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OutfitData 
    {

        private var var_2998:int;
        private var var_3066:String;
        private var var_2938:String;

        public function OutfitData(param1:IMessageDataWrapper)
        {
            this.var_2998 = param1.readInteger();
            this.var_3066 = param1.readString();
            this.var_2938 = param1.readString();
        }

        public function get slotId():int
        {
            return (this.var_2998);
        }

        public function get figureString():String
        {
            return (this.var_3066);
        }

        public function get gender():String
        {
            return (this.var_2938);
        }


    }
}