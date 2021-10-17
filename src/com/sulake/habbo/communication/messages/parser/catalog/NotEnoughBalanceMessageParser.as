package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NotEnoughBalanceMessageParser implements IMessageParser 
    {

        private var var_3646:int = 0;
        private var var_3647:int = 0;
        private var var_3297:int = 0;


        public function get notEnoughCredits():int
        {
            return (this.var_3646);
        }

        public function get notEnoughActivityPoints():int
        {
            return (this.var_3647);
        }

        public function get activityPointType():int
        {
            return (this.var_3297);
        }

        public function flush():Boolean
        {
            this.var_3646 = 0;
            this.var_3647 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3646 = param1.readInteger();
            this.var_3647 = param1.readInteger();
            this.var_3297 = param1.readInteger();
            return (true);
        }


    }
}