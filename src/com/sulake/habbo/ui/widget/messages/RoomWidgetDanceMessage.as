package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetDanceMessage extends RoomWidgetMessage 
    {

        public static const var_2256:String = "RWCM_MESSAGE_DANCE";
        public static const var_2374:int = 0;
        public static const var_2373:Array = [2, 3, 4];

        private var var_1206:int = 0;

        public function RoomWidgetDanceMessage(param1:int)
        {
            super(var_2256);
            this.var_1206 = param1;
        }

        public function get style():int
        {
            return (this.var_1206);
        }


    }
}