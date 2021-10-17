package com.sulake.habbo.catalog.purse
{
    import flash.utils.Dictionary;

    public class Purse implements IPurse 
    {

        private var var_3166:int = 0;
        private var var_3167:Dictionary = new Dictionary();
        private var var_3168:int = 0;
        private var var_3169:int = 0;
        private var var_3170:Boolean = false;
        private var var_3171:int = 0;
        private var var_3172:int = 0;
        private var var_3173:Boolean = false;


        public function get credits():int
        {
            return (this.var_3166);
        }

        public function set credits(param1:int):void
        {
            this.var_3166 = param1;
        }

        public function get clubDays():int
        {
            return (this.var_3168);
        }

        public function set clubDays(param1:int):void
        {
            this.var_3168 = param1;
        }

        public function get clubPeriods():int
        {
            return (this.var_3169);
        }

        public function set clubPeriods(param1:int):void
        {
            this.var_3169 = param1;
        }

        public function get hasClubLeft():Boolean
        {
            return ((this.var_3168 > 0) || (this.var_3169 > 0));
        }

        public function get isVIP():Boolean
        {
            return (this.var_3170);
        }

        public function get isExpiring():Boolean
        {
            return (this.var_3173);
        }

        public function set isExpiring(param1:Boolean):void
        {
            this.var_3173 = param1;
        }

        public function set isVIP(param1:Boolean):void
        {
            this.var_3170 = param1;
        }

        public function get pastClubDays():int
        {
            return (this.var_3171);
        }

        public function set pastClubDays(param1:int):void
        {
            this.var_3171 = param1;
        }

        public function get pastVipDays():int
        {
            return (this.var_3172);
        }

        public function set pastVipDays(param1:int):void
        {
            this.var_3172 = param1;
        }

        public function get activityPoints():Dictionary
        {
            return (this.var_3167);
        }

        public function set activityPoints(param1:Dictionary):void
        {
            this.var_3167 = param1;
        }

        public function getActivityPointsForType(param1:int):int
        {
            return (this.var_3167[param1]);
        }


    }
}