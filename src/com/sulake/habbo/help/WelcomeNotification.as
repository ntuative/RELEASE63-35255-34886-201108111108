package com.sulake.habbo.help
{
    public class WelcomeNotification 
    {

        private var var_4041:String;
        private var var_2965:String;

        public function WelcomeNotification(param1:String, param2:String)
        {
            this.var_4041 = param1;
            this.var_2965 = param2;
        }

        public function get targetIconId():String
        {
            return (this.var_4041);
        }

        public function get localizationKey():String
        {
            return (this.var_2965);
        }


    }
}