package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPetGestureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3800:String;

        public function RoomObjectAvatarPetGestureUpdateMessage(param1:String)
        {
            this.var_3800 = param1;
        }

        public function get gesture():String
        {
            return (this.var_3800);
        }


    }
}