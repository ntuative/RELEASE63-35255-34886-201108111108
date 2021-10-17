package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDimmerUpdateEventPresetItem 
    {

        private var _id:int = 0;
        private var _type:int = 0;
        private var _color:uint = 0;
        private var var_3560:uint = 0;

        public function RoomWidgetDimmerUpdateEventPresetItem(param1:int, param2:int, param3:uint, param4:uint)
        {
            this._id = param1;
            this._type = param2;
            this._color = param3;
            this.var_3560 = param4;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get color():uint
        {
            return (this._color);
        }

        public function get light():int
        {
            return (this.var_3560);
        }


    }
}