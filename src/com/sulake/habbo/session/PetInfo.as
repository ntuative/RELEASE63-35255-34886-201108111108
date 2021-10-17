package com.sulake.habbo.session
{
    public class PetInfo implements IPetInfo 
    {

        private var var_3606:int;
        private var var_3416:int;
        private var var_4987:int;
        private var var_3836:int;
        private var var_4988:int;
        private var _energy:int;
        private var var_4989:int;
        private var _nutrition:int;
        private var var_4990:int;
        private var var_3468:int;
        private var _ownerName:String;
        private var var_3840:int;
        private var var_3841:int;


        public function get petId():int
        {
            return (this.var_3606);
        }

        public function get level():int
        {
            return (this.var_3416);
        }

        public function get levelMax():int
        {
            return (this.var_4987);
        }

        public function get experience():int
        {
            return (this.var_3836);
        }

        public function get experienceMax():int
        {
            return (this.var_4988);
        }

        public function get energy():int
        {
            return (this._energy);
        }

        public function get energyMax():int
        {
            return (this.var_4989);
        }

        public function get nutrition():int
        {
            return (this._nutrition);
        }

        public function get nutritionMax():int
        {
            return (this.var_4990);
        }

        public function get ownerId():int
        {
            return (this.var_3468);
        }

        public function get ownerName():String
        {
            return (this._ownerName);
        }

        public function get respect():int
        {
            return (this.var_3840);
        }

        public function get age():int
        {
            return (this.var_3841);
        }

        public function set petId(param1:int):void
        {
            this.var_3606 = param1;
        }

        public function set level(param1:int):void
        {
            this.var_3416 = param1;
        }

        public function set levelMax(param1:int):void
        {
            this.var_4987 = param1;
        }

        public function set experience(param1:int):void
        {
            this.var_3836 = param1;
        }

        public function set experienceMax(param1:int):void
        {
            this.var_4988 = param1;
        }

        public function set energy(param1:int):void
        {
            this._energy = param1;
        }

        public function set energyMax(param1:int):void
        {
            this.var_4989 = param1;
        }

        public function set nutrition(param1:int):void
        {
            this._nutrition = param1;
        }

        public function set nutritionMax(param1:int):void
        {
            this.var_4990 = param1;
        }

        public function set ownerId(param1:int):void
        {
            this.var_3468 = param1;
        }

        public function set ownerName(param1:String):void
        {
            this._ownerName = param1;
        }

        public function set respect(param1:int):void
        {
            this.var_3840 = param1;
        }

        public function set age(param1:int):void
        {
            this.var_3841 = param1;
        }


    }
}