package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPropertyUpdateEvent extends RoomSessionEvent 
    {

        public static const var_250:String = "RSDUE_ALLOW_PETS";

        public function RoomSessionPropertyUpdateEvent(param1:String, param2:IRoomSession, param3:Boolean=false, param4:Boolean=false)
        {
            super(param1, param2, param3, param4);
        }

    }
}