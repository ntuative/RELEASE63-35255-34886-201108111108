package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetEcotronBoxOpenedMessage extends RoomWidgetMessage 
    {

        public static const var_2281:String = "RWEBOM_ECOTRONBOX_OPENED";

        private var var_3428:String;
        private var var_3429:int;

        public function RoomWidgetEcotronBoxOpenedMessage(param1:String, param2:String, param3:int)
        {
            super(param1);
            this.var_3428 = param2;
            this.var_3429 = param3;
        }

        public function get itemType():String
        {
            return (this.var_3428);
        }

        public function get classId():int
        {
            return (this.var_3429);
        }


    }
}