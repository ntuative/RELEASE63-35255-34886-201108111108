package com.sulake.habbo.communication.messages.incoming.inventory.purse
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.purse.CreditBalanceParser;

    public class CreditBalanceEvent extends MessageEvent implements IMessageEvent 
    {

        public function CreditBalanceEvent(param1:Function)
        {
            super(param1, CreditBalanceParser);
        }

        public function getParser():CreditBalanceParser
        {
            return (this.var_334 as CreditBalanceParser);
        }


    }
}