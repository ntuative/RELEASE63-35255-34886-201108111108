package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetReceivedMessageParser implements IMessageParser 
    {

        private var var_3717:Boolean;
        private var var_3715:PetData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3717 = param1.readBoolean();
            this.var_3715 = new PetData(param1);
            Logger.log(((((((((((("Got PetReceived: " + this.var_3717) + ", ") + this.var_3715.id) + ", ") + this.var_3715.name) + ", ") + this.var_3715.type) + ", ") + this.var_3715.breed) + ", ") + this.pet.color));
            return (true);
        }

        public function get boughtAsGift():Boolean
        {
            return (this.var_3717);
        }

        public function get pet():PetData
        {
            return (this.var_3715);
        }


    }
}