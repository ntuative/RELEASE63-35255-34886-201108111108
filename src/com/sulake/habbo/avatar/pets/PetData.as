package com.sulake.habbo.avatar.pets
{
    public class PetData implements IPetData 
    {

        private var _name:String;
        private var var_2972:int;
        private var _disableHeadTurn:Boolean = false;
        private var _scale:String;
        private var _colors:Array;
        private var _breeds:Array;
        private var var_2971:Array;

        public function PetData(param1:XML)
        {
            var _loc2_:XML;
            var _loc3_:XML;
            var _loc4_:XML;
            var _loc5_:IBreed;
            super();
            this._name = param1.@name;
            this.var_2972 = parseInt(param1.@species);
            this._disableHeadTurn = Boolean(parseInt(param1.@disableheadturn));
            this._scale = param1.@scale;
            this._colors = new Array();
            this._breeds = new Array();
            this.var_2971 = new Array();
            Logger.log(("Found Pet Pack: " + this._name));
            for each (_loc2_ in param1.breeds.breed)
            {
                _loc5_ = new Breed(_loc2_);
                this._breeds.push(_loc5_);
                if (_loc5_.isSellable)
                {
                    this.var_2971.push(_loc5_);
                };
            };
            for each (_loc3_ in param1.colors.color)
            {
                this._colors.push(new PetColor(_loc3_));
            };
            for each (_loc4_ in param1.joints.joint)
            {
            };
        }

        public function findColor(param1:uint):PetColor
        {
            var _loc2_:PetColor;
            for each (var _loc5_:* in this._colors)
            {
                _loc2_ = _loc5_;
                _loc5_;
                if (_loc2_.rgb == param1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }

        public function findBreed(param1:int):Breed
        {
            var _loc2_:Breed;
            for each (var _loc5_:* in this._breeds)
            {
                _loc2_ = _loc5_;
                _loc5_;
                if (_loc2_.id == param1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get species():int
        {
            return (this.var_2972);
        }

        public function get scale():String
        {
            return (this._scale);
        }

        public function get colors():Array
        {
            return (this._colors);
        }

        public function get breeds():Array
        {
            return (this._breeds);
        }

        public function get sellableBreeds():Array
        {
            return (this.var_2971);
        }

        public function get disableHeadTurn():Boolean
        {
            return (this._disableHeadTurn);
        }


    }
}