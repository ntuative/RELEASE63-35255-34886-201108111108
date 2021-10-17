package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ScrSendUserInfoMessageParser implements IMessageParser 
    {

        public static const var_628:int = 1;
        public static const RESPONSE_TYPE_PURCHASE:int = 2;
        public static const var_145:int = 3;

        private var var_3226:String;
        private var var_3864:int;
        private var var_3865:int;
        private var var_3866:int;
        private var var_3867:int;
        private var var_3868:Boolean;
        private var var_3170:Boolean;
        private var var_3171:int;
        private var var_3172:int;
        private var var_3869:Boolean;
        private var var_3870:int;
        private var var_3871:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3226 = param1.readString();
            this.var_3864 = param1.readInteger();
            this.var_3865 = param1.readInteger();
            this.var_3866 = param1.readInteger();
            this.var_3867 = param1.readInteger();
            this.var_3868 = param1.readBoolean();
            this.var_3170 = param1.readBoolean();
            this.var_3171 = param1.readInteger();
            this.var_3172 = param1.readInteger();
            this.var_3869 = param1.readBoolean();
            this.var_3870 = param1.readInteger();
            this.var_3871 = param1.readInteger();
            return (true);
        }

        public function get productName():String
        {
            return (this.var_3226);
        }

        public function get daysToPeriodEnd():int
        {
            return (this.var_3864);
        }

        public function get memberPeriods():int
        {
            return (this.var_3865);
        }

        public function get periodsSubscribedAhead():int
        {
            return (this.var_3866);
        }

        public function get responseType():int
        {
            return (this.var_3867);
        }

        public function get hasEverBeenMember():Boolean
        {
            return (this.var_3868);
        }

        public function get isVIP():Boolean
        {
            return (this.var_3170);
        }

        public function get pastClubDays():int
        {
            return (this.var_3171);
        }

        public function get pastVipDays():int
        {
            return (this.var_3172);
        }

        public function get isShowBasicPromo():Boolean
        {
            return (this.var_3869);
        }

        public function get basicNormalPrice():int
        {
            return (this.var_3870);
        }

        public function get basicPromoPrice():int
        {
            return (this.var_3871);
        }


    }
}