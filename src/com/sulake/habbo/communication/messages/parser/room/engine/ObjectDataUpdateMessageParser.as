package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ObjectDataUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _id:int = 0;
        private var _state:int = 0;
        private var _data:String;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
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

        public function flush():Boolean
        {
            this._state = 0;
            this._data = "";
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:String = param1.readString();
            this._id = int(_loc2_);
            this._data = param1.readString();
            var _loc3_:Number = parseFloat(this._data);
            if (!isNaN(_loc3_))
            {
                this._state = int(this._data);
            };
            return (true);
        }


    }
}