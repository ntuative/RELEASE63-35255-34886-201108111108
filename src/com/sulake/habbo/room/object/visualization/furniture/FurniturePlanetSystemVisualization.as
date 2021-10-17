package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurniturePlanetSystemVisualization extends AnimatedFurnitureVisualization 
    {

        private var var_4687:Array;
        private var _planetNameIndex:Array;
        private var _offsetArray:Array = new Array();
        private var var_4688:Vector3d = new Vector3d(0, 0, 0);


        override public function dispose():void
        {
            var _loc1_:FurniturePlanetSystemVisualizationPlanetObject;
            if (this.var_4687 != null)
            {
                while (this.var_4687.length > 0)
                {
                    _loc1_ = this.var_4687.shift();
                    _loc1_.dispose();
                };
            };
            this.var_4687 = null;
            this._planetNameIndex = null;
        }

        override protected function updateAnimation(param1:Number):int
        {
            var _loc2_:FurniturePlanetSystemVisualizationPlanetObject;
            var _loc3_:int;
            if (((this.var_4687 == null) && (spriteCount > 0)))
            {
                if (!this.readDefinition())
                {
                    return (0);
                };
            };
            if (this.var_4687 != null)
            {
                _loc3_ = 0;
                while (_loc3_ < this.var_4687.length)
                {
                    _loc2_ = this.var_4687[_loc3_];
                    _loc2_.update(this._offsetArray, this.var_4688, param1);
                    _loc3_++;
                };
                return (super.updateAnimation(param1));
            };
            return (0);
        }

        override protected function getSpriteXOffset(param1:int, param2:int, param3:int):int
        {
            if (param3 < this._offsetArray.length)
            {
                return (this._offsetArray[param3].x);
            };
            return (super.getSpriteXOffset(param1, param2, param3));
        }

        override protected function getSpriteYOffset(param1:int, param2:int, param3:int):int
        {
            if (param3 < this._offsetArray.length)
            {
                return (this._offsetArray[param3].y);
            };
            return (super.getSpriteYOffset(param1, param2, param3));
        }

        override protected function getSpriteZOffset(param1:int, param2:int, param3:int):Number
        {
            if (param3 < this._offsetArray.length)
            {
                return (this._offsetArray[param3].z);
            };
            return (super.getSpriteZOffset(param1, param2, param3));
        }

        private function readDefinition():Boolean
        {
            var _loc7_:IRoomObjectSprite;
            var _loc9_:XML;
            var _loc1_:IRoomObject = object;
            if (_loc1_ == null)
            {
                return (false);
            };
            var _loc2_:IRoomObjectModel = _loc1_.getModel();
            if (_loc2_ == null)
            {
                return (false);
            };
            var _loc3_:String = _loc2_.getString(RoomObjectVariableEnum.var_766);
            var _loc4_:XMLList = XMLList(_loc3_);
            var _loc5_:XMLList = _loc4_.children();
            var _loc6_:int = _loc5_.length();
            this.var_4687 = new Array();
            this._planetNameIndex = new Array();
            var _loc8_:int;
            while (_loc8_ < _loc6_)
            {
                _loc9_ = _loc5_[_loc8_];
                _loc7_ = getSprite(_loc8_);
                if (_loc7_ != null)
                {
                    this.addPlanet(_loc9_.@name, _loc8_, _loc9_.@parent, Number(_loc9_.@radius), Number(_loc9_.@arcspeed), Number(_loc9_.@arcoffset), Number(_loc9_.@height));
                };
                _loc8_++;
            };
            return (true);
        }

        private function addPlanet(param1:String, param2:int, param3:String, param4:Number, param5:Number, param6:Number, param7:Number):void
        {
            var _loc9_:FurniturePlanetSystemVisualizationPlanetObject;
            if (this.var_4687 == null)
            {
                return;
            };
            var _loc8_:FurniturePlanetSystemVisualizationPlanetObject = new FurniturePlanetSystemVisualizationPlanetObject(param1, param2, param4, param5, param6, param7);
            _loc9_ = this.getPlanet(param3);
            if (_loc9_ != null)
            {
                _loc9_.addChild(_loc8_);
            }
            else
            {
                this.var_4687.push(_loc8_);
                this._planetNameIndex.push(param1);
            };
        }

        private function getPlanet(param1:String):FurniturePlanetSystemVisualizationPlanetObject
        {
            var _loc2_:FurniturePlanetSystemVisualizationPlanetObject;
            var _loc3_:int;
            while (_loc3_ < this.var_4687.length)
            {
                _loc2_ = this.var_4687[_loc3_];
                if (_loc2_.name == param1)
                {
                    return (_loc2_);
                };
                if (_loc2_.hasChild(param1))
                {
                    return (_loc2_.getChild(param1));
                };
                _loc3_++;
            };
            return (null);
        }


    }
}