package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SellablePetBreedsParser implements IMessageParser 
    {

        private var var_3083:String = "";
        private var var_2971:Array = [];


        public function get productCode():String
        {
            return (this.var_3083);
        }

        public function get sellableBreeds():Array
        {
            return (this.var_2971.slice());
        }

        public function flush():Boolean
        {
            this.var_3083 = "";
            this.var_2971 = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3083 = param1.readString();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_2971.push(new SellablePetBreedData(param1));
                _loc3_++;
            };
            return (true);
        }


    }
}