package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarDanceUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _danceStyle:int;

        public function RoomObjectAvatarDanceUpdateMessage(param1:int=0)
        {
            this._danceStyle = param1;
        }

        public function get danceStyle():int
        {
            return (this._danceStyle);
        }


    }
}