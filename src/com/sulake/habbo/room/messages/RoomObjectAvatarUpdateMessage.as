package com.sulake.habbo.room.messages
{
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectAvatarUpdateMessage extends RoomObjectMoveUpdateMessage 
    {

        private var var_3558:int;

        public function RoomObjectAvatarUpdateMessage(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:int)
        {
            super(param1, param2, param3);
            this.var_3558 = param4;
        }

        public function get dirHead():int
        {
            return (this.var_3558);
        }


    }
}