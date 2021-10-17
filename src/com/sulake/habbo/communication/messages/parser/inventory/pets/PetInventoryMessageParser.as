package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetInventoryMessageParser implements IMessageParser 
    {

        private var _pets:Array;


        public function flush():Boolean
        {
            this._pets = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:PetData;
            this._pets = [];
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = new PetData(param1);
                this._pets.push(_loc4_);
                _loc3_++;
            };
            return (true);
        }

        public function get pets():Array
        {
            return (this._pets);
        }


    }
}