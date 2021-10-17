package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ViralTeaserActiveMessageParser implements IMessageParser 
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
            return (this._data);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this._data = new ObjectMessageData(-1);
            this._data.x = ((Math.random() * 5) + 7);
            this._data.y = ((Math.random() * 5) + 5);
            this._data.z = (Math.random() * 3);
            this._data.dir = 0;
            this._data.type = param1.readInteger();
            var _loc2_:String = param1.readString();
            if (((_loc2_ == null) || (_loc2_.length == 0)))
            {
                _loc2_ = "val11";
            };
            this._data.data = (("TYPE_INJECTED" + "+") + _loc2_);
            return (true);
        }


    }
}