package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetOpenCatalogMessage extends RoomWidgetMessage 
    {

        public static const var_2262:String = "RWGOI_MESSAGE_OPEN_CATALOG";
        public static const var_2276:String = "RWOCM_CLUB_MAIN";
        public static const var_2520:String = "RWOCM_PIXELS";
        public static const var_2521:String = "RWOCM_CREDITS";
        public static const var_2522:String = "RWOCM_SHELLS";

        private var var_5382:String = "";

        public function RoomWidgetOpenCatalogMessage(param1:String)
        {
            super(var_2262);
            this.var_5382 = param1;
        }

        public function get pageKey():String
        {
            return (this.var_5382);
        }


    }
}