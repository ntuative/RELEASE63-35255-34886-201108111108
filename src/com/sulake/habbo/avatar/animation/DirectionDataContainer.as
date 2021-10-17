package com.sulake.habbo.avatar.animation
{
    public class DirectionDataContainer 
    {

        private var _offset:int;

        public function DirectionDataContainer(param1:XML)
        {
            this._offset = parseInt(param1.@offset);
        }

        public function get offset():int
        {
            return (this._offset);
        }


    }
}