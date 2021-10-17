package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_2994:String;
        private var var_4495:String;
        private var var_2938:String;

        public function RoomObjectAvatarFigureUpdateMessage(param1:String, param2:String=null, param3:String=null)
        {
            this.var_2994 = param1;
            this.var_2938 = param2;
            this.var_4495 = param3;
        }

        public function get figure():String
        {
            return (this.var_2994);
        }

        public function get race():String
        {
            return (this.var_4495);
        }

        public function get gender():String
        {
            return (this.var_2938);
        }


    }
}