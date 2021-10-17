package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarSelectedMessage extends RoomObjectUpdateStateMessage 
    {

        private var _selected:Boolean;

        public function RoomObjectAvatarSelectedMessage(param1:Boolean)
        {
            this._selected = param1;
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }


    }
}