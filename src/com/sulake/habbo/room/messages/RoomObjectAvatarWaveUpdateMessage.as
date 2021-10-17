package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarWaveUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3798:Boolean = false;

        public function RoomObjectAvatarWaveUpdateMessage(param1:Boolean=false)
        {
            this.var_3798 = param1;
        }

        public function get isWaving():Boolean
        {
            return (this.var_3798);
        }


    }
}