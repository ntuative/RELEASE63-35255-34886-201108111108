package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarExperienceUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3834:int;

        public function RoomObjectAvatarExperienceUpdateMessage(param1:int)
        {
            this.var_3834 = param1;
        }

        public function get gainedExperience():int
        {
            return (this.var_3834);
        }


    }
}