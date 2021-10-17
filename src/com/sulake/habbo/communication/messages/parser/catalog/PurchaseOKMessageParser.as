package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PurchaseOKMessageParser implements IMessageParser 
    {

        private var var_3078:CatalogPageMessageOfferData;


        public function get offer():CatalogPageMessageOfferData
        {
            return (this.var_3078);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3078 = new CatalogPageMessageOfferData(param1);
            return (true);
        }


    }
}