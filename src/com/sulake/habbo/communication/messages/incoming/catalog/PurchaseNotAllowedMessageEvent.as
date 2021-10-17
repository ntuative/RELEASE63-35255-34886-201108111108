package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.PurchaseNotAllowedMessageParser;

    public class PurchaseNotAllowedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PurchaseNotAllowedMessageEvent(param1:Function)
        {
            super(param1, PurchaseNotAllowedMessageParser);
        }

        public function getParser():PurchaseNotAllowedMessageParser
        {
            return (this.var_334 as PurchaseNotAllowedMessageParser);
        }


    }
}