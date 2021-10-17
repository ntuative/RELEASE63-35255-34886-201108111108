package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FloorHeightMapMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _heightMap:Array = [];
        private var var_2731:int = 0;
        private var _height:int = 0;
        private var _scale:Number = 0;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get width():int
        {
            return (this.var_2731);
        }

        public function get height():int
        {
            return (this._height);
        }

        public function get scale():Number
        {
            return (this._scale);
        }

        public function getTileHeight(param1:int, param2:int):int
        {
            if (((((param1 < 0) || (param1 >= this.width)) || (param2 < 0)) || (param2 >= this.height)))
            {
                return (RoomPlaneParser.var_1825);
            };
            var _loc3_:Array = (this._heightMap[param2] as Array);
            return (_loc3_[param1]);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._heightMap = [];
            this.var_2731 = 0;
            this._height = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc13_:String;
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:String = param1.readString();
            var _loc5_:Array = _loc4_.split("\r");
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:Array;
            var _loc10_:int = _loc5_.length;
            var _loc11_:int;
            var _loc12_:String;
            _loc7_ = 0;
            while (_loc7_ < _loc10_)
            {
                _loc12_ = (_loc5_[_loc7_] as String);
                if (_loc12_.length > _loc11_)
                {
                    _loc11_ = _loc12_.length;
                };
                _loc7_++;
            };
            this._heightMap = [];
            _loc7_ = 0;
            while (_loc7_ < _loc10_)
            {
                _loc9_ = [];
                _loc6_ = 0;
                while (_loc6_ < _loc11_)
                {
                    _loc9_.push(RoomPlaneParser.var_1825);
                    _loc6_++;
                };
                this._heightMap.push(_loc9_);
                _loc7_++;
            };
            this.var_2731 = _loc11_;
            this._height = _loc10_;
            _loc7_ = 0;
            while (_loc7_ < _loc5_.length)
            {
                _loc9_ = (this._heightMap[_loc7_] as Array);
                _loc12_ = (_loc5_[_loc7_] as String);
                if (_loc12_.length > 0)
                {
                    _loc6_ = 0;
                    while (_loc6_ < _loc12_.length)
                    {
                        _loc13_ = _loc12_.charAt(_loc6_);
                        if (((!(_loc13_ == "x")) && (!(_loc13_ == "X"))))
                        {
                            _loc8_ = this.getHeightValue(_loc13_);
                        }
                        else
                        {
                            _loc8_ = RoomPlaneParser.var_1825;
                        };
                        _loc9_[_loc6_] = _loc8_;
                        _loc6_++;
                    };
                };
                _loc7_++;
            };
            if (((this.var_2731 >= 20) || (this._height >= 20)))
            {
                this._scale = 32;
            }
            else
            {
                this._scale = 64;
            };
            return (true);
        }

        private function getHeightValue(param1:String):int
        {
            var _loc2_:int = parseInt(param1, 16);
            return (_loc2_ % 10);
        }


    }
}