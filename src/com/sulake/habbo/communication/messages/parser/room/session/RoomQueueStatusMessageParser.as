package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomQueueStatusMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_3845:Map = new Map();
        private var var_3846:int = 0;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get activeTarget():int
        {
            return (this.var_3846);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this.var_3845.reset();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc3_:int;
            var _loc4_:RoomQueueSet;
            var _loc6_:String;
            var _loc7_:int;
            var _loc8_:int;
            this.var_3845.reset();
            var _loc2_:int = param1.readInteger();
            var _loc5_:int;
            while (_loc5_ < _loc2_)
            {
                _loc6_ = param1.readString();
                _loc7_ = param1.readInteger();
                if (_loc5_ == 0)
                {
                    this.var_3846 = _loc7_;
                };
                _loc4_ = new RoomQueueSet(_loc6_, _loc7_);
                _loc3_ = param1.readInteger();
                _loc8_ = 0;
                while (_loc8_ < _loc3_)
                {
                    _loc4_.addQueue(param1.readString(), param1.readInteger());
                    _loc8_++;
                };
                this.var_3845.add(_loc4_.target, _loc4_);
                _loc5_++;
            };
            return (true);
        }

        public function getQueueSetTargets():Array
        {
            return (this.var_3845.getKeys());
        }

        public function getQueueSet(param1:int):RoomQueueSet
        {
            return (this.var_3845.getValue(param1) as RoomQueueSet);
        }


    }
}