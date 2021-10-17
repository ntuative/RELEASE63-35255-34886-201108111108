package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarTypingUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3803:Boolean;

        public function RoomObjectAvatarTypingUpdateMessage(param1:Boolean=false)
        {
            this.var_3803 = param1;
        }

        public function get isTyping():Boolean
        {
            return (this.var_3803);
        }


    }
}