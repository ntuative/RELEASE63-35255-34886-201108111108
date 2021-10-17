package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomFloorHoleUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const var_456:String = "RORPFHUM_ADD";
        public static const var_459:String = "RORPFHUM_REMOVE";

        private var _type:String = "";
        private var _id:int;
        private var _x:int;
        private var var_2960:int;
        private var var_2731:int;
        private var _height:int;

        public function RoomObjectRoomFloorHoleUpdateMessage(param1:String, param2:int, param3:int=0, param4:int=0, param5:int=0, param6:int=0)
        {
            super(null, null);
            this._type = param1;
            this._id = param2;
            this._x = param3;
            this.var_2960 = param4;
            this.var_2731 = param5;
            this._height = param6;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get id():int
        {
            return (this._id);
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