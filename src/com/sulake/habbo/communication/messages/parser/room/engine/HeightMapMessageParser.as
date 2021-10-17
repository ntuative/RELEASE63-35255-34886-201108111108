package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HeightMapMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _heightMap:Array = [];
        private var var_3806:Array = [];
        private var var_3807:Array = [];
        private var var_2731:int = 0;
        private var _height:int = 0;


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

        public function getTileHeight(param1:int, param2:int):Number
        {
            if (((((param1 < 0) || (param1 >= this.width)) || (param2 < 0)) || (param2 >= this.height)))
            {
                return (-1);
            };
            var _loc3_:Array = (this._heightMap[param2] as Array);
            return (Number(_loc3_[param1]));
        }

        public function getTileBlocking(param1:int, param2:int):Boolean
        {
            if (((((param1 < 0) || (param1 >= this.width)) || (param2 < 0)) || (param2 >= this.height)))
            {
                return (true);
            };
            var _loc3_:Array = (this.var_3806[param2] as Array);
            return (Boolean(_loc3_[param1]));
        }

        public function isRoomTile(param1:int, param2:int):Boolean
        {
            if (((((param1 < 0) || (param1 >= this.width)) || (param2 < 0)) || (param2 >= this.height)))
            {
                return (false);
            };
            var _loc3_:Array = (this.var_3807[param2] as Array);
            return (Boolean(_loc3_[param1]));
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._heightMap = [];
            this.var_3806 = [];
            this.var_3807 = [];
            this.var_2731 = 0;
            this._height = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc16_:String;
            var _loc17_:String;
            var _loc18_:Number;
            var _loc19_:Boolean;
            var _loc20_:Boolean;
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
            var _loc8_:Array = [];
            var _loc9_:Array;
            var _loc10_:Array = [];
            var _loc11_:Array;
            var _loc12_:Array = [];
            var _loc13_:Array;
            var _loc14_:Array;
            var _loc15_:int;
            this.var_2731 = 0;
            this._height = 0;
            _loc7_ = 0;
            while (_loc7_ < _loc5_.length)
            {
                _loc16_ = (_loc5_[_loc7_] as String);
                if (_loc16_.length > 0)
                {
                    if (_loc16_.length > this.var_2731)
                    {
                        this.var_2731 = _loc16_.length;
                    };
                    _loc9_ = [];
                    _loc8_[_loc7_] = _loc9_;
                    _loc11_ = [];
                    _loc10_[_loc7_] = _loc11_;
                    _loc13_ = [];
                    _loc12_[_loc7_] = _loc13_;
                    _loc6_ = 0;
                    while (_loc6_ < _loc16_.length)
                    {
                        _loc17_ = _loc16_.charAt(_loc6_);
                        if (((!(_loc17_ == "x")) && (!(_loc17_ == "X"))))
                        {
                            _loc15_ = this.getHeightValue(_loc17_);
                            _loc9_.push(_loc15_);
                            if (this.getBlocking(_loc17_))
                            {
                                _loc11_.push(true);
                            }
                            else
                            {
                                _loc11_.push(false);
                            };
                            _loc13_.push(true);
                        }
                        else
                        {
                            _loc9_.push(-1);
                            _loc11_.push(true);
                            _loc13_.push(false);
                        };
                        _loc6_++;
                    };
                };
                _loc7_++;
            };
            _loc7_ = 0;
            while (_loc7_ < _loc8_.length)
            {
                _loc9_ = (_loc8_[_loc7_] as Array);
                while (_loc9_.length < this.var_2731)
                {
                    _loc9_.push(-1);
                };
                _loc7_++;
            };
            this._heightMap = [];
            _loc7_ = 0;
            while (_loc7_ < _loc8_.length)
            {
                _loc14_ = [];
                this._heightMap.push(_loc14_);
                _loc9_ = (_loc8_[_loc7_] as Array);
                _loc6_ = 0;
                while (_loc6_ < this.var_2731)
                {
                    _loc18_ = Number(_loc9_[_loc6_]);
                    _loc14_.push(_loc18_);
                    _loc6_++;
                };
                _loc7_++;
            };
            _loc7_ = 0;
            while (_loc7_ < _loc10_.length)
            {
                _loc11_ = (_loc10_[_loc7_] as Array);
                while (_loc11_.length < this.var_2731)
                {
                    _loc11_.push(true);
                };
                _loc7_++;
            };
            this.var_3806 = [];
            _loc7_ = 0;
            while (_loc7_ < _loc10_.length)
            {
                _loc14_ = [];
                this.var_3806.push(_loc14_);
                _loc11_ = (_loc10_[_loc7_] as Array);
                _loc6_ = 0;
                while (_loc6_ < this.var_2731)
                {
                    _loc19_ = Boolean(_loc11_[_loc6_]);
                    _loc14_.push(_loc19_);
                    _loc6_++;
                };
                _loc7_++;
            };
            _loc7_ = 0;
            while (_loc7_ < _loc12_.length)
            {
                _loc13_ = (_loc12_[_loc7_] as Array);
                while (_loc13_.length < this.var_2731)
                {
                    _loc13_.push(false);
                };
                _loc7_++;
            };
            this.var_3807 = [];
            _loc7_ = 0;
            while (_loc7_ < _loc12_.length)
            {
                _loc14_ = [];
                this.var_3807.push(_loc14_);
                _loc13_ = (_loc12_[_loc7_] as Array);
                _loc6_ = 0;
                while (_loc6_ < this.var_2731)
                {
                    _loc20_ = Boolean(_loc13_[_loc6_]);
                    _loc14_.push(_loc20_);
                    _loc6_++;
                };
                _loc7_++;
            };
            this._height = this._heightMap.length;
            return (true);
        }

        private function getHeightValue(param1:String):int
        {
            var _loc2_:int = parseInt(param1, 16);
            return (_loc2_ % 10);
        }

        private function getBlocking(param1:String):Boolean
        {
            var _loc2_:int = parseInt(param1, 16);
            return (_loc2_ >= 10);
        }


    }
}