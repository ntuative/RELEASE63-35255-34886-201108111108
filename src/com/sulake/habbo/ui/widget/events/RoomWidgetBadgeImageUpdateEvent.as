package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetBadgeImageUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1705:String = "RWBIUE_BADGE_IMAGE";

        private var var_3772:String;
        private var var_5237:BitmapData;

        public function RoomWidgetBadgeImageUpdateEvent(param1:String, param2:BitmapData, param3:Boolean=false, param4:Boolean=false)
        {
            super(var_1705, param3, param4);
            this.var_3772 = param1;
            this.var_5237 = param2;
        }

        public function get badgeID():String
        {
            return (this.var_3772);
        }

        public function get badgeImage():BitmapData
        {
            return (this.var_5237);
        }


    }
}