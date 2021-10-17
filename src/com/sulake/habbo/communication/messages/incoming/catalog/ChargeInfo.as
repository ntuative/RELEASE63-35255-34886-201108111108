package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChargeInfo 
    {

        private var var_3380:int;
        private var var_3381:int;
        private var var_3295:int;
        private var var_3296:int;
        private var var_3297:int;
        private var var_3382:int;

        public function ChargeInfo(param1:IMessageDataWrapper)
        {
            this.var_3380 = param1.readInteger();
            this.var_3381 = param1.readInteger();
            this.var_3295 = param1.readInteger();
            this.var_3296 = param1.readInteger();
            this.var_3297 = param1.readInteger();
            this.var_3382 = param1.readInteger();
        }

        public function get stuffId():int
        {
            return (this.var_3380);
        }

        public function get charges():int
        {
            return (this.var_3381);
        }

        public function get priceInCredits():int
        {
            return (this.var_3295);
        }

        public function get priceInActivityPoints():int
        {
            return (this.var_3296);
        }

        public function get chargePatchSize():int
        {
            return (this.var_3382);
        }

        public function get activityPointType():int
        {
            return (this.var_3297);
        }


    }
}