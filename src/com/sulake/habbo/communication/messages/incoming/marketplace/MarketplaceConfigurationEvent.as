package com.sulake.habbo.communication.messages.incoming.marketplace
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationParser;

    public class MarketplaceConfigurationEvent extends MessageEvent implements IMessageEvent 
    {

        public function MarketplaceConfigurationEvent(param1:Function)
        {
            super(param1, MarketplaceConfigurationParser);
        }

        public function getParser():MarketplaceConfigurationParser
        {
            return (var_334 as MarketplaceConfigurationParser);
        }


    }
}