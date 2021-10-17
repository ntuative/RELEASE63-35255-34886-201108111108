package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarUseObjectUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3428:int;

        public function RoomObjectAvatarUseObjectUpdateMessage(param1:int)
        {
            this.var_3428 = param1;
        }

        public function get itemType():int
        {
            return (this.var_3428);
        }


    }
}