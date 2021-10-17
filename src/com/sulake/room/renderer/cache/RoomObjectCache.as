package com.sulake.room.renderer.cache
{
    import com.sulake.core.utils.Map;

    public class RoomObjectCache 
    {

        private var _data:Map = null;
        private var _roomObjectVariableAccurateZ:String = "";

        public function RoomObjectCache(param1:String)
        {
            this._roomObjectVariableAccurateZ = param1;
            this._data = new Map();
        }

        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:RoomObjectCacheItem;
            if (this._data != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this._data.length)
                {
                    _loc2_ = (this._data.getWithIndex(_loc1_) as RoomObjectCacheItem);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this._data.dispose();
                this._data = null;
            };
        }

        public function getObjectCache(param1:String):RoomObjectCacheItem
        {
            var _loc2_:RoomObjectCacheItem = (this._data.getValue(param1) as RoomObjectCacheItem);
            if (_loc2_ == null)
            {
                _loc2_ = new RoomObjectCacheItem(this._roomObjectVariableAccurateZ);
                this._data.add(param1, _loc2_);
            };
            return (_loc2_);
        }

        public function removeObjectCache(param1:String):void
        {
            var _loc2_:RoomObjectCacheItem = (this._data.remove(param1) as RoomObjectCacheItem);
            if (_loc2_ != null)
            {
                _loc2_.dispose();
            };
        }


    }
}