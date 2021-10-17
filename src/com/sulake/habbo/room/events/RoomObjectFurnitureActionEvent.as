package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectFurnitureActionEvent extends RoomObjectEvent 
    {

        public static const var_1043:String = "ROFCAE_DICE_OFF";
        public static const var_1042:String = "ROFCAE_DICE_ACTIVATE";
        public static const var_1050:String = "ROFCAE_USE_HABBOWHEEL";
        public static const var_1049:String = "ROFCAE_STICKIE";
        public static const var_1044:String = "ROFCAE_VIRAL_GIFT";
        public static const var_1084:String = "ROFCAE_ENTER_ONEWAYDOOR";
        public static const var_1076:String = "ROFCAE_QUEST_VENDING";
        public static const var_1054:String = "ROFCAE_SOUND_MACHINE_INIT";
        public static const var_1051:String = "ROFCAE_SOUND_MACHINE_START";
        public static const var_1052:String = "ROFCAE_SOUND_MACHINE_STOP";
        public static const var_1053:String = "ROFCAE_SOUND_MACHINE_DISPOSE";
        public static const var_1082:String = "ROFCAE_JUKEBOX_INIT";
        public static const var_1079:String = "ROFCAE_JUKEBOX_START";
        public static const var_1080:String = "ROFCAE_JUKEBOX_MACHINE_STOP";
        public static const var_1081:String = "ROFCAE_JUKEBOX_DISPOSE";
        public static const var_455:String = "ROFCAE_MOUSE_BUTTON";
        public static const var_1041:String = "ROFCAE_MOUSE_ARROW";

        public function RoomObjectFurnitureActionEvent(param1:String, param2:int, param3:String, param4:Boolean=false, param5:Boolean=false)
        {
            super(param1, param2, param3, param4, param5);
        }

    }
}