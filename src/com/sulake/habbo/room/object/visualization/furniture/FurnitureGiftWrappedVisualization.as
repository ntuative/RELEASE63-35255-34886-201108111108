package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurnitureGiftWrappedVisualization extends FurnitureVisualization 
    {

        private var var_4632:int = 0;
        private var var_4633:int = 0;


        override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean):void
        {
            this.updateTypes();
            super.update(param1, param2, param3, param4);
        }

        private function updateTypes():void
        {
            var _loc2_:IRoomObjectModel;
            var _loc3_:int;
            var _loc4_:String;
            var _loc5_:int;
            var _loc1_:IRoomObject = object;
            if (_loc1_ != null)
            {
                _loc2_ = _loc1_.getModel();
                if (_loc2_ != null)
                {
                    _loc3_ = 1000;
                    _loc4_ = _loc2_.getString(RoomObjectVariableEnum.var_521);
                    _loc5_ = parseInt(_loc4_);
                    this.var_4632 = Math.floor((_loc5_ / _loc3_));
                    this.var_4633 = (_loc5_ % _loc3_);
                };
            };
        }

        override protected function getFrameNumber(param1:int, param2:int):int
        {
            if (param2 <= 1)
            {
                return (this.var_4632);
            };
            return (this.var_4633);
        }

        override protected function getSpriteAssetName(param1:int, param2:int):String
        {
            var _loc3_:int = getSize(param1);
            var _loc4_:String = type;
            var _loc5_:String = "";
            if (param2 < (spriteCount - 1))
            {
                _loc5_ = String.fromCharCode(("a".charCodeAt() + param2));
            }
            else
            {
                _loc5_ = "sd";
            };
            var _loc6_:int = this.getFrameNumber(param1, param2);
            _loc4_ = (_loc4_ + ((((("_" + _loc3_) + "_") + _loc5_) + "_") + direction));
            return (_loc4_ + ("_" + _loc6_));
        }


    }
}