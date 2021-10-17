package com.sulake.habbo.messenger.domain
{
    public class Message 
    {

        public static const var_1387:int = 1;
        public static const var_276:int = 2;
        public static const var_1388:int = 3;
        public static const var_278:int = 4;
        public static const var_1389:int = 5;
        public static const var_277:int = 6;

        private var _type:int;
        private var var_3670:int;
        private var var_3671:String;
        private var var_4141:String;

        public function Message(param1:int, param2:int, param3:String, param4:String)
        {
            this._type = param1;
            this.var_3670 = param2;
            this.var_3671 = param3;
            this.var_4141 = param4;
        }

        public function get messageText():String
        {
            return (this.var_3671);
        }

        public function get time():String
        {
            return (this.var_4141);
        }

        public function get senderId():int
        {
            return (this.var_3670);
        }

        public function get type():int
        {
            return (this._type);
        }


    }
}