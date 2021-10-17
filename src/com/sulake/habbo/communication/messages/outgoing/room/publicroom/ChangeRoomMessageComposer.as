package com.sulake.habbo.communication.messages.outgoing.room.publicroom
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ChangeRoomMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_3498:int = 0;

        public function ChangeRoomMessageComposer(param1:int, param2:int=0, param3:int=0)
        {
            this._roomId = param2;
            this._roomCategory = param3;
            this.var_3498 = param1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3498]);
        }


    }
}