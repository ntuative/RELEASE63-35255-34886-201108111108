package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ObjectAddMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _data:ObjectMessageData;


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
            this._data = null;
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }

        public function get data():ObjectMessageData
        {
            var _loc1_:ObjectMessageData = this._data;
            if (_loc1_ != null)
            {
                _loc1_.setReadOnly();
            };
            return (_loc1_);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this._data = ObjectDataParser.parseObjectData(param1);
            return (true);
        }


    }
}