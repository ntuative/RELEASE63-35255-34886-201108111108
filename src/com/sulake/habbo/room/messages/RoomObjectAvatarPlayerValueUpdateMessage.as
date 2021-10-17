package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPlayerValueUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_2605:int;

        public function RoomObjectAvatarPlayerValueUpdateMessage(param1:int)
        {
            this.var_2605 = param1;
        }

        public function get value():int
        {
            return (this.var_2605);
        }


    }
}