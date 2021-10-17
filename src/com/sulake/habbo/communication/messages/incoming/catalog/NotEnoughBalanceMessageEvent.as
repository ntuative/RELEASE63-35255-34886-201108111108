package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.NotEnoughBalanceMessageParser;

    public class NotEnoughBalanceMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function NotEnoughBalanceMessageEvent(param1:Function)
        {
            super(param1, NotEnoughBalanceMessageParser);
        }

        public function getParser():NotEnoughBalanceMessageParser
        {
            return (this.var_334 as NotEnoughBalanceMessageParser);
        }


    }
}