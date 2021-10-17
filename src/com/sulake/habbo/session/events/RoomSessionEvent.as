package com.sulake.habbo.session.events
{
    import flash.events.Event;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionEvent extends Event 
    {

        public static const var_93:String = "RSE_CREATED";
        public static const var_94:String = "RSE_STARTED";
        public static const var_98:String = "RSE_ENDED";

        private var var_2487:IRoomSession;

        public function RoomSessionEvent(param1:String, param2:IRoomSession, param3:Boolean=false, param4:Boolean=false)
        {
            super(param1, param3, param4);
            this.var_2487 = param2;
        }

        public function get session():IRoomSession
        {
            return (this.var_2487);
        }


    }
}