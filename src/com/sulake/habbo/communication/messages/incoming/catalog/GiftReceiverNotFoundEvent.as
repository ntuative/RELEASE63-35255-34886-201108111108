package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.GiftReceiverNotFoundParser;

    public class GiftReceiverNotFoundEvent extends MessageEvent implements IMessageEvent 
    {

        public function GiftReceiverNotFoundEvent(param1:Function)
        {
            super(param1, GiftReceiverNotFoundParser);
        }

        public function getParser():GiftReceiverNotFoundParser
        {
            return (this.var_334 as GiftReceiverNotFoundParser);
        }


    }
}