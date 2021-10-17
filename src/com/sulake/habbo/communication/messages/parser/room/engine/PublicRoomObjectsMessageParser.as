package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.PublicRoomObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicRoomObjectsMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _objects:Array = [];


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function flush():Boolean
        {
            this._objects = [];
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }

        public function getObjectCount():int
        {
            return (this._objects.length);
        }

        public function getObject(param1:int):PublicRoomObjectMessageData
        {
            if (((param1 < 0) || (param1 >= this.getObjectCount())))
            {
                return (null);
            };
            var _loc2_:PublicRoomObjectMessageData = (this._objects[param1] as PublicRoomObjectMessageData);
            if (_loc2_ != null)
            {
                _loc2_.setReadOnly();
            };
            return (_loc2_);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:PublicRoomObjectMessageData;
            if (param1 == null)
            {
                return (false);
            };
            this._objects = [];
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = PublicRoomObjectDataParser.parseObjectData(param1);
                if (_loc4_ != null)
                {
                    this._objects.push(_loc4_);
                };
                _loc3_++;
            };
            return (true);
        }


    }
}