package com.sulake.habbo.avatar.structure.figure
{
    import flash.utils.Dictionary;

    public class Palette implements IPalette 
    {

        private var _id:int;
        private var _colors:Dictionary;

        public function Palette(param1:XML)
        {
            this._id = parseInt(param1.@id);
            this._colors = new Dictionary();
            this.append(param1);
        }

        public function append(param1:XML):void
        {
            var _loc2_:XML;
            for each (_loc2_ in param1.color)
            {
                this._colors[String(_loc2_.@id)] = new PartColor(_loc2_);
            };
        }

        public function get id():int
        {
            return (this._id);
        }

        public function getColor(param1:int):IPartColor
        {
            return (this._colors[String(param1)]);
        }

        public function get colors():Dictionary
        {
            return (this._colors);
        }


    }
}