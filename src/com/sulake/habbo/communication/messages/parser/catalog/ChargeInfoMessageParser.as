package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.ChargeInfo;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChargeInfoMessageParser implements IMessageParser 
    {

        private var var_3145:ChargeInfo;


        public function flush():Boolean
        {
            this.var_3145 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3145 = new ChargeInfo(param1);
            return (true);
        }

        public function get chargeInfo():ChargeInfo
        {
            return (this.var_3145);
        }


    }
}