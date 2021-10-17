package com.sulake.habbo.room.object
{
    public class RoomStairData 
    {

        private var var_4842:int;
        private var var_4843:Boolean;
        private var var_4844:Boolean;
        private var var_2392:Boolean;

        public function RoomStairData(param1:int, param2:Boolean, param3:Boolean, param4:Boolean)
        {
            this.var_2392 = param4;
            this.var_4842 = param1;
            this.var_4843 = param2;
            this.var_4844 = param3;
        }

        public function get stairHeight():int
        {
            return (this.var_4842);
        }

        public function get neighbourStairMin():Boolean
        {
            return (this.var_4843);
        }

        public function get neighbourStairMax():Boolean
        {
            return (this.var_4844);
        }

        public function get neighbourStair():Boolean
        {
            return ((this.var_4843) || (this.var_4844));
        }

        public function get border():Boolean
        {
            return (this.var_2392);
        }


    }
}