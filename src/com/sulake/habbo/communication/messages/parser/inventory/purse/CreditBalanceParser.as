package com.sulake.habbo.communication.messages.parser.inventory.purse
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CreditBalanceParser implements IMessageParser 
    {

        private var var_3143:int;


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3143 = int(param1.readString());
            return (true);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function get balance():int
        {
            return (this.var_3143);
        }


    }
}