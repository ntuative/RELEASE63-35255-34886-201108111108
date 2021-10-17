package com.sulake.habbo.friendlist.events
{
    import flash.events.Event;

    public class FriendRequestEvent extends Event 
    {

        public static const var_345:String = "FRE_ACCEPTED";
        public static const var_1373:String = "FRE_DECLINED";

        private var var_3405:int;

        public function FriendRequestEvent(param1:String, param2:int, param3:Boolean=false, param4:Boolean=false)
        {
            super(param1, param3, param4);
            this.var_3405 = param2;
        }

        public function get requestId():int
        {
            return (this.var_3405);
        }


    }
}