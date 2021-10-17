package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarCarryObjectUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3428:int;
        private var var_3796:String;

        public function RoomObjectAvatarCarryObjectUpdateMessage(param1:int, param2:String)
        {
            this.var_3428 = param1;
            this.var_3796 = param2;
        }

        public function get itemType():int
        {
            return (this.var_3428);
        }

        public function get itemName():String
        {
            return (this.var_3796);
        }


    }
}