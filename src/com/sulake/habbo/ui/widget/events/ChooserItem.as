package com.sulake.habbo.ui.widget.events
{
    public class ChooserItem 
    {

        private var _id:int;
        private var _category:int;
        private var _name:String;

        public function ChooserItem(param1:int, param2:int, param3:String)
        {
            this._id = param1;
            this._category = param2;
            this._name = param3;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get category():int
        {
            return (this._category);
        }

        public function get name():String
        {
            return (this._name);
        }


    }
}