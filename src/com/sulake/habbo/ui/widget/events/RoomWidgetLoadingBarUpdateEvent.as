package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetLoadingBarUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1537:String = "RWLBUE_SHOW_LOADING_BAR";
        public static const var_1559:String = "RWLBUW_HIDE_LOADING_BAR";

        public function RoomWidgetLoadingBarUpdateEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

    }
}