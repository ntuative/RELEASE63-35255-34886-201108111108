package com.sulake.habbo.avatar.structure.figure
{
    import flash.geom.ColorTransform;

    public class PartColor implements IPartColor 
    {

        private var _id:int;
        private var _index:int;
        private var _clubLevel:int;
        private var var_2976:Boolean = false;
        private var _rgb:uint;
        private var var_2877:uint;
        private var var_2878:uint;
        private var _b:uint;
        private var var_2879:Number;
        private var var_2880:Number;
        private var var_2881:Number;
        private var var_2726:ColorTransform;

        public function PartColor(param1:XML)
        {
            this._id = parseInt(param1.@id);
            this._index = parseInt(param1.@index);
            this._clubLevel = parseInt(param1.@club);
            this.var_2976 = Boolean(parseInt(param1.@selectable));
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

        public function get colorTransform():ColorTransform
        {
            return (this.var_2726);
        }

        public function get redMultiplier():Number
        {
            return (this.var_2879);
        }

        public function get greenMultiplier():Number
        {
            return (this.var_2880);
        }

        public function get blueMultiplier():Number
        {
            return (this.var_2881);
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

        public function get id():int
        {
            return (this._id);
        }

        public function get index():int
        {
            return (this._index);
        }

        public function get clubLevel():int
        {
            return (this._clubLevel);
        }

        public function get isSelectable():Boolean
        {
            return (this.var_2976);
        }


    }
}