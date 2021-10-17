package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionDoorbellEvent extends RoomSessionEvent 
    {

        public static const var_343:String = "RSDE_DOORBELL";
        public static const var_344:String = "RSDE_REJECTED";
        public static const var_345:String = "RSDE_ACCEPTED";

        private var _userName:String = "";

        public function RoomSessionDoorbellEvent(param1:String, param2:IRoomSession, param3:String, param4:Boolean=false, param5:Boolean=false)
        {
            super(param1, param2, param4, param5);
            this._userName = param3;
        }

        public function get userName():String
        {
            return (this._userName);
        }


    }
}