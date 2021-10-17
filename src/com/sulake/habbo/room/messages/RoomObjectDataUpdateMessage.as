package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectDataUpdateMessage extends RoomObjectUpdateMessage 
    {

        private var _state:int;
        private var _data:String;
        private var var_3434:Number = NaN;

        public function RoomObjectDataUpdateMessage(param1:int, param2:String, param3:Number=NaN)
        {
            super(null, null);
            this._state = param1;
            this._data = param2;
            this.var_3434 = param3;
        }

        public function get state():int
        {
            return (this._state);
        }

        public function get data():String
        {
            return (this._data);
        }

        public function get extra():Number
        {
            return (this.var_3434);
        }


    }
}