package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRoomEngineUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1556:String = "RWREUE_GAME_MODE";
        public static const var_450:String = "RWREUE_NORMAL_MODE";

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function RoomWidgetRoomEngineUpdateEvent(param1:String, param2:int, param3:int, param4:Boolean=false, param5:Boolean=false)
        {
            super(param1, param4, param5);
            this._roomId = param2;
            this._roomCategory = param3;
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }


    }
}