package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SellablePetBreedData 
    {

        private var _type:int;
        private var var_2978:int;
        private var var_3648:Boolean;
        private var var_3649:Boolean;

        public function SellablePetBreedData(param1:IMessageDataWrapper)
        {
            this._type = param1.readInteger();
            this.var_2978 = param1.readInteger();
            this.var_3648 = param1.readBoolean();
            this.var_3649 = param1.readBoolean();
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get breed():int
        {
            return (this.var_2978);
        }

        public function get sellable():Boolean
        {
            return (this.var_3648);
        }

        public function get rare():Boolean
        {
            return (this.var_3649);
        }


    }
}