package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectDimmerStateUpdateEvent extends RoomObjectEvent 
    {

        public static const var_380:String = "RODSUE_DIMMER_STATE";

        private var _state:int;
        private var var_4479:int;
        private var var_3794:int;
        private var _color:uint;
        private var var_4480:int;

        public function RoomObjectDimmerStateUpdateEvent(param1:int, param2:String, param3:int, param4:int, param5:int, param6:uint, param7:int, param8:Boolean=false, param9:Boolean=false)
        {
            super(var_380, param1, param2, param8, param9);
            this._state = param3;
            this.var_4479 = param4;
            this.var_3794 = param5;
            this._color = param6;
            this.var_4480 = param7;
        }

        public function get state():int
        {
            return (this._state);
        }

        public function get presetId():int
        {
            return (this.var_4479);
        }

        public function get effectId():int
        {
            return (this.var_3794);
        }

        public function get color():uint
        {
            return (this._color);
        }

        public function get brightness():uint
        {
            return (this.var_4480);
        }


    }
}