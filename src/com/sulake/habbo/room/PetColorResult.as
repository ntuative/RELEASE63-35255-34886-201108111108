package com.sulake.habbo.room
{
    public class PetColorResult 
    {

        private var var_4880:int = 0;
        private var var_4881:int = 0;

        public function PetColorResult(param1:int, param2:int)
        {
            this.var_4880 = (param1 & 0xFFFFFF);
            this.var_4881 = (param2 & 0xFFFFFF);
        }

        public function get primaryColor():int
        {
            return (this.var_4880);
        }

        public function get secondaryColor():int
        {
            return (this.var_4881);
        }


    }
}