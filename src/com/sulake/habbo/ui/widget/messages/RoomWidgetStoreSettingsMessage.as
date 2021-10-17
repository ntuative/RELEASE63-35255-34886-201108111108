package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetStoreSettingsMessage extends RoomWidgetMessage 
    {

        public static const var_2271:String = "RWSSM_STORE_SETTINGS";
        public static const var_2272:String = "RWSSM_STORE_SOUND";
        public static const var_2273:String = "RWSSM_PREVIEW_SOUND";

        private var var_3858:Number;

        public function RoomWidgetStoreSettingsMessage(param1:String)
        {
            super(param1);
        }

        public function get volume():Number
        {
            return (this.var_3858);
        }

        public function set volume(param1:Number):void
        {
            this.var_3858 = param1;
        }


    }
}