package com.sulake.room.messages
{
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectUpdateMessage 
    {

        protected var var_3543:IVector3d;
        protected var var_3536:IVector3d;

        public function RoomObjectUpdateMessage(param1:IVector3d, param2:IVector3d)
        {
            this.var_3543 = param1;
            this.var_3536 = param2;
        }

        public function get loc():IVector3d
        {
            return (this.var_3543);
        }

        public function get dir():IVector3d
        {
            return (this.var_3536);
        }


    }
}