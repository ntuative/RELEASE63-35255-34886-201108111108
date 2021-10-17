package com.sulake.habbo.room.utils
{
    public class TileHeightMap 
    {

        private var _heightData:Array = [];
        private var var_4876:Array = [];
        private var var_4877:Array = [];
        private var var_4878:int = 0;
        private var var_4879:int = 0;

        public function TileHeightMap(param1:int, param2:int)
        {
            var _loc4_:Array;
            var _loc5_:Array;
            var _loc6_:Array;
            var _loc7_:int;
            super();
            var _loc3_:int;
            while (_loc3_ < param2)
            {
                _loc4_ = [];
                _loc5_ = [];
                _loc6_ = [];
                _loc7_ = 0;
                while (_loc7_ < param1)
                {
                    _loc4_.push(0);
                    _loc5_.push(false);
                    _loc6_.push(false);
                    _loc7_++;
                };
                this._heightData.push(_loc4_);
                this.var_4876.push(_loc5_);
                this.var_4877.push(_loc6_);
                _loc3_++;
            };
            this.var_4878 = param1;
            this.var_4879 = param2;
        }

        public function get mapWidth():int
        {
            return (this.var_4878);
        }

        public function get mapHeight():int
        {
            return (this.var_4879);
        }

        public function dispose():void
        {
            this._heightData = [];
            this.var_4876 = [];
            this.var_4877 = [];
            this.var_4878 = 0;
            this.var_4879 = 0;
        }

        public function getTileHeight(param1:int, param2:int):Number
        {
            var _loc3_:Array;
            if (((((param1 >= 0) && (param1 < this.var_4878)) && (param2 >= 0)) && (param2 < this.var_4879)))
            {
                _loc3_ = (this._heightData[param2] as Array);
                return (Number(_loc3_[param1]));
            };
            return (0);
        }

        public function setTileHeight(param1:int, param2:int, param3:Number):void
        {
            var _loc4_:Array;
            if (((((param1 >= 0) && (param1 < this.var_4878)) && (param2 >= 0)) && (param2 < this.var_4879)))
            {
                _loc4_ = (this._heightData[param2] as Array);
                _loc4_[param1] = param3;
            };
        }

        public function getTileBlocking(param1:int, param2:int):Boolean
        {
            var _loc3_:Array;
            if (((((param1 >= 0) && (param1 < this.var_4878)) && (param2 >= 0)) && (param2 < this.var_4879)))
            {
                _loc3_ = (this.var_4876[param2] as Array);
                return (Boolean(_loc3_[param1]));
            };
            return (true);
        }

        public function setTileBlocking(param1:int, param2:int, param3:Boolean):void
        {
            var _loc4_:Array;
            if (((((param1 >= 0) && (param1 < this.var_4878)) && (param2 >= 0)) && (param2 < this.var_4879)))
            {
                _loc4_ = (this.var_4876[param2] as Array);
                _loc4_[param1] = param3;
            };
        }

        public function isRoomTile(param1:int, param2:int):Boolean
        {
            var _loc3_:Array;
            if (((((param1 >= 0) && (param1 < this.var_4878)) && (param2 >= 0)) && (param2 < this.var_4879)))
            {
                _loc3_ = (this.var_4877[param2] as Array);
                return (Boolean(_loc3_[param1]));
            };
            return (true);
        }

        public function setIsRoomTile(param1:int, param2:int, param3:Boolean):void
        {
            var _loc4_:Array;
            if (((((param1 >= 0) && (param1 < this.var_4878)) && (param2 >= 0)) && (param2 < this.var_4879)))
            {
                _loc4_ = (this.var_4877[param2] as Array);
                _loc4_[param1] = param3;
                if (!param3)
                {
                    this.setTileBlocking(param1, param2, true);
                };
            };
        }

        public function validateLocation(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int):Boolean
        {
            var _loc13_:Boolean;
            var _loc14_:Number;
            if (((((param1 < 0) || (param1 >= this.var_4878)) || (param2 < 0)) || (param2 >= this.var_4879)))
            {
                return (false);
            };
            if (param3 > this.var_4878)
            {
                return (false);
            };
            if (param4 > this.var_4879)
            {
                return (false);
            };
            if ((((param1 + param3) > this.var_4878) || ((param2 + param4) > this.var_4879)))
            {
                return (false);
            };
            if (((param5 < 0) || (param5 >= this.var_4878)))
            {
                param5 = 0;
            };
            if (((param6 < 0) || (param6 >= this.var_4879)))
            {
                param6 = 0;
            };
            if (param7 > this.var_4878)
            {
                param7 = this.var_4878;
            };
            if (param8 > this.var_4879)
            {
                param8 = this.var_4879;
            };
            if ((param5 + param7) >= this.var_4878)
            {
                param7 = (this.var_4878 - param5);
            };
            if ((param6 + param8) >= this.var_4879)
            {
                param8 = (this.var_4879 - param6);
            };
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:Array;
            _loc10_ = param2;
            while (_loc10_ < (param2 + param4))
            {
                _loc11_ = (this.var_4876[_loc10_] as Array);
                _loc9_ = param1;
                while (_loc9_ < (param1 + param3))
                {
                    if (((((_loc9_ < param5) || (_loc9_ >= (param5 + param7))) || (_loc10_ < param6)) || (_loc10_ >= (param6 + param8))))
                    {
                        _loc13_ = Boolean(_loc11_[_loc9_]);
                        if (_loc13_)
                        {
                            return (false);
                        };
                    };
                    _loc9_++;
                };
                _loc10_++;
            };
            _loc11_ = (this._heightData[param2] as Array);
            var _loc12_:Number = Number(_loc11_[param1]);
            _loc10_ = param2;
            while (_loc10_ < (param2 + param4))
            {
                _loc11_ = (this._heightData[_loc10_] as Array);
                _loc9_ = param1;
                while (_loc9_ < (param1 + param3))
                {
                    if (((((_loc9_ < param5) || (_loc9_ >= (param5 + param7))) || (_loc10_ < param6)) || (_loc10_ >= (param6 + param8))))
                    {
                        _loc14_ = Number(_loc11_[_loc9_]);
                        if (_loc14_ > _loc12_)
                        {
                            return (false);
                        };
                    };
                    _loc9_++;
                };
                _loc10_++;
            };
            return (true);
        }


    }
}