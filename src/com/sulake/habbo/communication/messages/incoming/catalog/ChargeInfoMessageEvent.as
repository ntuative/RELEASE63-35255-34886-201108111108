package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.ChargeInfoMessageParser;

    public class ChargeInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ChargeInfoMessageEvent(param1:Function)
        {
            super(param1, ChargeInfoMessageParser);
        }

        public function getParser():ChargeInfoMessageParser
        {
            return (this.var_334 as ChargeInfoMessageParser);
        }


    }
}