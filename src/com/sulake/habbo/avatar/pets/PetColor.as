package com.sulake.habbo.avatar.pets
{
    import flash.geom.ColorTransform;

    public class PetColor extends PetEditorInfo implements IPetColor 
    {

        private var _id:int;
        private var _rgb:uint;
        private var var_2877:uint;
        private var var_2878:uint;
        private var _b:uint;
        private var var_2726:ColorTransform;
        private var var_2879:Number;
        private var var_2880:Number;
        private var var_2881:Number;
        private var var_2970:int;

        public function PetColor(param1:XML)
        {
            super(param1);
            this._id = parseInt(param1.@id);
            var _loc2_:String = param1.text();
            this._rgb = parseInt(_loc2_, 16);
            this.var_2877 = ((this._rgb >> 16) & 0xFF);
            this.var_2878 = ((this._rgb >> 8) & 0xFF);
            this._b = ((this._rgb >> 0) & 0xFF);
            this.var_2879 = ((this.var_2877 / 0xFF) * 1);
            this.var_2880 = ((this.var_2878 / 0xFF) * 1);
            this.var_2881 = ((this._b / 0xFF) * 1);
            this.var_2726 = new ColorTransform(this.var_2879, this.var_2880, this.var_2881);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get rgb():uint
        {
            return (this._rgb);
        }

        public function get r():uint
        {
            return (this.var_2877);
        }

        public function get g():uint
        {
            return (this.var_2878);
        }

        public function get b():uint
        {
            return (this._b);
        }

        public function get colorTransform():ColorTransform
        {
            return (this.var_2726);
        }

        public function get figurePartPaletteColorId():int
        {
            return (this.var_2970);
        }

        public function set figurePartPaletteColorId(param1:int):void
        {
            this.var_2970 = param1;
        }


    }
}