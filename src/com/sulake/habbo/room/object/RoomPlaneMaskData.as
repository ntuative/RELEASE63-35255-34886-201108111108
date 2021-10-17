package com.sulake.habbo.room.object
{
    public class RoomPlaneMaskData 
    {

        private var var_4809:Number = 0;
        private var var_4810:Number = 0;
        private var var_4811:Number = 0;
        private var var_4812:Number = 0;

        public function RoomPlaneMaskData(param1:Number, param2:Number, param3:Number, param4:Number)
        {
            this.var_4809 = param1;
            this.var_4810 = param2;
            this.var_4811 = param3;
            this.var_4812 = param4;
        }

        public function get leftSideLoc():Number
        {
            return (this.var_4809);
        }

        public function get rightSideLoc():Number
        {
            return (this.var_4810);
        }

        public function get leftSideLength():Number
        {
            return (this.var_4811);
        }

        public function get rightSideLength():Number
        {
            return (this.var_4812);
        }


    }
}