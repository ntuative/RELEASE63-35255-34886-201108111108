package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class ObjectData 
    {

        private var _id:int = 0;
        private var _state:int = 0;
        private var _data:String = "";

        public function ObjectData(param1:int, param2:int, param3:String)
        {
            this._id = param1;
            this._state = param2;
            this._data = param3;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get state():int
        {
            return (this._state);
        }

        public function get data():String
        {
            return (this._data);
        }


    }
}