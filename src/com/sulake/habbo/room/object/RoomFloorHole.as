package com.sulake.habbo.room.object
{
    public class RoomFloorHole 
    {

        private var _x:int;
        private var var_2960:int;
        private var var_2731:int;
        private var _height:int;

        public function RoomFloorHole(param1:int, param2:int, param3:int, param4:int)
        {
            this._x = param1;
            this.var_2960 = param2;
            this.var_2731 = param3;
            this._height = param4;
        }

        public function get x():int
        {
            return (this._x);
        }

        public function get y():int
        {
            return (this.var_2960);
        }

        public function get width():int
        {
            return (this.var_2731);
        }

        public function get height():int
        {
            return (this._height);
        }


    }
}