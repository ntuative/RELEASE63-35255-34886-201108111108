package com.sulake.habbo.catalog.purse
{
    import flash.events.Event;

    public class PurseEvent extends Event 
    {

        public static const var_140:String = "catalog_purse_credit_balance";
        public static const var_142:String = "catalog_purse_pixel_balance";
        public static const var_144:String = "catalog_purse_shell_balance";

        private var var_3143:int;

        public function PurseEvent(param1:String, param2:int, param3:Boolean=false, param4:Boolean=false)
        {
            super(param1, param3, param4);
            this.var_3143 = param2;
        }

        public function get balance():int
        {
            return (this.var_3143);
        }


    }
}