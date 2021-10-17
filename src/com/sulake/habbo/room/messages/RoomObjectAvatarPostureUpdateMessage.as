package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPostureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_4498:String;
        private var var_3194:String;

        public function RoomObjectAvatarPostureUpdateMessage(param1:String, param2:String="")
        {
            this.var_4498 = param1;
            this.var_3194 = param2;
        }

        public function get postureType():String
        {
            return (this.var_4498);
        }

        public function get parameter():String
        {
            return (this.var_3194);
        }


    }
}