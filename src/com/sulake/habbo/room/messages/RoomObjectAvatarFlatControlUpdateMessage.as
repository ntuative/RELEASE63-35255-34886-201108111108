package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarFlatControlUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_4496:Boolean = false;
        private var var_4497:String;

        public function RoomObjectAvatarFlatControlUpdateMessage(param1:String)
        {
            this.var_4497 = param1;
            if (((!(param1 == null)) && (!(param1.indexOf("useradmin") == -1))))
            {
                this.var_4496 = true;
            };
        }

        public function get isAdmin():Boolean
        {
            return (this.var_4496);
        }

        public function get rawData():String
        {
            return (this.var_4497);
        }


    }
}