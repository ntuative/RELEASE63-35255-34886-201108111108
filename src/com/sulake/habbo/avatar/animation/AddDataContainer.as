package com.sulake.habbo.avatar.animation
{
    public class AddDataContainer 
    {

        private var _id:String;
        private var _align:String;
        private var _base:String;
        private var var_2861:String;
        private var var_1213:Number = 1;

        public function AddDataContainer(param1:XML)
        {
            this._id = String(param1.@id);
            this._align = String(param1.@align);
            this._base = String(param1.@base);
            this.var_2861 = String(param1.@ink);
            var _loc2_:String = String(param1.@blend);
            if (_loc2_.length > 0)
            {
                this.var_1213 = Number(_loc2_);
                if (this.var_1213 > 1)
                {
                    this.var_1213 = (this.var_1213 / 100);
                };
            };
        }

        public function get id():String
        {
            return (this._id);
        }

        public function get align():String
        {
            return (this._align);
        }

        public function get base():String
        {
            return (this._base);
        }

        public function get ink():String
        {
            return (this.var_2861);
        }

        public function get blend():Number
        {
            return (this.var_1213);
        }

        public function get isBlended():Boolean
        {
            return (!(this.var_1213 == 1));
        }


    }
}