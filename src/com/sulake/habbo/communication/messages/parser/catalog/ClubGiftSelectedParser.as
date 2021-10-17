package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftSelectedParser implements IMessageParser 
    {

        private var var_3083:String;
        private var var_3305:Array;


        public function flush():Boolean
        {
            this.var_3305 = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3305 = new Array();
            this.var_3083 = param1.readString();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3305.push(new CatalogPageMessageProductData(param1));
                _loc3_++;
            };
            return (true);
        }

        public function get productCode():String
        {
            return (this.var_3083);
        }

        public function get products():Array
        {
            return (this.var_3305);
        }


    }
}