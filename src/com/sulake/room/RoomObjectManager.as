package com.sulake.room
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.object.RoomObject;
    import com.sulake.room.object.IRoomObjectController;

    public class RoomObjectManager implements IRoomObjectManager 
    {

        private var _objects:Map;
        private var var_5599:Map;

        public function RoomObjectManager()
        {
            this._objects = new Map();
            this.var_5599 = new Map();
        }

        public function dispose():void
        {
            this.reset();
            if (this._objects != null)
            {
                this._objects.dispose();
                this._objects = null;
            };
            if (this.var_5599 != null)
            {
                this.var_5599.dispose();
                this.var_5599 = null;
            };
        }

        public function createObject(param1:int, param2:uint, param3:String):IRoomObjectController
        {
            var _loc4_:RoomObject = new RoomObject(param1, param2, param3);
            return (this.addObject(String(param1), param3, _loc4_));
        }

        private function addObject(param1:String, param2:String, param3:IRoomObjectController):IRoomObjectController
        {
            if (this._objects.getValue(param1) != null)
            {
                param3.dispose();
                return (null);
            };
            this._objects.add(param1, param3);
            var _loc4_:Map = this.getObjectsForType(param2);
            _loc4_.add(param1, param3);
            return (param3);
        }

        private function getObjectsForType(param1:String, param2:Boolean=true):Map
        {
            var _loc3_:Map = this.var_5599.getValue(param1);
            if (((_loc3_ == null) && (param2)))
            {
                _loc3_ = new Map();
                this.var_5599.add(param1, _loc3_);
            };
            return (_loc3_);
        }

        public function getObject(param1:int):IRoomObjectController
        {
            return (this._objects.getValue(String(param1)) as IRoomObjectController);
        }

        public function getObjectWithIndex(param1:int):IRoomObjectController
        {
            return (this._objects.getWithIndex(param1) as IRoomObjectController);
        }

        public function getObjectCount():int
        {
            return (this._objects.length);
        }

        public function getObjectCountForType(param1:String):int
        {
            var _loc2_:Map = this.getObjectsForType(param1, false);
            if (_loc2_ != null)
            {
                return (_loc2_.length);
            };
            return (0);
        }

        public function getObjectWithIndexAndType(param1:int, param2:String):IRoomObjectController
        {
            var _loc4_:IRoomObjectController;
            var _loc3_:Map = this.getObjectsForType(param2, false);
            if (_loc3_ != null)
            {
                return (_loc3_.getWithIndex(param1) as IRoomObjectController);
            };
            return (null);
        }

        public function disposeObject(param1:int):Boolean
        {
            var _loc4_:String;
            var _loc5_:Map;
            var _loc2_:String = String(param1);
            var _loc3_:RoomObject = (this._objects.remove(_loc2_) as RoomObject);
            if (_loc3_ != null)
            {
                _loc4_ = _loc3_.getType();
                _loc5_ = this.getObjectsForType(_loc4_, false);
                if (_loc5_ != null)
                {
                    _loc5_.remove(_loc2_);
                };
                _loc3_.dispose();
                return (true);
            };
            return (false);
        }

        public function reset():void
        {
            var _loc1_:int;
            var _loc2_:IRoomObjectController;
            var _loc3_:int;
            var _loc4_:Map;
            if (this._objects != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this._objects.length)
                {
                    _loc2_ = (this._objects.getWithIndex(_loc1_) as IRoomObjectController);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this._objects.reset();
            };
            if (this.var_5599 != null)
            {
                _loc3_ = 0;
                while (_loc3_ < this.var_5599.length)
                {
                    _loc4_ = (this.var_5599.getWithIndex(_loc3_) as Map);
                    if (_loc4_ != null)
                    {
                        _loc4_.dispose();
                    };
                    _loc3_++;
                };
                this.var_5599.reset();
            };
        }


    }
}