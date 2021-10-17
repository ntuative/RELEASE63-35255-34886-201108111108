package com.sulake.habbo.inventory.purse
{
    public class Purse 
    {

        private var var_3168:int = 0;
        private var var_3169:int = 0;
        private var var_4103:int = 0;
        private var var_4104:Boolean = false;
        private var var_3170:Boolean = false;
        private var var_3173:Boolean = false;


        public function set clubDays(param1:int):void
        {
            this.var_3168 = Math.max(0, param1);
        }

        public function set clubPeriods(param1:int):void
        {
            this.var_3169 = Math.max(0, param1);
        }

        public function set clubPastPeriods(param1:int):void
        {
            this.var_4103 = Math.max(0, param1);
        }

        public function set clubHasEverBeenMember(param1:Boolean):void
        {
            this.var_4104 = param1;
        }

        public function set isVIP(param1:Boolean):void
        {
            this.var_3170 = param1;
        }

        public function set clubIsExpiring(param1:Boolean):void
        {
            this.var_3173 = param1;
        }

        public function get clubDays():int
        {
            return (this.var_3168);
        }

        public function get clubPeriods():int
        {
            return (this.var_3169);
        }

        public function get clubPastPeriods():int
        {
            return (this.var_4103);
        }

        public function get clubHasEverBeenMember():Boolean
        {
            return (this.var_4104);
        }

        public function get isVIP():Boolean
        {
            return (this.var_3170);
        }

        public function get clubIsExpiring():Boolean
        {
            return (this.var_3173);
        }


    }
}