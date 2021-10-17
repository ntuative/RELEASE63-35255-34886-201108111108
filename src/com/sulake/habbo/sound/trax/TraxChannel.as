package com.sulake.habbo.sound.trax
{
    public class TraxChannel 
    {

        private var _id:int;
        private var _items:Array;

        public function TraxChannel(param1:int)
        {
            this._id = param1;
            this._items = [];
        }

        public function get itemCount():int
        {
            return (this._items.length);
        }

        public function addChannelItem(param1:TraxChannelItem):void
        {
            this._items.push(param1);
        }

        public function getItem(param1:int):TraxChannelItem
        {
            return (this._items[param1] as TraxChannelItem);
        }


    }
}