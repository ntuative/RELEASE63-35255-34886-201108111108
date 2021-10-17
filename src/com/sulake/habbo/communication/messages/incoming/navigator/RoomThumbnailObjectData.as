package com.sulake.habbo.communication.messages.incoming.navigator
{
    public class RoomThumbnailObjectData 
    {

        private var var_3512:int;
        private var var_3513:int;


        public function getCopy():RoomThumbnailObjectData
        {
            var _loc1_:RoomThumbnailObjectData = new RoomThumbnailObjectData();
            _loc1_.var_3512 = this.var_3512;
            _loc1_.var_3513 = this.var_3513;
            return (_loc1_);
        }

        public function set pos(param1:int):void
        {
            this.var_3512 = param1;
        }

        public function set imgId(param1:int):void
        {
            this.var_3513 = param1;
        }

        public function get pos():int
        {
            return (this.var_3512);
        }

        public function get imgId():int
        {
            return (this.var_3513);
        }


    }
}