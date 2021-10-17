package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetData 
    {

        private var _id:int;
        private var _name:String;
        private var _type:int;
        private var var_2978:int;
        private var _color:String;

        public function PetData(param1:IMessageDataWrapper)
        {
            this._id = param1.readInteger();
            this._name = param1.readString();
            this._type = param1.readInteger();
            this.var_2978 = param1.readInteger();
            this._color = param1.readString();
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get breed():int
        {
            return (this.var_2978);
        }

        public function get color():String
        {
            return (this._color);
        }

        public function get figureString():String
        {
            return ((((this._type + " ") + this.breed) + " ") + this.color);
        }


    }
}