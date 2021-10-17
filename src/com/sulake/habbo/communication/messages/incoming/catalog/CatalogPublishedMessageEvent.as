package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogPublishedMessageParser;

    public class CatalogPublishedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CatalogPublishedMessageEvent(param1:Function)
        {
            super(param1, CatalogPublishedMessageParser);
        }

        public function getParser():CatalogPublishedMessageParser
        {
            return (this.var_334 as CatalogPublishedMessageParser);
        }


    }
}