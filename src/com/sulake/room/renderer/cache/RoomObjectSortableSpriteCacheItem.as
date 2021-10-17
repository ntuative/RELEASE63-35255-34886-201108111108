package com.sulake.room.renderer.cache
{
    import com.sulake.room.renderer.utils.SortableSprite;

    public class RoomObjectSortableSpriteCacheItem 
    {

        private var var_3028:Array = [];
        private var var_5537:int = -1;
        private var var_5538:int = -1;
        private var var_5539:Boolean = false;


        public function get spriteCount():int
        {
            return (this.var_3028.length);
        }

        public function get isEmpty():Boolean
        {
            return (this.var_5539);
        }

        public function dispose():void
        {
            this.setSpriteCount(0);
        }

        public function addSprite(param1:SortableSprite):void
        {
            this.var_3028.push(param1);
        }

        public function getSprite(param1:int):SortableSprite
        {
            return (this.var_3028[param1]);
        }

        public function needsUpdate(param1:int, param2:int):Boolean
        {
            if (((!(param1 == this.var_5537)) || (!(param2 == this.var_5538))))
            {
                this.var_5537 = param1;
                this.var_5538 = param2;
                return (true);
            };
            return (false);
        }

        public function setSpriteCount(param1:int):void
        {
            var _loc2_:int;
            var _loc3_:SortableSprite;
            if (param1 < this.var_3028.length)
            {
                _loc2_ = param1;
                while (_loc2_ < this.var_3028.length)
                {
                    _loc3_ = this.getSprite(_loc2_);
                    if (_loc3_)
                    {
                        _loc3_.dispose();
                    };
                    _loc2_++;
                };
                this.var_3028.splice(param1, (this.var_3028.length - param1));
            };
            if (this.var_3028.length == 0)
            {
                this.var_5539 = true;
            }
            else
            {
                this.var_5539 = false;
            };
        }


    }
}