package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetDimmerSavePresetMessage extends RoomWidgetMessage 
    {

        public static const var_2319:String = "RWSDPM_SAVE_PRESET";

        private var var_3610:int;
        private var var_3611:int;
        private var _color:uint;
        private var var_4480:int;
        private var var_5378:Boolean;

        public function RoomWidgetDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean)
        {
            super(var_2319);
            this.var_3610 = param1;
            this.var_3611 = param2;
            this._color = param3;
            this.var_4480 = param4;
            this.var_5378 = param5;
        }

        public function get presetNumber():int
        {
            return (this.var_3610);
        }

        public function get effectTypeId():int
        {
            return (this.var_3611);
        }

        public function get color():uint
        {
            return (this._color);
        }

        public function get brightness():int
        {
            return (this.var_4480);
        }

        public function get apply():Boolean
        {
            return (this.var_5378);
        }


    }
}