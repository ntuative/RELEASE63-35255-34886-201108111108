package com.sulake.habbo.room.utils
{
    public class PublicRoomWorldData 
    {

        private var _worldType:String = "";
        private var var_4851:Number = 1;
        private var _scale:Number = 1;

        public function PublicRoomWorldData(param1:String, param2:Number, param3:Number)
        {
            this._worldType = param1;
            this._scale = param2;
            this.var_4851 = param3;
        }

        public function get heightScale():Number
        {
            return (this.var_4851);
        }

        public function get scale():Number
        {
            return (this._scale);
        }


    }
}