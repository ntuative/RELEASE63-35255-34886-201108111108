package com.sulake.habbo.room.object
{
    import com.sulake.core.utils.Map;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.XMLValidator;

    public class RoomPlaneParser 
    {

        private static const var_492:Number = 0.25;
        private static const var_491:Number = 0.25;
        public static const var_1825:int = -110;
        public static const var_1829:int = -100;

        private var var_4833:Array = [];
        private var var_4834:Array = [];
        private var var_2731:int = 0;
        private var _height:int = 0;
        private var _minX:int = 0;
        private var var_4835:int = 0;
        private var var_4836:int = 0;
        private var var_4837:int = 0;
        private var var_4628:Array = [];
        private var var_4838:Number = 0;
        private var var_3816:Number = 1;
        private var var_3817:Number = 1;
        private var var_4839:Number = 0;
        private var var_4840:Map = null;
        private var var_4841:Array = [];

        public function RoomPlaneParser()
        {
            this.var_4838 = 3.6;
            this.var_3816 = 1;
            this.var_3817 = 1;
            this.var_4840 = new Map();
        }

        private static function getFloorHeight(param1:Array):Number
        {
            var _loc8_:int;
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:Array;
            var _loc5_:int = param1.length;
            var _loc6_:int;
            if (_loc5_ == 0)
            {
                return (0);
            };
            var _loc7_:Number = 0;
            _loc3_ = 0;
            while (_loc3_ < _loc5_)
            {
                _loc4_ = (param1[_loc3_] as Array);
                _loc2_ = 0;
                while (_loc2_ < _loc4_.length)
                {
                    _loc8_ = Number(_loc4_[_loc2_]);
                    if (_loc8_ > _loc7_)
                    {
                        _loc7_ = _loc8_;
                    };
                    _loc2_++;
                };
                _loc3_++;
            };
            return (_loc7_);
        }

        private static function findEntranceTile(param1:Array):Point
        {
            if (param1 == null)
            {
                return (null);
            };
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:Array;
            var _loc5_:int = param1.length;
            if (_loc5_ == 0)
            {
                return (null);
            };
            var _loc6_:Array = [];
            _loc3_ = 0;
            while (_loc3_ < _loc5_)
            {
                _loc4_ = (param1[_loc3_] as Array);
                if (((_loc4_ == null) || (_loc4_.length == 0)))
                {
                    return (null);
                };
                _loc2_ = 0;
                while (_loc2_ < _loc4_.length)
                {
                    if (Number(_loc4_[_loc2_]) >= 0)
                    {
                        _loc6_.push(_loc2_);
                        break;
                    };
                    _loc2_++;
                };
                if (_loc6_.length < (_loc3_ + 1))
                {
                    _loc6_.push((_loc4_.length + 1));
                };
                _loc3_++;
            };
            _loc3_ = 1;
            while (_loc3_ < (_loc6_.length - 1))
            {
                if (((int(_loc6_[_loc3_]) <= (int(_loc6_[(_loc3_ - 1)]) - 1)) && (int(_loc6_[_loc3_]) <= (int(_loc6_[(_loc3_ + 1)]) - 1))))
                {
                    return (new Point(int(_loc6_[_loc3_]), _loc3_));
                };
                _loc3_++;
            };
            return (null);
        }


        public function get minX():int
        {
            return (this._minX);
        }

        public function get maxX():int
        {
            return (this.var_4835);
        }

        public function get minY():int
        {
            return (this.var_4836);
        }

        public function get maxY():int
        {
            return (this.var_4837);
        }

        public function get tileMapWidth():int
        {
            return (this.var_2731);
        }

        public function get tileMapHeight():int
        {
            return (this._height);
        }

        public function get planeCount():int
        {
            return (this.var_4628.length);
        }

        public function get floorHeight():Number
        {
            return (this.var_4839);
        }

        public function get wallHeight():Number
        {
            return (this.var_4838);
        }

        public function set wallHeight(param1:Number):void
        {
            if (param1 < 0)
            {
                param1 = 0;
            };
            this.var_4838 = param1;
        }

        public function get wallThicknessMultiplier():Number
        {
            return (this.var_3816);
        }

        public function set wallThicknessMultiplier(param1:Number):void
        {
            if (param1 < 0)
            {
                param1 = 0;
            };
            this.var_3816 = param1;
        }

        public function get floorThicknessMultiplier():Number
        {
            return (this.var_3817);
        }

        public function set floorThicknessMultiplier(param1:Number):void
        {
            if (param1 < 0)
            {
                param1 = 0;
            };
            this.var_3817 = param1;
        }

        public function dispose():void
        {
            this.var_4628 = null;
            this.var_4833 = null;
            this.var_4834 = null;
            this.var_4841 = null;
            if (this.var_4840 != null)
            {
                this.var_4840.dispose();
                this.var_4840 = null;
            };
        }

        public function reset():void
        {
            this.var_4628 = [];
            this.var_4833 = [];
            this.var_4834 = [];
            this.var_4833 = [];
            this.var_4834 = [];
            this.var_2731 = 0;
            this._height = 0;
            this._minX = 0;
            this.var_4835 = 0;
            this.var_4836 = 0;
            this.var_4837 = 0;
            this.var_4839 = 0;
            this.var_4841 = [];
        }

        public function initializeTileMap(param1:int, param2:int):Boolean
        {
            var _loc4_:Array;
            var _loc5_:Array;
            var _loc6_:Array;
            var _loc7_:int;
            if (param1 < 0)
            {
                param1 = 0;
            };
            if (param2 < 0)
            {
                param2 = 0;
            };
            this.var_4833 = [];
            this.var_4834 = [];
            this.var_4841 = [];
            var _loc3_:int;
            while (_loc3_ < param2)
            {
                _loc4_ = [];
                _loc5_ = [];
                _loc6_ = [];
                _loc7_ = 0;
                while (_loc7_ < param1)
                {
                    _loc4_[_loc7_] = var_1825;
                    _loc5_[_loc7_] = var_1825;
                    _loc6_[_loc7_] = false;
                    _loc7_++;
                };
                this.var_4833.push(_loc4_);
                this.var_4834.push(_loc5_);
                this.var_4841.push(_loc6_);
                _loc3_++;
            };
            this.var_2731 = param1;
            this._height = param2;
            this._minX = this.var_2731;
            this.var_4835 = -1;
            this.var_4836 = this._height;
            this.var_4837 = -1;
            return (true);
        }

        public function setTileHeight(param1:int, param2:int, param3:Number):Boolean
        {
            var _loc4_:Array;
            var _loc5_:Boolean;
            var _loc6_:int;
            var _loc7_:Boolean;
            var _loc8_:int;
            if (((((param1 >= 0) && (param1 < this.var_2731)) && (param2 >= 0)) && (param2 < this._height)))
            {
                _loc4_ = (this.var_4833[param2] as Array);
                _loc4_[param1] = param3;
                if (param3 >= 0)
                {
                    if (param1 < this._minX)
                    {
                        this._minX = param1;
                    };
                    if (param1 > this.var_4835)
                    {
                        this.var_4835 = param1;
                    };
                    if (param2 < this.var_4836)
                    {
                        this.var_4836 = param2;
                    };
                    if (param2 > this.var_4837)
                    {
                        this.var_4837 = param2;
                    };
                }
                else
                {
                    if (((param1 == this._minX) || (param1 == this.var_4835)))
                    {
                        _loc5_ = false;
                        _loc6_ = this.var_4836;
                        while (_loc6_ < this.var_4837)
                        {
                            if (this.getTileHeightInternal(param1, _loc6_) >= 0)
                            {
                                _loc5_ = true;
                                break;
                            };
                            _loc6_++;
                        };
                        if (!_loc5_)
                        {
                            if (param1 == this._minX)
                            {
                                this._minX++;
                            };
                            if (param1 == this.var_4835)
                            {
                                this.var_4835--;
                            };
                        };
                    };
                    if (((param2 == this.var_4836) || (param2 == this.var_4837)))
                    {
                        _loc7_ = false;
                        _loc8_ = this._minX;
                        while (_loc8_ < this.var_4835)
                        {
                            if (this.getTileHeight(_loc8_, param2) >= 0)
                            {
                                _loc7_ = true;
                                break;
                            };
                            _loc8_++;
                        };
                        if (!_loc7_)
                        {
                            if (param2 == this.var_4836)
                            {
                                this.var_4836++;
                            };
                            if (param2 == this.var_4837)
                            {
                                this.var_4837--;
                            };
                        };
                    };
                };
                return (true);
            };
            return (false);
        }

        public function getTileHeight(param1:int, param2:int):Number
        {
            if (((((param1 < 0) || (param1 >= this.var_2731)) || (param2 < 0)) || (param2 >= this._height)))
            {
                return (var_1825);
            };
            var _loc3_:Array = (this.var_4833[param2] as Array);
            return (Math.abs((_loc3_[param1] as Number)));
        }

        private function getTileHeightOriginal(param1:int, param2:int):Number
        {
            if (((((param1 < 0) || (param1 >= this.var_2731)) || (param2 < 0)) || (param2 >= this._height)))
            {
                return (var_1825);
            };
            if (this.var_4841[param2][param1])
            {
                return (var_1829);
            };
            var _loc3_:Array = (this.var_4834[param2] as Array);
            return (_loc3_[param1] as Number);
        }

        private function getTileHeightInternal(param1:int, param2:int):Number
        {
            if (((((param1 < 0) || (param1 >= this.var_2731)) || (param2 < 0)) || (param2 >= this._height)))
            {
                return (var_1825);
            };
            var _loc3_:Array = (this.var_4833[param2] as Array);
            return (_loc3_[param1] as Number);
        }

        public function initializeFromTileData(param1:Boolean=false):Boolean
        {
            var _loc2_:int;
            var _loc3_:int;
            _loc3_ = 0;
            while (_loc3_ < this._height)
            {
                _loc2_ = 0;
                while (_loc2_ < this.var_2731)
                {
                    this.var_4834[_loc3_][_loc2_] = this.var_4833[_loc3_][_loc2_];
                    _loc2_++;
                };
                _loc3_++;
            };
            var _loc4_:Point = findEntranceTile(this.var_4833);
            _loc3_ = 0;
            while (_loc3_ < this._height)
            {
                _loc2_ = 0;
                while (_loc2_ < this.var_2731)
                {
                    if (this.var_4841[_loc3_][_loc2_])
                    {
                        this.setTileHeight(_loc2_, _loc3_, var_1829);
                    };
                    _loc2_++;
                };
                _loc3_++;
            };
            return (this.initialize(_loc4_, param1));
        }

        private function initialize(param1:Point, param2:Boolean):Boolean
        {
            var _loc7_:Array;
            var _loc8_:int;
            var _loc3_:int;
            if (param1 != null)
            {
                _loc3_ = this.getTileHeight(param1.x, param1.y);
                this.setTileHeight(param1.x, param1.y, var_1825);
            };
            this.var_4839 = getFloorHeight(this.var_4833);
            if (!param2)
            {
                this.createWallPlanes();
            };
            var _loc4_:Array;
            var _loc5_:Array = [];
            var _loc6_:int;
            while (_loc6_ < this.var_4833.length)
            {
                _loc4_ = this.var_4833[_loc6_];
                _loc7_ = [];
                _loc8_ = 0;
                while (_loc8_ < _loc4_.length)
                {
                    _loc7_.push(_loc4_[_loc8_]);
                    _loc8_++;
                };
                _loc5_.push(_loc7_);
                _loc6_++;
            };
            do 
            {
            } while (this.extractFloorPlane(_loc5_, true));
            if (param1 != null)
            {
                this.setTileHeight(param1.x, param1.y, _loc3_);
                _loc4_ = _loc5_[param1.y];
                _loc4_[param1.x] = _loc3_;
                this.extractFloorPlane(_loc5_, false);
            };
            return (true);
        }

        private function generateWallData(param1:Point, param2:Boolean):RoomWallData
        {
            var _loc8_:Boolean;
            var _loc9_:Boolean;
            var _loc10_:int;
            var _loc11_:Point;
            var _loc12_:int;
            var _loc3_:RoomWallData = new RoomWallData();
            var _loc4_:Array = [this.extractTopWall, this.extractRightWall, this.extractBottomWall, this.extractLeftWall];
            var _loc5_:int;
            var _loc6_:Point = new Point(param1.x, param1.y);
            var _loc7_:int;
            while (_loc7_++ < 1000)
            {
                _loc8_ = false;
                _loc9_ = false;
                _loc10_ = _loc5_;
                if (((((_loc6_.x < this.minX) || (_loc6_.x > this.maxX)) || (_loc6_.y < this.minY)) || (_loc6_.y > this.maxY)))
                {
                    _loc8_ = true;
                };
                _loc11_ = _loc4_[_loc5_](_loc6_, param2);
                if (_loc11_ == null)
                {
                    return (null);
                };
                _loc12_ = (Math.abs((_loc11_.x - _loc6_.x)) + Math.abs((_loc11_.y - _loc6_.y)));
                if (((_loc6_.x == _loc11_.x) || (_loc6_.y == _loc11_.y)))
                {
                    _loc5_ = (((_loc5_ - 1) + _loc4_.length) % _loc4_.length);
                    _loc12_ = (_loc12_ + 1);
                    _loc9_ = true;
                }
                else
                {
                    _loc5_ = ((_loc5_ + 1) % _loc4_.length);
                    _loc12_--;
                };
                _loc3_.addWall(_loc6_, _loc10_, _loc12_, _loc8_, _loc9_);
                if ((((_loc11_.x == param1.x) && (_loc11_.y == param1.y)) && ((!(_loc11_.x == _loc6_.x)) || (!(_loc11_.y == _loc6_.y))))) break;
                _loc6_ = _loc11_;
            };
            if (_loc3_.count == 0)
            {
                return (null);
            };
            return (_loc3_);
        }

        private function hidePeninsulaWallChains(param1:RoomWallData):void
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:Boolean;
            var _loc8_:int;
            var _loc2_:int;
            var _loc3_:int = param1.count;
            while (_loc2_ < _loc3_)
            {
                _loc4_ = _loc2_;
                _loc5_ = _loc2_;
                _loc6_ = 0;
                _loc7_ = false;
                while (((!(param1.getBorder(_loc2_))) && (_loc2_ < _loc3_)))
                {
                    if (param1.getLeftTurn(_loc2_))
                    {
                        _loc6_++;
                    }
                    else
                    {
                        if (_loc6_ > 0)
                        {
                            _loc6_--;
                        };
                    };
                    if (_loc6_ > 1)
                    {
                        _loc7_ = true;
                    };
                    _loc5_ = _loc2_;
                    _loc2_++;
                };
                if (_loc7_)
                {
                    _loc8_ = _loc4_;
                    while (_loc8_ <= _loc5_)
                    {
                        param1.setHideWall(_loc8_, true);
                        _loc8_++;
                    };
                };
                _loc2_++;
            };
        }

        private function updateWallsNextToHoles(param1:RoomWallData):void
        {
            var _loc4_:Point;
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:IVector3d;
            var _loc8_:IVector3d;
            var _loc9_:int;
            var _loc10_:int;
            var _loc2_:int = param1.count;
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                if (!param1.getHideWall(_loc3_))
                {
                    _loc4_ = param1.getCorner(_loc3_);
                    _loc5_ = param1.getDirection(_loc3_);
                    _loc6_ = param1.getLength(_loc3_);
                    _loc7_ = RoomWallData.var_1830[_loc5_];
                    _loc8_ = RoomWallData.var_1831[_loc5_];
                    _loc9_ = 0;
                    _loc10_ = 0;
                    while (_loc10_ < _loc6_)
                    {
                        if (this.getTileHeightInternal(((_loc4_.x + (_loc10_ * _loc7_.x)) - _loc8_.x), ((_loc4_.y + (_loc10_ * _loc7_.y)) - _loc8_.y)) == var_1829)
                        {
                            if (((_loc10_ > 0) && (_loc9_ == 0)))
                            {
                                param1.setLength(_loc3_, _loc10_);
                                break;
                            };
                            _loc9_++;
                        }
                        else
                        {
                            if (_loc9_ > 0)
                            {
                                param1.moveCorner(_loc3_, _loc9_);
                                break;
                            };
                        };
                        _loc10_++;
                    };
                    if (_loc9_ == _loc6_)
                    {
                        param1.setHideWall(_loc3_, true);
                    };
                };
                _loc3_++;
            };
        }

        private function resolveOriginalWallIndex(param1:Point, param2:Point, param3:RoomWallData):int
        {
            var _loc10_:Point;
            var _loc11_:Point;
            var _loc12_:int;
            var _loc13_:int;
            var _loc14_:int;
            var _loc15_:int;
            var _loc4_:int = Math.min(param1.y, param2.y);
            var _loc5_:int = Math.max(param1.y, param2.y);
            var _loc6_:int = Math.min(param1.x, param2.x);
            var _loc7_:int = Math.max(param1.x, param2.x);
            var _loc8_:int = param3.count;
            var _loc9_:int;
            while (_loc9_ < _loc8_)
            {
                _loc10_ = param3.getCorner(_loc9_);
                _loc11_ = param3.getEndPoint(_loc9_);
                if (param1.x == param2.x)
                {
                    if (((_loc10_.x == param1.x) && (_loc11_.x == param1.x)))
                    {
                        _loc12_ = Math.min(_loc10_.y, _loc11_.y);
                        _loc13_ = Math.max(_loc10_.y, _loc11_.y);
                        if (((_loc12_ <= _loc4_) && (_loc5_ <= _loc13_)))
                        {
                            return (_loc9_);
                        };
                    };
                }
                else
                {
                    if (param1.y == param2.y)
                    {
                        if (((_loc10_.y == param1.y) && (_loc11_.y == param1.y)))
                        {
                            _loc14_ = Math.min(_loc10_.x, _loc11_.x);
                            _loc15_ = Math.max(_loc10_.x, _loc11_.x);
                            if (((_loc14_ <= _loc6_) && (_loc7_ <= _loc15_)))
                            {
                                return (_loc9_);
                            };
                        };
                    };
                };
                _loc9_++;
            };
            return (-1);
        }

        private function hideOriginallyHiddenWalls(param1:RoomWallData, param2:RoomWallData):void
        {
            var _loc5_:Point;
            var _loc6_:Point;
            var _loc7_:IVector3d;
            var _loc8_:int;
            var _loc9_:int;
            var _loc3_:int = param1.count;
            var _loc4_:int;
            while (_loc4_ < _loc3_)
            {
                if (!param1.getHideWall(_loc4_))
                {
                    _loc5_ = param1.getCorner(_loc4_);
                    _loc6_ = new Point(_loc5_.x, _loc5_.y);
                    _loc7_ = RoomWallData.var_1830[param1.getDirection(_loc4_)];
                    _loc8_ = param1.getLength(_loc4_);
                    _loc6_.x = (_loc6_.x + (_loc7_.x * _loc8_));
                    _loc6_.y = (_loc6_.y + (_loc7_.y * _loc8_));
                    _loc9_ = this.resolveOriginalWallIndex(_loc5_, _loc6_, param2);
                    if (_loc9_ >= 0)
                    {
                        if (param2.getHideWall(_loc9_))
                        {
                            param1.setHideWall(_loc4_, true);
                        };
                    };
                };
                _loc4_++;
            };
        }

        private function checkWallHiding(param1:RoomWallData, param2:RoomWallData):void
        {
            this.hidePeninsulaWallChains(param2);
            this.updateWallsNextToHoles(param1);
            this.hideOriginallyHiddenWalls(param1, param2);
        }

        private function addWalls(param1:RoomWallData, param2:RoomWallData):void
        {
            var _loc5_:int;
            var _loc6_:int;
            var _loc8_:Point;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:IVector3d;
            var _loc12_:IVector3d;
            var _loc13_:Number;
            var _loc14_:int;
            var _loc15_:Number;
            var _loc16_:Vector3d;
            var _loc17_:Number;
            var _loc18_:Vector3d;
            var _loc19_:Vector3d;
            var _loc20_:int;
            var _loc21_:Vector3d;
            var _loc22_:Boolean;
            var _loc23_:Boolean;
            var _loc24_:Boolean;
            var _loc25_:Boolean;
            var _loc26_:Boolean;
            var _loc27_:Number;
            var _loc3_:int = param1.count;
            var _loc4_:int = param2.count;
            var _loc7_:int;
            while (_loc7_ < _loc3_)
            {
                if (!param1.getHideWall(_loc7_))
                {
                    _loc8_ = param1.getCorner(_loc7_);
                    _loc9_ = param1.getDirection(_loc7_);
                    _loc10_ = param1.getLength(_loc7_);
                    _loc11_ = RoomWallData.var_1830[_loc9_];
                    _loc12_ = RoomWallData.var_1831[_loc9_];
                    _loc13_ = -1;
                    _loc14_ = 0;
                    while (_loc14_ < _loc10_)
                    {
                        _loc27_ = this.getTileHeightInternal(((_loc8_.x + (_loc14_ * _loc11_.x)) + _loc12_.x), ((_loc8_.y + (_loc14_ * _loc11_.y)) + _loc12_.y));
                        if (((_loc27_ >= 0) && ((_loc27_ < _loc13_) || (_loc13_ < 0))))
                        {
                            _loc13_ = _loc27_;
                        };
                        _loc14_++;
                    };
                    _loc15_ = _loc13_;
                    _loc16_ = new Vector3d(_loc8_.x, _loc8_.y, _loc15_);
                    _loc16_ = Vector3d.sum(_loc16_, Vector3d.product(_loc12_, 0.5));
                    _loc16_ = Vector3d.sum(_loc16_, Vector3d.product(_loc11_, -0.5));
                    _loc17_ = ((this.wallHeight + this.floorHeight) - _loc13_);
                    _loc18_ = Vector3d.product(_loc11_, -(_loc10_));
                    _loc19_ = new Vector3d(0, 0, _loc17_);
                    _loc16_ = Vector3d.dif(_loc16_, _loc18_);
                    _loc20_ = this.resolveOriginalWallIndex(_loc8_, param1.getEndPoint(_loc7_), param2);
                    if (_loc20_ >= 0)
                    {
                        _loc5_ = param2.getDirection(((_loc20_ + 1) % _loc4_));
                        _loc6_ = param2.getDirection((((_loc20_ - 1) + _loc4_) % _loc4_));
                    }
                    else
                    {
                        _loc5_ = param1.getDirection(((_loc7_ + 1) % _loc3_));
                        _loc6_ = param1.getDirection((((_loc7_ - 1) + _loc3_) % _loc3_));
                    };
                    _loc21_ = null;
                    if ((((_loc5_ - _loc9_) + 4) % 4) == 3)
                    {
                        _loc21_ = RoomWallData.var_1831[_loc5_];
                    }
                    else
                    {
                        if ((((_loc9_ - _loc6_) + 4) % 4) == 3)
                        {
                            _loc21_ = RoomWallData.var_1831[_loc6_];
                        };
                    };
                    _loc22_ = param1.getLeftTurn(_loc7_);
                    _loc23_ = param1.getLeftTurn((((_loc7_ - 1) + _loc3_) % _loc3_));
                    _loc24_ = param1.getHideWall(((_loc7_ + 1) % _loc3_));
                    _loc25_ = param1.getManuallyLeftCut(_loc7_);
                    _loc26_ = param1.getManuallyRightCut(_loc7_);
                    this.addWall(_loc16_, _loc18_, _loc19_, _loc21_, ((!(_loc23_)) || (_loc25_)), ((!(_loc22_)) || (_loc26_)), (!(_loc24_)));
                };
                _loc7_++;
            };
        }

        private function createWallPlanes():Boolean
        {
            var _loc13_:int;
            var _loc14_:int;
            var _loc1_:Array = this.var_4833;
            if (_loc1_ == null)
            {
                return (false);
            };
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:Array;
            var _loc5_:int = _loc1_.length;
            var _loc6_:int;
            if (_loc5_ == 0)
            {
                return (false);
            };
            _loc2_ = 0;
            while (_loc2_ < _loc5_)
            {
                _loc4_ = (_loc1_[_loc2_] as Array);
                if (((_loc4_ == null) || (_loc4_.length == 0)))
                {
                    return (false);
                };
                if (_loc6_ > 0)
                {
                    _loc6_ = Math.min(_loc6_, _loc4_.length);
                }
                else
                {
                    _loc6_ = _loc4_.length;
                };
                _loc2_++;
            };
            var _loc7_:Number = getFloorHeight(_loc1_);
            var _loc8_:int = this.minX;
            var _loc9_:int = this.minY;
            _loc9_ = this.minY;
            while (_loc9_ <= this.maxY)
            {
                if (this.getTileHeightInternal(_loc8_, _loc9_) > var_1829)
                {
                    _loc9_--;
                    break;
                };
                _loc9_++;
            };
            if (_loc9_ > this.maxY)
            {
                return (false);
            };
            var _loc10_:Point = new Point(_loc8_, _loc9_);
            var _loc11_:RoomWallData = this.generateWallData(_loc10_, true);
            var _loc12_:RoomWallData = this.generateWallData(_loc10_, false);
            if (_loc11_ != null)
            {
                _loc13_ = _loc11_.count;
                _loc14_ = _loc12_.count;
                this.checkWallHiding(_loc11_, _loc12_);
                this.addWalls(_loc11_, _loc12_);
            };
            _loc3_ = 0;
            while (_loc3_ < this.tileMapHeight)
            {
                _loc2_ = 0;
                while (_loc2_ < this.tileMapWidth)
                {
                    if (this.getTileHeightInternal(_loc2_, _loc3_) < 0)
                    {
                        this.setTileHeight(_loc2_, _loc3_, -(_loc7_ + this.wallHeight));
                    };
                    _loc2_++;
                };
                _loc3_++;
            };
            return (true);
        }

        private function extractTopWall(param1:Point, param2:Boolean):Point
        {
            if (param1 == null)
            {
                return (null);
            };
            var _loc3_:int = 1;
            var _loc4_:int = var_1829;
            if (!param2)
            {
                _loc4_ = var_1825;
            };
            while (_loc3_ < 1000)
            {
                if (this.getTileHeightInternal((param1.x + _loc3_), param1.y) > _loc4_)
                {
                    return (new Point(((param1.x + _loc3_) - 1), param1.y));
                };
                if (this.getTileHeightInternal((param1.x + _loc3_), (param1.y + 1)) <= _loc4_)
                {
                    return (new Point((param1.x + _loc3_), (param1.y + 1)));
                };
                _loc3_++;
            };
            return (null);
        }

        private function extractRightWall(param1:Point, param2:Boolean):Point
        {
            if (param1 == null)
            {
                return (null);
            };
            var _loc3_:int = 1;
            var _loc4_:int = var_1829;
            if (!param2)
            {
                _loc4_ = var_1825;
            };
            while (_loc3_ < 1000)
            {
                if (this.getTileHeightInternal(param1.x, (param1.y + _loc3_)) > _loc4_)
                {
                    return (new Point(param1.x, (param1.y + (_loc3_ - 1))));
                };
                if (this.getTileHeightInternal((param1.x - 1), (param1.y + _loc3_)) <= _loc4_)
                {
                    return (new Point((param1.x - 1), (param1.y + _loc3_)));
                };
                _loc3_++;
            };
            return (null);
        }

        private function extractBottomWall(param1:Point, param2:Boolean):Point
        {
            if (param1 == null)
            {
                return (null);
            };
            var _loc3_:int = 1;
            var _loc4_:int = var_1829;
            if (!param2)
            {
                _loc4_ = var_1825;
            };
            while (_loc3_ < 1000)
            {
                if (this.getTileHeightInternal((param1.x - _loc3_), param1.y) > _loc4_)
                {
                    return (new Point((param1.x - (_loc3_ - 1)), param1.y));
                };
                if (this.getTileHeightInternal((param1.x - _loc3_), (param1.y - 1)) <= _loc4_)
                {
                    return (new Point((param1.x - _loc3_), (param1.y - 1)));
                };
                _loc3_++;
            };
            return (null);
        }

        private function extractLeftWall(param1:Point, param2:Boolean):Point
        {
            if (param1 == null)
            {
                return (null);
            };
            var _loc3_:int = 1;
            var _loc4_:int = var_1829;
            if (!param2)
            {
                _loc4_ = var_1825;
            };
            while (_loc3_ < 1000)
            {
                if (this.getTileHeightInternal(param1.x, (param1.y - _loc3_)) > _loc4_)
                {
                    return (new Point(param1.x, (param1.y - (_loc3_ - 1))));
                };
                if (this.getTileHeightInternal((param1.x + 1), (param1.y - _loc3_)) <= _loc4_)
                {
                    return (new Point((param1.x + 1), (param1.y - _loc3_)));
                };
                _loc3_++;
            };
            return (null);
        }

        private function addWall(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:Boolean, param6:Boolean, param7:Boolean):void
        {
            var _loc12_:Vector3d;
            this.addPlane(RoomPlaneData.var_1066, param1, param2, param3, [param4]);
            this.addPlane(RoomPlaneData.var_1067, param1, param2, param3, [param4]);
            var _loc8_:Number = (var_491 * this.var_3816);
            var _loc9_:Number = (var_492 * this.var_3817);
            var _loc10_:Vector3d = Vector3d.crossProduct(param2, param3);
            var _loc11_:Vector3d = Vector3d.product(_loc10_, ((1 / _loc10_.length) * -(_loc8_)));
            this.addPlane(RoomPlaneData.var_1066, Vector3d.sum(param1, param3), param2, _loc11_, [_loc10_, param4]);
            if (param5)
            {
                this.addPlane(RoomPlaneData.var_1066, Vector3d.sum(Vector3d.sum(param1, param2), param3), Vector3d.product(param3, (-(param3.length + _loc9_) / param3.length)), _loc11_, [_loc10_, param4]);
            };
            if (param6)
            {
                this.addPlane(RoomPlaneData.var_1066, Vector3d.sum(param1, Vector3d.product(param3, (-(_loc9_) / param3.length))), Vector3d.product(param3, ((param3.length + _loc9_) / param3.length)), _loc11_, [_loc10_, param4]);
                if (param7)
                {
                    _loc12_ = Vector3d.product(param2, (_loc8_ / param2.length));
                    this.addPlane(RoomPlaneData.var_1066, Vector3d.sum(Vector3d.sum(param1, param3), Vector3d.product(_loc12_, -1)), _loc12_, _loc11_, [_loc10_, param2, param4]);
                };
            };
        }

        private function findFloorRectangle(param1:Array, param2:int, param3:int):RoomFloorRectangle
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:Array;
            var _loc7_:Array;
            var _loc8_:int;
            var _loc9_:int = param2;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:Number = -1;
            var _loc13_:Number = 0;
            _loc5_ = 0;
            while (_loc5_ < param3)
            {
                _loc6_ = (param1[_loc5_] as Array);
                _loc7_ = (param1[_loc10_] as Array);
                if (_loc12_ >= 0)
                {
                    if (((_loc8_ > 0) && (!(Number(_loc6_[(_loc8_ - 1)]) == Number(_loc7_[(_loc8_ - 1)])))))
                    {
                        _loc11_ = _loc5_;
                        break;
                    };
                    if (((_loc9_ < param2) && (!(_loc6_[_loc9_] == Number(_loc7_[_loc9_])))))
                    {
                        _loc11_ = _loc5_;
                        break;
                    };
                };
                _loc4_ = _loc8_;
                while (_loc4_ < _loc9_)
                {
                    _loc13_ = Number(_loc6_[_loc4_]);
                    if (_loc13_ >= 0)
                    {
                        if (_loc12_ < 0)
                        {
                            _loc10_ = _loc5_;
                            _loc8_ = _loc4_;
                            _loc12_ = _loc13_;
                        }
                        else
                        {
                            if (_loc13_ != _loc12_)
                            {
                                if (_loc5_ > _loc10_)
                                {
                                    _loc11_ = _loc5_;
                                    _loc5_ = param3;
                                    break;
                                };
                                _loc9_ = _loc4_;
                            };
                        };
                    }
                    else
                    {
                        if (_loc12_ >= 0)
                        {
                            if (_loc5_ == _loc10_)
                            {
                                _loc9_ = _loc4_;
                            }
                            else
                            {
                                if (_loc4_ < _loc9_)
                                {
                                    _loc11_ = _loc5_;
                                    _loc5_ = param3;
                                    break;
                                };
                            };
                        };
                    };
                    _loc11_ = (_loc5_ + 1);
                    _loc4_++;
                };
                _loc5_++;
            };
            if (_loc12_ < 0)
            {
                return (null);
            };
            if ((_loc9_ - _loc8_) < 1)
            {
                return (null);
            };
            if ((_loc11_ - _loc10_) < 1)
            {
                return (null);
            };
            if (_loc10_ > 0)
            {
                _loc7_ = param1[(_loc10_ - 1)];
            }
            else
            {
                _loc7_ = null;
            };
            _loc6_ = param1[_loc11_];
            _loc4_ = (_loc8_ + 1);
            while (_loc4_ < _loc9_)
            {
                if ((((!(_loc6_ == null)) && (!((_loc6_[_loc4_] >= -1) == (_loc6_[_loc8_] >= -1)))) || ((!(_loc7_ == null)) && (!((_loc7_[_loc4_] >= -1) == (_loc7_[_loc8_] >= -1))))))
                {
                    _loc9_ = _loc4_;
                    break;
                };
                _loc4_++;
            };
            _loc7_ = param1[_loc10_];
            _loc4_ = (_loc10_ + 1);
            while (_loc4_ < _loc11_)
            {
                _loc6_ = param1[_loc4_];
                if ((((_loc8_ > 0) && (!((_loc6_[(_loc8_ - 1)] >= -1) == (_loc7_[(_loc8_ - 1)] >= -1)))) || ((_loc9_ < param2) && (!((_loc6_[_loc9_] >= -1) == (_loc7_[_loc9_] >= -1))))))
                {
                    _loc11_ = _loc4_;
                    break;
                };
                _loc4_++;
            };
            return (new RoomFloorRectangle(_loc8_, _loc10_, _loc9_, _loc11_, _loc12_));
        }

        private function getHeightMapWidth(param1:Array):int
        {
            var _loc2_:int = param1.length;
            if (_loc2_ == 0)
            {
                return (0);
            };
            var _loc3_:Array;
            var _loc4_:Array;
            var _loc5_:int;
            var _loc6_:int;
            while (_loc6_ < _loc2_)
            {
                _loc3_ = (param1[_loc6_] as Array);
                _loc4_ = (this.var_4833[_loc6_] as Array);
                if (((_loc3_ == null) || (_loc3_.length == 0)))
                {
                    return (0);
                };
                if (((_loc4_ == null) || (_loc4_.length == 0)))
                {
                    return (0);
                };
                if (_loc3_.length != _loc4_.length)
                {
                    return (0);
                };
                if (_loc5_ > 0)
                {
                    if (_loc3_.length < _loc5_)
                    {
                        _loc5_ = _loc3_.length;
                    };
                }
                else
                {
                    _loc5_ = _loc3_.length;
                };
                _loc6_++;
            };
            return (_loc5_);
        }

        private function getHorizontalStairInfo(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:Number):RoomStairData
        {
            var _loc15_:int;
            var _loc8_:int = 1;
            var _loc9_:Boolean;
            var _loc10_:Boolean;
            var _loc11_:Boolean;
            if (param4 < 0)
            {
                _loc8_ = 0;
            };
            if (param4 > (param6 - 1))
            {
                _loc8_ = 0;
            };
            var _loc12_:int = param1;
            while (_loc12_ < param2)
            {
                if (_loc8_)
                {
                    _loc15_ = Math.abs((this.getTileHeightInternal(_loc12_, param4) - this.getTileHeightInternal(_loc12_, param3)));
                    if (_loc15_ != 1)
                    {
                        _loc8_ = 0;
                    }
                    else
                    {
                        _loc8_ = (this.getTileHeightInternal(_loc12_, param4) - this.getTileHeightInternal(_loc12_, param3));
                    };
                };
                if (((!(_loc9_)) && (this.getTileHeightInternal(_loc12_, param4) < param7)))
                {
                    _loc9_ = true;
                };
                _loc12_++;
            };
            var _loc13_:int = (param1 - 1);
            var _loc14_:int = (param2 + 1);
            _loc12_ = (param1 - 1);
            while (_loc12_ >= _loc13_)
            {
                _loc15_ = Math.abs((this.getTileHeightOriginal(_loc12_, param4) - this.getTileHeightOriginal(_loc12_, param3)));
                if (_loc15_ == 1)
                {
                    _loc10_ = true;
                };
                _loc12_--;
            };
            _loc12_ = param2;
            while (_loc12_ < _loc14_)
            {
                _loc15_ = Math.abs((this.getTileHeightOriginal(_loc12_, param4) - this.getTileHeightOriginal(_loc12_, param3)));
                if (_loc15_ == 1)
                {
                    _loc11_ = true;
                };
                _loc12_++;
            };
            return (new RoomStairData(_loc8_, _loc10_, _loc11_, _loc9_));
        }

        private function getVerticalStairInfo(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:Number):RoomStairData
        {
            var _loc15_:int;
            var _loc8_:int = 1;
            var _loc9_:Boolean;
            var _loc10_:Boolean;
            var _loc11_:Boolean;
            if (param4 < 0)
            {
                _loc8_ = 0;
            };
            if (param4 > (param5 - 2))
            {
                _loc8_ = 0;
            };
            var _loc12_:int = param1;
            while (_loc12_ < param2)
            {
                if (_loc8_)
                {
                    _loc15_ = Math.abs((this.getTileHeightInternal(param4, _loc12_) - this.getTileHeightInternal(param3, _loc12_)));
                    if (_loc15_ != 1)
                    {
                        _loc8_ = 0;
                    }
                    else
                    {
                        _loc8_ = (this.getTileHeightInternal(param4, _loc12_) - this.getTileHeightInternal(param3, _loc12_));
                    };
                };
                if (((!(_loc9_)) && (this.getTileHeightInternal(param4, _loc12_) < param7)))
                {
                    _loc9_ = true;
                };
                _loc12_++;
            };
            var _loc13_:int = (param1 - 1);
            var _loc14_:int = (param2 + 1);
            _loc12_ = (param1 - 1);
            while (_loc12_ >= _loc13_)
            {
                _loc15_ = Math.abs((this.getTileHeightOriginal(param4, _loc12_) - this.getTileHeightOriginal(param3, _loc12_)));
                if (_loc15_ == 1)
                {
                    _loc10_ = true;
                };
                _loc12_--;
            };
            _loc12_ = param2;
            while (_loc12_ < _loc14_)
            {
                _loc15_ = Math.abs((this.getTileHeightOriginal(param4, _loc12_) - this.getTileHeightOriginal(param3, _loc12_)));
                if (_loc15_ == 1)
                {
                    _loc11_ = true;
                };
                _loc12_++;
            };
            return (new RoomStairData(_loc8_, _loc10_, _loc11_, _loc9_));
        }

        private function extractFloorPlane(param1:Array, param2:Boolean):Boolean
        {
            var _loc18_:Boolean;
            var _loc19_:Boolean;
            var _loc20_:Boolean;
            var _loc21_:Boolean;
            if ((((param1 == null) || (this.var_4833 == null)) || (param1 == this.var_4833)))
            {
                return (false);
            };
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:Array;
            if (param1.length > this.var_4833.length)
            {
                return (false);
            };
            var _loc6_:int = param1.length;
            if (_loc6_ == 0)
            {
                return (false);
            };
            var _loc7_:int = this.getHeightMapWidth(param1);
            if (_loc7_ == 0)
            {
                return (false);
            };
            var _loc8_:RoomFloorRectangle = this.findFloorRectangle(param1, _loc7_, _loc6_);
            if (_loc8_ == null)
            {
                return (false);
            };
            var _loc9_:Number = (_loc8_.right - _loc8_.left);
            var _loc10_:Number = (_loc8_.bottom - _loc8_.top);
            var _loc11_:Number = _loc8_.altitude;
            var _loc12_:Number = (_loc8_.left - 0.5);
            var _loc13_:Number = (_loc8_.top - 0.5);
            var _loc14_:RoomStairData = this.getHorizontalStairInfo(_loc8_.left, _loc8_.right, _loc8_.top, (_loc8_.top - 1), _loc7_, _loc6_, _loc11_);
            var _loc15_:RoomStairData = this.getHorizontalStairInfo(_loc8_.left, _loc8_.right, (_loc8_.bottom - 1), _loc8_.bottom, _loc7_, _loc6_, _loc11_);
            var _loc16_:RoomStairData = this.getVerticalStairInfo(_loc8_.top, _loc8_.bottom, _loc8_.left, (_loc8_.left - 1), _loc7_, _loc6_, _loc11_);
            var _loc17_:RoomStairData = this.getVerticalStairInfo(_loc8_.top, _loc8_.bottom, (_loc8_.right - 1), _loc8_.right, _loc7_, _loc6_, _loc11_);
            if (_loc14_.stairHeight)
            {
                if (_loc14_.stairHeight > 0)
                {
                    _loc18_ = false;
                    _loc19_ = true;
                }
                else
                {
                    _loc18_ = true;
                    _loc19_ = false;
                };
                this.addFloor(new Vector3d((_loc12_ + _loc9_), (_loc13_ + 0.34), (_loc11_ + ((_loc14_.stairHeight / 4) * 2))), new Vector3d(-(_loc9_), 0, 0), new Vector3d(0, -0.34, 0), ((_loc17_.border) || (!(_loc14_.neighbourStairMax))), ((_loc16_.border) || (!(_loc14_.neighbourStairMin))), _loc19_, _loc18_, 0, 0, 0, 0, false, true);
                this.addFloor(new Vector3d((_loc12_ + _loc9_), (_loc13_ + 0.67), (_loc11_ + (_loc14_.stairHeight / 4))), new Vector3d(-(_loc9_), 0, 0), new Vector3d(0, -0.33, 0), ((_loc17_.border) || (!(_loc14_.neighbourStairMax))), ((_loc16_.border) || (!(_loc14_.neighbourStairMin))), _loc19_, _loc18_, 0, 0, 0, 0, false, true);
            };
            if (_loc15_.stairHeight)
            {
                if (_loc15_.stairHeight < 0)
                {
                    _loc18_ = false;
                    _loc19_ = true;
                }
                else
                {
                    _loc18_ = true;
                    _loc19_ = false;
                };
                this.addFloor(new Vector3d((_loc12_ + _loc9_), (_loc13_ + _loc10_), (_loc11_ + (_loc15_.stairHeight / 4))), new Vector3d(-(_loc9_), 0, 0), new Vector3d(0, -0.33, 0), ((_loc17_.border) || (!(_loc15_.neighbourStairMax))), ((_loc16_.border) || (!(_loc15_.neighbourStairMin))), _loc19_, _loc18_, 0, 0, 0, 0, false, true);
            };
            if (_loc16_.stairHeight)
            {
                if (_loc16_.stairHeight > 0)
                {
                    _loc20_ = false;
                    _loc21_ = true;
                }
                else
                {
                    _loc20_ = true;
                    _loc21_ = false;
                };
                this.addFloor(new Vector3d((_loc12_ + 0.34), (_loc13_ + _loc10_), (_loc11_ + ((_loc16_.stairHeight / 4) * 2))), new Vector3d(-0.34, 0, 0), new Vector3d(0, -(_loc10_), 0), _loc21_, _loc20_, ((_loc15_.border) || (!(_loc16_.neighbourStairMax))), ((_loc14_.border) || (!(_loc16_.neighbourStairMin))), 0, 0, 0, 0, true, false);
                this.addFloor(new Vector3d((_loc12_ + 0.67), (_loc13_ + _loc10_), (_loc11_ + (_loc16_.stairHeight / 4))), new Vector3d(-0.33, 0, 0), new Vector3d(0, -(_loc10_), 0), _loc21_, _loc20_, ((_loc15_.border) || (!(_loc16_.neighbourStairMax))), ((_loc14_.border) || (!(_loc16_.neighbourStairMin))), 0, 0, 0, 0, true, false);
            };
            if (_loc17_.stairHeight)
            {
                if (_loc17_.stairHeight < 0)
                {
                    _loc20_ = false;
                    _loc21_ = true;
                }
                else
                {
                    _loc20_ = true;
                    _loc21_ = false;
                };
                this.addFloor(new Vector3d((_loc12_ + _loc9_), (_loc13_ + _loc10_), (_loc11_ + (_loc17_.stairHeight / 4))), new Vector3d(-0.33, 0, 0), new Vector3d(0, -(_loc10_), 0), _loc21_, _loc20_, ((_loc15_.border) || (!(_loc17_.neighbourStairMax))), ((_loc14_.border) || (!(_loc17_.neighbourStairMin))), 0, 0, 0, 0, true, false);
            };
            _loc4_ = _loc8_.top;
            while (_loc4_ < _loc8_.bottom)
            {
                _loc5_ = param1[_loc4_];
                _loc3_ = _loc8_.left;
                while (_loc3_ < _loc8_.right)
                {
                    _loc5_[_loc3_] = -1;
                    _loc3_++;
                };
                _loc4_++;
            };
            var _loc22_:Number = 0;
            var _loc23_:Number = 0;
            var _loc24_:Number = 0;
            var _loc25_:Number = 0;
            if (((_loc16_.stairHeight) || (_loc16_.neighbourStair)))
            {
                _loc23_ = 0.65;
            };
            if (((_loc17_.stairHeight) || (_loc17_.neighbourStair)))
            {
                _loc22_ = 0.3;
            };
            if (((_loc14_.stairHeight) || (_loc14_.neighbourStair)))
            {
                _loc25_ = 0.65;
            };
            if (((_loc15_.stairHeight) || (_loc15_.neighbourStair)))
            {
                _loc24_ = 0.3;
            };
            this.addFloor(new Vector3d((_loc12_ + _loc9_), (_loc13_ + _loc10_), _loc11_), new Vector3d(-(_loc9_), 0, 0), new Vector3d(0, -(_loc10_), 0), ((_loc17_.border) && (param2)), ((_loc16_.border) && (param2)), ((_loc15_.border) && (param2)), ((_loc14_.border) && (param2)), _loc22_, _loc23_, _loc24_, _loc25_, false, false);
            return (true);
        }

        private function addFloor(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Number, param9:Number, param10:Number, param11:Number, param12:Boolean, param13:Boolean):void
        {
            var _loc18_:Number;
            var _loc19_:Number;
            var _loc20_:Number;
            var _loc14_:RoomPlaneData = this.addPlane(RoomPlaneData.var_1065, param1, param2, param3);
            var _loc15_:IVector3d = param1;
            var _loc16_:RoomPlaneData;
            var _loc17_:RoomPlaneData;
            if (_loc14_)
            {
                _loc18_ = (var_492 * this.var_3817);
                _loc19_ = _loc18_;
                if (this.var_3817 > 1)
                {
                    _loc19_ = var_492;
                };
                if (param8 > 0)
                {
                    _loc14_.addMask(0, 0, (param8 - 0.02), param3.length);
                };
                if (param9 > 0)
                {
                    _loc14_.addMask((param2.length - param9), 0, param9, param3.length);
                };
                if (param10 > 0)
                {
                    _loc14_.addMask(0, 0, param2.length, (param10 - 0.02));
                };
                if (param11 > 0)
                {
                    _loc14_.addMask(0, (param3.length - param11), param2.length, param11);
                };
                if (param6)
                {
                    if (((param10 > 0) || (param13)))
                    {
                        _loc15_ = Vector3d.sum(param1, Vector3d.product(param3, (param10 / param3.length)));
                        _loc20_ = _loc19_;
                    }
                    else
                    {
                        _loc15_ = param1;
                        _loc20_ = _loc18_;
                    };
                    _loc16_ = this.addPlane(RoomPlaneData.var_1065, _loc15_, new Vector3d(0, 0, -(_loc20_)), param2);
                    if (_loc16_ != null)
                    {
                        if (param8 > 0)
                        {
                            _loc16_.addMask(0, 0, _loc18_, param8);
                        };
                        if (param9 > 0)
                        {
                            _loc16_.addMask(0, (param2.length - param9), _loc18_, param9);
                        };
                    };
                };
                if (param7)
                {
                    if (((param11 > 0) || (param13)))
                    {
                        _loc15_ = Vector3d.sum(param1, Vector3d.sum(param2, Vector3d.product(param3, (1 - (param11 / param3.length)))));
                        _loc20_ = _loc19_;
                    }
                    else
                    {
                        _loc15_ = Vector3d.sum(param1, Vector3d.sum(param2, param3));
                        _loc20_ = _loc18_;
                    };
                    _loc16_ = this.addPlane(RoomPlaneData.var_1065, _loc15_, new Vector3d(0, 0, -(_loc20_)), Vector3d.product(param2, -1));
                    if (_loc16_ != null)
                    {
                        if (param9 > 0)
                        {
                            _loc16_.addMask(0, 0, _loc18_, param9);
                        };
                        if (param8 > 0)
                        {
                            _loc16_.addMask(0, (param2.length - param8), _loc18_, param8);
                        };
                    };
                };
                if (param4)
                {
                    if (((param8 > 0) || (param12)))
                    {
                        _loc15_ = Vector3d.sum(param1, Vector3d.sum(param3, Vector3d.product(param2, (param8 / param2.length))));
                        _loc20_ = _loc19_;
                    }
                    else
                    {
                        _loc15_ = Vector3d.sum(param1, param3);
                        _loc20_ = _loc18_;
                    };
                    _loc17_ = this.addPlane(RoomPlaneData.var_1065, _loc15_, new Vector3d(0, 0, -(_loc20_)), Vector3d.product(param3, -1));
                    if (_loc17_ != null)
                    {
                        if (param11 > 0)
                        {
                            _loc17_.addMask(0, 0, _loc18_, param11);
                        };
                        if (param10 > 0)
                        {
                            _loc17_.addMask(0, (param3.length - param10), _loc18_, param10);
                        };
                    };
                };
                if (param5)
                {
                    if (((param9 > 0) || (param12)))
                    {
                        _loc15_ = Vector3d.sum(param1, Vector3d.product(param2, (1 - (param9 / param2.length))));
                        _loc20_ = _loc19_;
                    }
                    else
                    {
                        _loc15_ = Vector3d.sum(param1, param2);
                        _loc20_ = _loc18_;
                    };
                    _loc17_ = this.addPlane(RoomPlaneData.var_1065, _loc15_, new Vector3d(0, 0, -(_loc20_)), param3);
                    if (_loc17_ != null)
                    {
                        if (param10 > 0)
                        {
                            _loc17_.addMask(0, 0, _loc18_, param10);
                        };
                        if (param11 > 0)
                        {
                            _loc17_.addMask(0, (param3.length - param11), _loc18_, param11);
                        };
                    };
                };
            };
        }

        public function initializeFromXML(param1:XML):Boolean
        {
            var _loc7_:XML;
            var _loc8_:XMLList;
            var _loc9_:int;
            var _loc10_:XML;
            var _loc11_:Number;
            var _loc12_:XML;
            var _loc13_:XMLList;
            var _loc14_:int;
            var _loc15_:XML;
            if (param1 == null)
            {
                return (false);
            };
            this.reset();
            this.resetFloorHoles();
            if (!XMLValidator.checkRequiredAttributes(param1.tileMap[0], ["width", "height", "wallHeight"]))
            {
                return (false);
            };
            var _loc2_:int = parseInt(param1.tileMap.@width);
            var _loc3_:int = parseInt(param1.tileMap.@height);
            var _loc4_:Number = parseFloat(param1.tileMap.@wallHeight);
            this.initializeTileMap(_loc2_, _loc3_);
            var _loc5_:XMLList = param1.tileMap.tileRow;
            var _loc6_:int;
            while (_loc6_ < _loc5_.length())
            {
                _loc7_ = _loc5_[_loc6_];
                _loc8_ = _loc7_.tile;
                _loc9_ = 0;
                while (_loc9_ < _loc8_.length())
                {
                    _loc10_ = _loc8_[_loc9_];
                    _loc11_ = parseFloat(_loc10_.@height);
                    this.setTileHeight(_loc9_, _loc6_, _loc11_);
                    _loc9_++;
                };
                _loc6_++;
            };
            if (param1.holeMap.length() > 0)
            {
                _loc12_ = param1.holeMap[0];
                _loc13_ = _loc12_.hole;
                _loc14_ = 0;
                while (_loc14_ < _loc13_.length())
                {
                    _loc15_ = _loc13_[_loc14_];
                    if (XMLValidator.checkRequiredAttributes(_loc15_, ["id", "x", "y", "width", "height"]))
                    {
                        this.addFloorHole(_loc15_.@id, _loc15_.@x, _loc15_.@y, _loc15_.@width, _loc15_.@height);
                    };
                    _loc14_++;
                };
                this.initializeHoleMap();
            };
            this.wallHeight = _loc4_;
            this.initializeFromTileData();
            return (true);
        }

        private function addPlane(param1:int, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:Array=null):RoomPlaneData
        {
            if (((param3.length == 0) || (param4.length == 0)))
            {
                return (null);
            };
            var _loc6_:RoomPlaneData = new RoomPlaneData(param1, param2, param3, param4, param5);
            this.var_4628.push(_loc6_);
            return (_loc6_);
        }

        public function getXML():XML
        {
            var _loc7_:XML;
            var _loc8_:Array;
            var _loc9_:int;
            var _loc10_:Number;
            var _loc11_:XML;
            var _loc12_:RoomFloorHole;
            var _loc13_:int;
            var _loc14_:XML;
            var _loc1_:XML = new (XML)((((((('<tileMap width="' + this.var_2731) + '" height="') + this._height) + '" wallHeight="') + this.var_4838) + '"/>'));
            var _loc2_:int;
            while (_loc2_ < this._height)
            {
                _loc7_ = <tileRow/>
                ;
                _loc8_ = this.var_4834[_loc2_];
                _loc9_ = 0;
                while (_loc9_ < this.var_2731)
                {
                    _loc10_ = _loc8_[_loc9_];
                    _loc11_ = new (XML)((('<tile height="' + _loc10_) + '"/>'));
                    _loc7_.appendChild(_loc11_);
                    _loc9_++;
                };
                _loc1_.appendChild(_loc7_);
                _loc2_++;
            };
            var _loc3_:XML = <holeMap/>
            ;
            var _loc4_:int;
            while (_loc4_ < this.var_4840.length)
            {
                _loc12_ = this.var_4840.getWithIndex(_loc4_);
                if (_loc12_ != null)
                {
                    _loc13_ = this.var_4840.getKey(_loc4_);
                    _loc14_ = new (XML)((((((((((('<hole id="' + _loc13_) + '" x="') + _loc12_.x) + '" y="') + _loc12_.y) + '" width="') + _loc12_.width) + '" height="') + _loc12_.height) + '"/>'));
                    _loc3_.appendChild(_loc14_);
                };
                _loc4_++;
            };
            var _loc5_:XML = <roomData/>
            ;
            _loc5_.appendChild(_loc1_);
            _loc5_.appendChild(_loc3_);
            var _loc6_:XML = new (XML)((((((((('<dimensions minX="' + this.minX) + '" maxX="') + this.maxX) + '" minY="') + this.minY) + '" maxY="') + this.maxY) + '"/>'));
            _loc5_.appendChild(_loc6_);
            return (_loc5_);
        }

        public function getPlaneLocation(param1:int):IVector3d
        {
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (null);
            };
            var _loc2_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc2_ != null)
            {
                return (_loc2_.loc);
            };
            return (null);
        }

        public function getPlaneNormal(param1:int):IVector3d
        {
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (null);
            };
            var _loc2_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc2_ != null)
            {
                return (_loc2_.normal);
            };
            return (null);
        }

        public function getPlaneLeftSide(param1:int):IVector3d
        {
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (null);
            };
            var _loc2_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc2_ != null)
            {
                return (_loc2_.leftSide);
            };
            return (null);
        }

        public function getPlaneRightSide(param1:int):IVector3d
        {
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (null);
            };
            var _loc2_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc2_ != null)
            {
                return (_loc2_.rightSide);
            };
            return (null);
        }

        public function getPlaneNormalDirection(param1:int):IVector3d
        {
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (null);
            };
            var _loc2_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc2_ != null)
            {
                return (_loc2_.normalDirection);
            };
            return (null);
        }

        public function getPlaneSecondaryNormals(param1:int):Array
        {
            var _loc3_:Array;
            var _loc4_:int;
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (null);
            };
            var _loc2_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc2_ != null)
            {
                _loc3_ = [];
                _loc4_ = 0;
                while (_loc4_ < _loc2_.secondaryNormalCount)
                {
                    _loc3_.push(_loc2_.getSecondaryNormal(_loc4_));
                    _loc4_++;
                };
                return (_loc3_);
            };
            return (null);
        }

        public function getPlaneType(param1:int):int
        {
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (RoomPlaneData.var_1832);
            };
            var _loc2_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc2_ != null)
            {
                return (_loc2_.type);
            };
            return (RoomPlaneData.var_1832);
        }

        public function getPlaneMaskCount(param1:int):int
        {
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (0);
            };
            var _loc2_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc2_ != null)
            {
                return (_loc2_.maskCount);
            };
            return (0);
        }

        public function getPlaneMaskLeftSideLoc(param1:int, param2:int):Number
        {
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (-1);
            };
            var _loc3_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc3_ != null)
            {
                return (_loc3_.getMaskLeftSideLoc(param2));
            };
            return (-1);
        }

        public function getPlaneMaskRightSideLoc(param1:int, param2:int):Number
        {
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (-1);
            };
            var _loc3_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc3_ != null)
            {
                return (_loc3_.getMaskRightSideLoc(param2));
            };
            return (-1);
        }

        public function getPlaneMaskLeftSideLength(param1:int, param2:int):Number
        {
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (-1);
            };
            var _loc3_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc3_ != null)
            {
                return (_loc3_.getMaskLeftSideLength(param2));
            };
            return (-1);
        }

        public function getPlaneMaskRightSideLength(param1:int, param2:int):Number
        {
            if (((param1 < 0) || (param1 >= this.planeCount)))
            {
                return (-1);
            };
            var _loc3_:RoomPlaneData = (this.var_4628[param1] as RoomPlaneData);
            if (_loc3_ != null)
            {
                return (_loc3_.getMaskRightSideLength(param2));
            };
            return (-1);
        }

        public function addFloorHole(param1:int, param2:int, param3:int, param4:int, param5:int):void
        {
            this.removeFloorHole(param1);
            var _loc6_:RoomFloorHole = new RoomFloorHole(param2, param3, param4, param5);
            this.var_4840.add(param1, _loc6_);
        }

        public function removeFloorHole(param1:int):void
        {
            this.var_4840.remove(param1);
        }

        public function resetFloorHoles():void
        {
            this.var_4840.reset();
        }

        private function initializeHoleMap():void
        {
            var _loc1_:int;
            var _loc2_:int;
            var _loc3_:Array;
            var _loc5_:RoomFloorHole;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:int;
            _loc2_ = 0;
            while (_loc2_ < this._height)
            {
                _loc3_ = this.var_4841[_loc2_];
                _loc1_ = 0;
                while (_loc1_ < this.var_2731)
                {
                    _loc3_[_loc1_] = false;
                    _loc1_++;
                };
                _loc2_++;
            };
            var _loc4_:int;
            while (_loc4_ < this.var_4840.length)
            {
                _loc5_ = this.var_4840.getWithIndex(_loc4_);
                if (_loc5_ != null)
                {
                    _loc6_ = _loc5_.x;
                    _loc7_ = ((_loc5_.x + _loc5_.width) - 1);
                    _loc8_ = _loc5_.y;
                    _loc9_ = ((_loc5_.y + _loc5_.height) - 1);
                    _loc6_ = ((_loc6_ < 0) ? 0 : _loc6_);
                    _loc7_ = ((_loc7_ >= this.var_2731) ? (this.var_2731 - 1) : _loc7_);
                    _loc8_ = ((_loc8_ < 0) ? 0 : _loc8_);
                    _loc9_ = ((_loc9_ >= this._height) ? (this._height - 1) : _loc9_);
                    _loc2_ = _loc8_;
                    while (_loc2_ <= _loc9_)
                    {
                        _loc3_ = this.var_4841[_loc2_];
                        _loc1_ = _loc6_;
                        while (_loc1_ <= _loc7_)
                        {
                            _loc3_[_loc1_] = true;
                            _loc1_++;
                        };
                        _loc2_++;
                    };
                };
                _loc4_++;
            };
        }


    }
}