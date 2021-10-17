package com.sulake.habbo.room.object.visualization.data
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.XMLValidator;

    public class SizeData 
    {

        public static const var_1441:int = 1000;
        public static const var_2233:int = 0;

        private var var_4613:int = 0;
        private var var_4619:int = 360;
        private var var_4620:DirectionData = null;
        private var var_4520:Map;
        private var _colors:Map;
        private var var_4621:DirectionData = null;
        private var var_4622:int = -1;

        public function SizeData(param1:int, param2:int)
        {
            if (param1 < 0)
            {
                param1 = 0;
            };
            if (param1 > var_1441)
            {
                param1 = var_1441;
            };
            this.var_4613 = param1;
            if (param2 < 1)
            {
                param2 = 1;
            };
            if (param2 > 360)
            {
                param2 = 360;
            };
            this.var_4619 = param2;
            this.var_4620 = new DirectionData(param1);
            this.var_4520 = new Map();
            this._colors = new Map();
        }

        public function dispose():void
        {
            var _loc2_:DirectionData;
            var _loc3_:ColorData;
            if (this.var_4620 != null)
            {
                this.var_4620.dispose();
                this.var_4620 = null;
            };
            var _loc1_:int;
            if (this.var_4520 != null)
            {
                _loc2_ = null;
                _loc1_ = 0;
                while (_loc1_ < this.var_4520.length)
                {
                    _loc2_ = (this.var_4520.getWithIndex(_loc1_) as DirectionData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4520.dispose();
                this.var_4520 = null;
            };
            this.var_4621 = null;
            if (this._colors != null)
            {
                _loc3_ = null;
                _loc1_ = 0;
                while (_loc1_ < this._colors.length)
                {
                    _loc3_ = (this._colors.getWithIndex(_loc1_) as ColorData);
                    if (_loc3_ != null)
                    {
                        _loc3_.dispose();
                    };
                    _loc1_++;
                };
                this._colors.dispose();
                this._colors = null;
            };
        }

        public function get layerCount():int
        {
            return (this.var_4613);
        }

        public function defineLayers(param1:XML):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:XMLList = param1.layer;
            return (this.defineDirection(this.var_4620, _loc2_));
        }

        public function defineDirections(param1:XML):Boolean
        {
            var _loc6_:XML;
            var _loc7_:int;
            var _loc8_:XMLList;
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:Array = ["id"];
            var _loc3_:DirectionData;
            var _loc4_:XMLList = param1.direction;
            var _loc5_:int;
            while (_loc5_ < _loc4_.length())
            {
                _loc6_ = _loc4_[_loc5_];
                if (!XMLValidator.checkRequiredAttributes(_loc6_, _loc2_))
                {
                    return (false);
                };
                _loc7_ = int(_loc6_.@id);
                _loc8_ = _loc6_.layer;
                if (this.var_4520.getValue(String(_loc7_)) != null)
                {
                    return (false);
                };
                _loc3_ = new DirectionData(this.layerCount);
                _loc3_.copyValues(this.var_4620);
                this.defineDirection(_loc3_, _loc8_);
                this.var_4520.add(String(_loc7_), _loc3_);
                this.var_4622 = -1;
                this.var_4621 = null;
                _loc5_++;
            };
            return (true);
        }

        private function defineDirection(param1:DirectionData, param2:XMLList):Boolean
        {
            var _loc5_:XML;
            var _loc6_:int;
            var _loc7_:String;
            var _loc8_:String;
            var _loc9_:int;
            var _loc10_:int;
            if (((param1 == null) || (param2 == null)))
            {
                return (false);
            };
            var _loc3_:Array = ["id"];
            var _loc4_:int;
            while (_loc4_ < param2.length())
            {
                _loc5_ = param2[_loc4_];
                if (!XMLValidator.checkRequiredAttributes(_loc5_, _loc3_))
                {
                    return (false);
                };
                _loc6_ = int(_loc5_.@id);
                if (((_loc6_ < 0) || (_loc6_ >= this.layerCount)))
                {
                    return (false);
                };
                _loc7_ = _loc5_.@tag;
                if (_loc7_.length > 0)
                {
                    param1.setTag(_loc6_, _loc7_);
                };
                _loc8_ = _loc5_.@ink;
                switch (_loc8_)
                {
                    case "ADD":
                        param1.setInk(_loc6_, LayerData.var_1453);
                        break;
                    case "SUBTRACT":
                        param1.setInk(_loc6_, LayerData.var_1454);
                        break;
                    case "DARKEN":
                        param1.setInk(_loc6_, LayerData.INK_DARKEN);
                        break;
                };
                _loc7_ = _loc5_.@alpha;
                if (_loc7_.length > 0)
                {
                    param1.setAlpha(_loc6_, int(_loc7_));
                };
                _loc7_ = _loc5_.@ignoreMouse;
                if (_loc7_.length > 0)
                {
                    _loc9_ = int(_loc7_);
                    param1.setIgnoreMouse(_loc6_, (!(_loc9_ == 0)));
                };
                _loc7_ = _loc5_.@x;
                if (_loc7_.length > 0)
                {
                    param1.setXOffset(_loc6_, int(_loc7_));
                };
                _loc7_ = _loc5_.@y;
                if (_loc7_.length > 0)
                {
                    param1.setYOffset(_loc6_, int(_loc7_));
                };
                _loc7_ = _loc5_.@z;
                if (_loc7_.length > 0)
                {
                    _loc10_ = int(_loc7_);
                    param1.setZOffset(_loc6_, (Number(_loc10_) / -1000));
                };
                _loc4_++;
            };
            return (true);
        }

        public function defineColors(param1:XML):Boolean
        {
            var _loc7_:XML;
            var _loc8_:String;
            var _loc9_:XMLList;
            var _loc10_:int;
            var _loc11_:XML;
            var _loc12_:int;
            var _loc13_:int;
            if (param1 == null)
            {
                return (true);
            };
            var _loc2_:ColorData;
            var _loc3_:Array = ["id"];
            var _loc4_:Array = ["id", "color"];
            var _loc5_:XMLList = param1.color;
            var _loc6_:int;
            while (_loc6_ < _loc5_.length())
            {
                _loc7_ = _loc5_[_loc6_];
                if (!XMLValidator.checkRequiredAttributes(_loc7_, _loc3_))
                {
                    return (false);
                };
                _loc8_ = _loc7_.@id;
                if (this._colors.getValue(_loc8_) != null)
                {
                    return (false);
                };
                _loc2_ = new ColorData(this.layerCount);
                _loc9_ = _loc7_.colorLayer;
                _loc10_ = 0;
                while (_loc10_ < _loc9_.length())
                {
                    _loc11_ = _loc9_[_loc10_];
                    if (!XMLValidator.checkRequiredAttributes(_loc11_, _loc4_))
                    {
                        _loc2_.dispose();
                        return (false);
                    };
                    _loc12_ = int(_loc11_.@id);
                    _loc13_ = parseInt(_loc11_.@color, 16);
                    _loc2_.setColor(_loc13_, _loc12_);
                    _loc10_++;
                };
                if (_loc2_ != null)
                {
                    this._colors.add(_loc8_, _loc2_);
                };
                _loc6_++;
            };
            return (true);
        }

        public function getDirectionValue(param1:int):int
        {
            var _loc6_:int;
            var _loc7_:int;
            var _loc2_:int = int((((((param1 % 360) + 360) + (this.var_4619 / 2)) % 360) / this.var_4619));
            if (this.var_4520.getValue(String(_loc2_)) != null)
            {
                return (_loc2_);
            };
            _loc2_ = (((param1 % 360) + 360) % 360);
            var _loc3_:int = -1;
            var _loc4_:int = -1;
            var _loc5_:int;
            while (_loc5_ < this.var_4520.length)
            {
                _loc6_ = (int(this.var_4520.getKey(_loc5_)) * this.var_4619);
                _loc7_ = (((_loc6_ - _loc2_) + 360) % 360);
                if (_loc7_ > 180)
                {
                    _loc7_ = (360 - _loc7_);
                };
                if (((_loc7_ < _loc3_) || (_loc3_ < 0)))
                {
                    _loc3_ = _loc7_;
                    _loc4_ = _loc5_;
                };
                _loc5_++;
            };
            if (_loc4_ >= 0)
            {
                return (int(this.var_4520.getKey(_loc4_)));
            };
            return (var_2233);
        }

        private function getDirectionData(param1:int):DirectionData
        {
            if (param1 == this.var_4622)
            {
                return (this.var_4621);
            };
            var _loc2_:DirectionData;
            _loc2_ = (this.var_4520.getValue(String(param1)) as DirectionData);
            if (_loc2_ == null)
            {
                _loc2_ = this.var_4620;
            };
            this.var_4622 = param1;
            this.var_4621 = _loc2_;
            return (this.var_4621);
        }

        public function getTag(param1:int, param2:int):String
        {
            var _loc3_:DirectionData;
            _loc3_ = this.getDirectionData(param1);
            if (_loc3_ != null)
            {
                return (_loc3_.getTag(param2));
            };
            return (LayerData.var_1443);
        }

        public function getInk(param1:int, param2:int):int
        {
            var _loc3_:DirectionData;
            _loc3_ = this.getDirectionData(param1);
            if (_loc3_ != null)
            {
                return (_loc3_.getInk(param2));
            };
            return (LayerData.var_1444);
        }

        public function getAlpha(param1:int, param2:int):int
        {
            var _loc3_:DirectionData;
            _loc3_ = this.getDirectionData(param1);
            if (_loc3_ != null)
            {
                return (_loc3_.getAlpha(param2));
            };
            return (LayerData.var_1445);
        }

        public function getColor(param1:int, param2:int):uint
        {
            var _loc3_:ColorData = (this._colors.getValue(String(param2)) as ColorData);
            if (_loc3_ != null)
            {
                return (_loc3_.getColor(param1));
            };
            return (ColorData.var_1446);
        }

        public function getIgnoreMouse(param1:int, param2:int):Boolean
        {
            var _loc3_:DirectionData;
            _loc3_ = this.getDirectionData(param1);
            if (_loc3_ != null)
            {
                return (_loc3_.getIgnoreMouse(param2));
            };
            return (LayerData.var_1447);
        }

        public function getXOffset(param1:int, param2:int):int
        {
            var _loc3_:DirectionData;
            _loc3_ = this.getDirectionData(param1);
            if (_loc3_ != null)
            {
                return (_loc3_.getXOffset(param2));
            };
            return (LayerData.var_1448);
        }

        public function getYOffset(param1:int, param2:int):int
        {
            var _loc3_:DirectionData;
            _loc3_ = this.getDirectionData(param1);
            if (_loc3_ != null)
            {
                return (_loc3_.getYOffset(param2));
            };
            return (LayerData.var_1449);
        }

        public function getZOffset(param1:int, param2:int):Number
        {
            var _loc3_:DirectionData;
            _loc3_ = this.getDirectionData(param1);
            if (_loc3_ != null)
            {
                return (_loc3_.getZOffset(param2));
            };
            return (LayerData.var_1450);
        }


    }
}