package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionDanceEvent extends RoomSessionEvent 
    {

        public static const var_377:String = "RSDE_DANCE";

        private var _userId:int;
        private var _danceStyle:int;

        public function RoomSessionDanceEvent(param1:IRoomSession, param2:int, param3:int, param4:Boolean=false, param5:Boolean=false)
        {
            super(var_377, param1, param4, param5);
            this._userId = param2;
            this._danceStyle = param3;
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get danceStyle():int
        {
            return (this._danceStyle);
        }


    }
}