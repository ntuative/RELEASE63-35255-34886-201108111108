package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetDimmerPreviewMessage extends RoomWidgetMessage 
    {

        public static const var_2321:String = "RWDPM_PREVIEW_DIMMER_PRESET";

        private var _color:uint;
        private var var_4480:int;
        private var var_4486:Boolean;

        public function RoomWidgetDimmerPreviewMessage(param1:uint, param2:int, param3:Boolean)
        {
            super(var_2321);
            this._color = param1;
            this.var_4480 = param2;
            this.var_4486 = param3;
        }

        public function get color():uint
        {
            return (this._color);
        }

        public function get brightness():int
        {
            return (this.var_4480);
        }

        public function get bgOnly():Boolean
        {
            return (this.var_4486);
        }


    }
}