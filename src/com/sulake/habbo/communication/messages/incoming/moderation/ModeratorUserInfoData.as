package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorUserInfoData 
    {

        private var _userId:int;
        private var _userName:String;
        private var var_3454:int;
        private var var_3455:int;
        private var var_3400:Boolean;
        private var var_3456:int;
        private var var_3457:int;
        private var var_3458:int;
        private var var_3459:int;

        public function ModeratorUserInfoData(param1:IMessageDataWrapper)
        {
            this._userId = param1.readInteger();
            this._userName = param1.readString();
            this.var_3454 = param1.readInteger();
            this.var_3455 = param1.readInteger();
            this.var_3400 = param1.readBoolean();
            this.var_3456 = param1.readInteger();
            this.var_3457 = param1.readInteger();
            this.var_3458 = param1.readInteger();
            this.var_3459 = param1.readInteger();
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get userName():String
        {
            return (this._userName);
        }

        public function get minutesSinceRegistration():int
        {
            return (this.var_3454);
        }

        public function get minutesSinceLastLogin():int
        {
            return (this.var_3455);
        }

        public function get online():Boolean
        {
            return (this.var_3400);
        }

        public function get var_2246():int
        {
            return (this.var_3456);
        }

        public function get abusiveCfhCount():int
        {
            return (this.var_3457);
        }

        public function get cautionCount():int
        {
            return (this.var_3458);
        }

        public function get banCount():int
        {
            return (this.var_3459);
        }


    }
}