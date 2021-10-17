package com.sulake.habbo.moderation
{
    public class BanDefinition 
    {

        private var _name:String;
        private var var_4151:int;

        public function BanDefinition(param1:String, param2:int)
        {
            this._name = param1;
            this.var_4151 = param2;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get banLengthHours():int
        {
            return (this.var_4151);
        }


    }
}