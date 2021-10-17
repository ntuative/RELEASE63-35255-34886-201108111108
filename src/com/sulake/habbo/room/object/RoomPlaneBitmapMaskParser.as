package com.sulake.habbo.room.object
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.room.utils.IVector3d;

    public class RoomPlaneBitmapMaskParser 
    {

        private var var_4750:Map = null;

        public function RoomPlaneBitmapMaskParser()
        {
            this.var_4750 = new Map();
        }

        public function get maskCount():int
        {
            return (this.var_4750.length);
        }

        public function dispose():void
        {
            if (this.var_4750 != null)
            {
                this.reset();
                this.var_4750.dispose();
                this.var_4750 = null;
            };
        }

        public function initialize(param1:XML):Boolean
        {
            var _loc7_:XML;
            var _loc8_:String;
            var _loc9_:String;
            var _loc10_:Vector3d;
            var _loc11_:String;
            var _loc12_:XMLList;
            var _loc13_:XML;
            var _loc14_:RoomPlaneBitmapMaskData;
            if (param1 == null)
            {
                return (false);
            };
            this.var_4750.reset();
            var _loc2_:Array = ["id", "type", "category"];
            var _loc3_:Array = ["x", "y", "z"];
            var _loc4_:XMLList;
            var _loc5_:XMLList = param1.planeMask;
            var _loc6_:int;
            while (_loc6_ < _loc5_.length())
            {
                _loc7_ = _loc5_[_loc6_];
                if (!XMLValidator.checkRequiredAttributes(_loc7_, _loc2_))
                {
                    return (false);
                };
                _loc8_ = _loc7_.@id;
                _loc9_ = _loc7_.@type;
                _loc10_ = null;
                _loc11_ = _loc7_.@category;
                _loc12_ = _loc7_.location;
                if (_loc12_.length() != 1)
                {
                    return (false);
                };
                _loc13_ = _loc12_[0];
                if (!XMLValidator.checkRequiredAttributes(_loc13_, _loc3_))
                {
                    return (false);
                };
                _loc10_ = new Vector3d(Number(_loc13_.@x), Number(_loc13_.@y), Number(_loc13_.@z));
                _loc14_ = new RoomPlaneBitmapMaskData(_loc9_, _loc10_, _loc11_);
                this.var_4750.add(_loc8_, _loc14_);
                _loc6_++;
            };
            return (true);
        }

        public function reset():void
        {
            var _loc2_:RoomPlaneBitmapMaskData;
            var _loc1_:int;
            while (_loc1_ < this.var_4750.length)
            {
                _loc2_ = (this.var_4750.getWithIndex(_loc1_) as RoomPlaneBitmapMaskData);
                if (_loc2_ != null)
                {
                    _loc2_.dispose();
                };
                _loc1_++;
            };
            this.var_4750.reset();
        }

        public function addMask(param1:String, param2:String, param3:IVector3d, param4:String):void
        {
            var _loc5_:RoomPlaneBitmapMaskData = new RoomPlaneBitmapMaskData(param2, param3, param4);
            this.var_4750.remove(param1);
            this.var_4750.add(param1, _loc5_);
        }

        public function removeMask(param1:String):Boolean
        {
            var _loc2_:RoomPlaneBitmapMaskData = (this.var_4750.remove(param1) as RoomPlaneBitmapMaskData);
            if (_loc2_ != null)
            {
                _loc2_.dispose();
                return (true);
            };
            return (false);
        }

        public function getXML():XML
        {
            var _loc3_:String;
            var _loc4_:String;
            var _loc5_:XML;
            var _loc6_:IVector3d;
            var _loc1_:XML = <planeMasks/>
            ;
            var _loc2_:int;
            while (_loc2_ < this.maskCount)
            {
                _loc3_ = this.getMaskType(_loc2_);
                _loc4_ = this.getMaskCategory(_loc2_);
                _loc5_ = new (XML)((((((('<planeMask id="' + _loc2_) + '" type="') + _loc3_) + '" category="') + _loc4_) + '"/>'));
                _loc6_ = this.getMaskLocation(_loc2_);
                if (_loc6_ != null)
                {
                    _loc5_.appendChild(new (XML)((((((('<location x="' + _loc6_.x) + '" y="') + _loc6_.y) + '" z="') + _loc6_.z) + '"/>')));
                    _loc1_.appendChild(_loc5_);
                };
                _loc2_++;
            };
            return (_loc1_);
        }

        public function getMaskLocation(param1:int):IVector3d
        {
            if (((param1 < 0) || (param1 >= this.maskCount)))
            {
                return (null);
            };
            var _loc2_:RoomPlaneBitmapMaskData = (this.var_4750.getWithIndex(param1) as RoomPlaneBitmapMaskData);
            if (_loc2_ != null)
            {
                return (_loc2_.loc);
            };
            return (null);
        }

        public function getMaskType(param1:int):String
        {
            if (((param1 < 0) || (param1 >= this.maskCount)))
            {
                return (null);
            };
            var _loc2_:RoomPlaneBitmapMaskData = (this.var_4750.getWithIndex(param1) as RoomPlaneBitmapMaskData);
            if (_loc2_ != null)
            {
                return (_loc2_.type);
            };
            return (null);
        }

        public function getMaskCategory(param1:int):String
        {
            if (((param1 < 0) || (param1 >= this.maskCount)))
            {
                return (null);
            };
            var _loc2_:RoomPlaneBitmapMaskData = (this.var_4750.getWithIndex(param1) as RoomPlaneBitmapMaskData);
            if (_loc2_ != null)
            {
                return (_loc2_.category);
            };
            return (null);
        }


    }
}