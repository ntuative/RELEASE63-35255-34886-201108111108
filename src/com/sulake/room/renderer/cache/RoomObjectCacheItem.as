package com.sulake.room.renderer.cache
{
    public class RoomObjectCacheItem 
    {

        private var var_2957:RoomObjectLocationCacheItem = null;
        private var var_3028:RoomObjectSortableSpriteCacheItem = null;

        public function RoomObjectCacheItem(param1:String)
        {
            this.var_2957 = new RoomObjectLocationCacheItem(param1);
            this.var_3028 = new RoomObjectSortableSpriteCacheItem();
        }

        public function get location():RoomObjectLocationCacheItem
        {
            return (this.var_2957);
        }

        public function get sprites():RoomObjectSortableSpriteCacheItem
        {
            return (this.var_3028);
        }

        public function dispose():void
        {
            if (this.var_2957 != null)
            {
                this.var_2957.dispose();
                this.var_2957 = null;
            };
            if (this.var_3028 != null)
            {
                this.var_3028.dispose();
                this.var_3028 = null;
            };
        }


    }
}