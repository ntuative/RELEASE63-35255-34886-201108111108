package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetAddedToInventoryParser implements IMessageParser 
    {

        private var var_3715:PetData;
        private var var_3716:Boolean;


        public function flush():Boolean
        {
            this.var_3715 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3715 = new PetData(param1);
            this.var_3716 = param1.readBoolean();
            return (true);
        }

        public function get pet():PetData
        {
            return (this.var_3715);
        }

        public function get purchased():Boolean
        {
            return (this.var_3716);
        }


    }
}