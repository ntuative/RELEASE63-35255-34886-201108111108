package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarSignUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_4499:int;

        public function RoomObjectAvatarSignUpdateMessage(param1:int)
        {
            this.var_4499 = param1;
        }

        public function get var_1087():int
        {
            return (this.var_4499);
        }


    }
}