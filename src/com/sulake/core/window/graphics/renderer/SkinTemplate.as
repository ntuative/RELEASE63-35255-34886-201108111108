package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.utils.ChildEntityArray;
    import com.sulake.core.assets.IAsset;

    public class SkinTemplate extends ChildEntityArray implements ISkinTemplate 
    {

        protected var _name:String;
        protected var var_1209:Array;
        protected var var_2736:IAsset;

        public function SkinTemplate(param1:String, param2:IAsset)
        {
            this._name = param1;
            this.var_1209 = new Array();
            this.var_2736 = param2;
        }

        public function get id():uint
        {
            return (0);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get tags():Array
        {
            return (this.var_1209);
        }

        public function get asset():IAsset
        {
            return (this.var_2736);
        }

        public function dispose():void
        {
            var _loc2_:uint;
            var _loc1_:uint = this.numChildren;
            _loc2_ = 0;
            while (_loc2_ < _loc1_)
            {
                this.removeChildAt(0);
                _loc2_++;
            };
            this.var_2736 = null;
            this.var_1209 = null;
            this._name = null;
        }


    }
}