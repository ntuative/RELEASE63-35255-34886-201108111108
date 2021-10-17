package com.sulake.habbo.avatar.pets
{
    public class Breed extends PetEditorInfo implements IBreed 
    {

        private var _id:int;
        private var var_2965:String = "";
        private var var_2938:String;
        private var var_2966:Boolean;
        private var var_2967:Boolean = true;
        private var var_2968:int;
        private var var_2969:String;

        public function Breed(param1:XML)
        {
            super(param1);
            this._id = parseInt(param1.@id);
            this.var_2968 = parseInt(param1.@pattern);
            this.var_2938 = String(param1.@gender);
            this.var_2966 = Boolean(parseInt(param1.@colorable));
            this.var_2965 = String(param1.@localizationKey);
            if (((Boolean(param1.@sellable)) && (param1.@sellable == "0")))
            {
                this.var_2967 = false;
            };
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get gender():String
        {
            return (this.var_2938);
        }

        public function get isColorable():Boolean
        {
            return (this.var_2966);
        }

        public function get isSellable():Boolean
        {
            return (this.var_2967);
        }

        public function get patternId():int
        {
            return (this.var_2968);
        }

        public function get avatarFigureString():String
        {
            return (this.var_2969);
        }

        public function set avatarFigureString(param1:String):void
        {
            this.var_2969 = param1;
        }

        public function get localizationKey():String
        {
            return (this.var_2965);
        }


    }
}