package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogPageMessageProductData 
    {

        public static const var_106:String = "i";
        public static const var_105:String = "s";
        public static const var_111:String = "e";

        private var var_3301:String;
        private var var_3379:int;
        private var var_3302:String;
        private var var_3303:int;
        private var var_3304:int;

        public function CatalogPageMessageProductData(param1:IMessageDataWrapper)
        {
            this.var_3301 = param1.readString();
            this.var_3379 = param1.readInteger();
            this.var_3302 = param1.readString();
            this.var_3303 = param1.readInteger();
            this.var_3304 = param1.readInteger();
        }

        public function get productType():String
        {
            return (this.var_3301);
        }

        public function get furniClassId():int
        {
            return (this.var_3379);
        }

        public function get extraParam():String
        {
            return (this.var_3302);
        }

        public function get productCount():int
        {
            return (this.var_3303);
        }

        public function get expiration():int
        {
            return (this.var_3304);
        }


    }
}