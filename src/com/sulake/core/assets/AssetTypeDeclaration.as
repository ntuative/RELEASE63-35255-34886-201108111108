package com.sulake.core.assets
{
    public class AssetTypeDeclaration 
    {

        private var var_2570:String;
        private var var_2571:Class;
        private var var_2572:Class;
        private var var_2573:Array;

        public function AssetTypeDeclaration(param1:String, param2:Class, param3:Class, ... _args)
        {
            this.var_2570 = param1;
            this.var_2571 = param2;
            this.var_2572 = param3;
            if (_args == null)
            {
                this.var_2573 = new Array();
            }
            else
            {
                this.var_2573 = _args;
            };
        }

        public function get mimeType():String
        {
            return (this.var_2570);
        }

        public function get assetClass():Class
        {
            return (this.var_2571);
        }

        public function get loaderClass():Class
        {
            return (this.var_2572);
        }

        public function get fileTypes():Array
        {
            return (this.var_2573);
        }


    }
}