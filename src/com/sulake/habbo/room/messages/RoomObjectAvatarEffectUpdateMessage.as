package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarEffectUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_4494:int;
        private var var_3795:int;

        public function RoomObjectAvatarEffectUpdateMessage(param1:int=0, param2:int=0)
        {
            this.var_4494 = param1;
            this.var_3795 = param2;
        }

        public function get effect():int
        {
            return (this.var_4494);
        }

        public function get delayMilliSeconds():int
        {
            return (this.var_3795);
        }


    }
}