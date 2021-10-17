package com.sulake.habbo.avatar.alias
{
    public class AssetAlias 
    {

        private var _name:String;
        private var var_2724:String;
        private var var_2574:Boolean;
        private var var_2575:Boolean;

        public function AssetAlias(param1:XML)
        {
            this._name = String(param1.@name);
            this.var_2724 = String(param1.@link);
            this.var_2574 = Boolean(parseInt(param1.@fliph));
            this.var_2575 = Boolean(parseInt(param1.@flipv));
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get link():String
        {
            return (this.var_2724);
        }

        public function get flipH():Boolean
        {
            return (this.var_2574);
        }

        public function get flipV():Boolean
        {
            return (this.var_2575);
        }


    }
}