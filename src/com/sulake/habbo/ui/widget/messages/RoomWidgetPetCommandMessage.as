package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPetCommandMessage extends RoomWidgetMessage 
    {

        public static const var_2309:String = "RWPCM_REQUEST_PET_COMMANDS";
        public static const var_2308:String = "RWPCM_PET_COMMAND";

        private var var_3606:int = 0;
        private var var_2605:String;

        public function RoomWidgetPetCommandMessage(param1:String, param2:int, param3:String=null)
        {
            super(param1);
            this.var_3606 = param2;
            this.var_2605 = param3;
        }

        public function get petId():int
        {
            return (this.var_3606);
        }

        public function get value():String
        {
            return (this.var_2605);
        }


    }
}