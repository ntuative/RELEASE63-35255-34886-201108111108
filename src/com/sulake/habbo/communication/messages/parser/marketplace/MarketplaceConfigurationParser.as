package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceConfigurationParser implements IMessageParser 
    {

        private var var_2996:Boolean;
        private var var_3728:int;
        private var var_3729:int;
        private var var_3730:int;
        private var var_3731:int;
        private var var_3732:int;
        private var var_3733:int;
        private var var_3119:int;


        public function get isEnabled():Boolean
        {
            return (this.var_2996);
        }

        public function get commission():int
        {
            return (this.var_3728);
        }

        public function get tokenBatchPrice():int
        {
            return (this.var_3729);
        }

        public function get tokenBatchSize():int
        {
            return (this.var_3730);
        }

        public function get offerMinPrice():int
        {
            return (this.var_3732);
        }

        public function get offerMaxPrice():int
        {
            return (this.var_3731);
        }

        public function get expirationHours():int
        {
            return (this.var_3733);
        }

        public function get averagePricePeriod():int
        {
            return (this.var_3119);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2996 = param1.readBoolean();
            this.var_3728 = param1.readInteger();
            this.var_3729 = param1.readInteger();
            this.var_3730 = param1.readInteger();
            this.var_3732 = param1.readInteger();
            this.var_3731 = param1.readInteger();
            this.var_3733 = param1.readInteger();
            this.var_3119 = param1.readInteger();
            return (true);
        }


    }
}