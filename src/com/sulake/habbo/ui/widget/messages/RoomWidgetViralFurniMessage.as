package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetViralFurniMessage extends RoomWidgetMessage 
    {

        public static const var_1601:String = "RWVFM_VIRAL_FOUND";
        public static const var_1602:String = "RWVFM_OPEN_PRESENT";

        private var var_1678:int;

        public function RoomWidgetViralFurniMessage(param1:String)
        {
            super(param1);
        }

        public function get objectId():int
        {
            return (this.var_1678);
        }

        public function set objectId(param1:int):void
        {
            this.var_1678 = param1;
        }


    }
}