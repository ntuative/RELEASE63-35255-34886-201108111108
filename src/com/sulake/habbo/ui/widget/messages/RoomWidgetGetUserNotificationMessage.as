package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetGetUserNotificationMessage extends RoomWidgetMessage 
    {

        public static const var_2285:String = "RWGSM_GET_NOTIFICATIONS";

        public function RoomWidgetGetUserNotificationMessage(param1:String=null)
        {
            super(((param1 != null) ? param1 : var_2285));
        }

    }
}