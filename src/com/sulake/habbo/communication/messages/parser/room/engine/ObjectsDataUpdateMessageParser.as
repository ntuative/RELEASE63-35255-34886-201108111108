package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ObjectsDataUpdateMessageParser implements IMessageParser 
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

        public function get objectCount():int
        {
            return (this._objects.length);
        }

        public function getObjectData(param1:int):ObjectData
        {
            if (((param1 < 0) || (param1 >= this.objectCount)))
            {
                return (null);
            };
            return (this._objects[param1]);
        }

        public function flush():Boolean
        {
            this._objects = [];
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:int;
            var _loc5_:String;
            var _loc6_:int;
            var _loc7_:Number;
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = param1.readInteger();
                _loc5_ = param1.readString();
                _loc6_ = 0;
                _loc7_ = parseFloat(_loc5_);
                if (!isNaN(_loc7_))
                {
                    _loc6_ = int(_loc5_);
                };
                this._objects.push(new ObjectData(_loc4_, _loc6_, _loc5_));
                _loc3_++;
            };
            return (true);
        }


    }
}