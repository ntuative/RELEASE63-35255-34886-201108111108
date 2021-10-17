package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HeightMapUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _heightMap:Array = [];
        private var var_3806:Array = [];


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function getTileHeight(param1:int, param2:int, param3:Number, param4:int, param5:int):Number
        {
            if (((((param1 < 0) || (param1 >= param4)) || (param2 < 0)) || (param2 >= param5)))
            {
                return (param3);
            };
            var _loc6_:int = (param1 + (param2 * param4));
            if (((_loc6_ < 0) || (_loc6_ >= this._heightMap.length)))
            {
                return (param3);
            };
            var _loc7_:int = int(this._heightMap[_loc6_]);
            if (_loc7_ == 0)
            {
                return (param3);
            };
            return (_loc7_ - 1);
        }

        public function getTileBlocking(param1:int, param2:int, param3:Boolean, param4:int, param5:int):Boolean
        {
            if (((((param1 < 0) || (param1 >= param4)) || (param2 < 0)) || (param2 >= param5)))
            {
                return (param3);
            };
            var _loc6_:int = (param1 + (param2 * param4));
            if ((((_loc6_ < 0) || (_loc6_ >= this._heightMap.length)) || (_loc6_ >= this.var_3806.length)))
            {
                return (param3);
            };
            var _loc7_:int = int(this._heightMap[_loc6_]);
            if (_loc7_ == 0)
            {
                return (param3);
            };
            return (this.var_3806[_loc6_]);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._heightMap = [];
            this.var_3806 = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:String = param1.readString();
            if (((_loc4_.indexOf("x") == 0) || (_loc4_.indexOf("X") == 0)))
            {
                return (this.parseNormal(_loc4_));
            };
            return (this.parseCompressed(_loc4_));
        }

        private function parseCompressed(param1:String):Boolean
        {
            var _loc5_:String;
            var _loc6_:int;
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:int;
            var _loc3_:int;
            this._heightMap = [];
            this.var_3806 = [];
            var _loc4_:int;
            if (param1.length > 0)
            {
                _loc2_ = 0;
                while (_loc2_ < param1.length)
                {
                    _loc5_ = param1.charAt(_loc2_);
                    if (_loc5_ == "!")
                    {
                        _loc6_ = (param1.charCodeAt(++_loc2_) - 32);
                        _loc3_ = 0;
                        while (_loc3_ < _loc6_)
                        {
                            this._heightMap.push(0);
                            this.var_3806.push(false);
                            _loc3_++;
                        };
                    }
                    else
                    {
                        _loc4_ = (this.getHeightValue(_loc5_) + 1);
                        this._heightMap.push(_loc4_);
                        if (this.getBlocking(_loc5_))
                        {
                            this.var_3806.push(true);
                        }
                        else
                        {
                            this.var_3806.push(false);
                        };
                    };
                    _loc2_++;
                };
            };
            return (true);
        }

        private function parseNormal(param1:String):Boolean
        {
            var _loc6_:String;
            var _loc7_:String;
            if (String == null)
            {
                return (false);
            };
            var _loc2_:Array = param1.split("\r");
            var _loc3_:int;
            var _loc4_:int;
            this._heightMap = [];
            this.var_3806 = [];
            var _loc5_:int;
            _loc4_ = 0;
            while (_loc4_ < _loc2_.length)
            {
                _loc6_ = (_loc2_[_loc4_] as String);
                _loc3_ = 0;
                while (_loc3_ < _loc6_.length)
                {
                    _loc7_ = _loc6_.charAt(_loc3_);
                    if (((!(_loc7_ == "x")) && (!(_loc7_ == "X"))))
                    {
                        _loc5_ = (this.getHeightValue(_loc7_) + 1);
                        this._heightMap.push(_loc5_);
                        if (this.getBlocking(_loc7_))
                        {
                            this.var_3806.push(true);
                        }
                        else
                        {
                            this.var_3806.push(false);
                        };
                    }
                    else
                    {
                        this._heightMap.push(0);
                        this.var_3806.push(true);
                    };
                    _loc3_++;
                };
                _loc4_++;
            };
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