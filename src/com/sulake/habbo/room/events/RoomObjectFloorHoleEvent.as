package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectFloorHoleEvent extends RoomObjectEvent 
    {

        public static const var_456:String = "ROFHO_ADD_HOLE";
        public static const var_459:String = "ROFHO_REMOVE_HOLE";

        public function RoomObjectFloorHoleEvent(param1:String, param2:int, param3:String, param4:Boolean=false, param5:Boolean=false)
        {
            super(param1, param2, param3, param4, param5);
        }

    }
}