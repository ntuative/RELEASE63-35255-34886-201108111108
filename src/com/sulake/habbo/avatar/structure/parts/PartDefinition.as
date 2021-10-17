package com.sulake.habbo.avatar.structure.parts
{
    public class PartDefinition 
    {

        private var var_2984:String;
        private var var_2985:String;
        private var var_2986:String;
        private var var_2987:Boolean;
        private var var_2988:int = -1;

        public function PartDefinition(param1:XML)
        {
            this.var_2984 = String(param1.@["set-type"]);
            this.var_2985 = String(param1.@["flipped-set-type"]);
            this.var_2986 = String(param1.@["remove-set-type"]);
            this.var_2987 = false;
        }

        public function hasStaticId():Boolean
        {
            return (this.var_2988 >= 0);
        }

        public function get staticId():int
        {
            return (this.var_2988);
        }

        public function set staticId(param1:int):void
        {
            this.var_2988 = param1;
        }

        public function get setType():String
        {
            return (this.var_2984);
        }

        public function get flippedSetType():String
        {
            return (this.var_2985);
        }

        public function get removeSetType():String
        {
            return (this.var_2986);
        }

        public function get appendToFigure():Boolean
        {
            return (this.var_2987);
        }

        public function set appendToFigure(param1:Boolean):void
        {
            this.var_2987 = param1;
        }

        public function set flippedSetType(param1:String):void
        {
            this.var_2985 = param1;
        }


    }
}