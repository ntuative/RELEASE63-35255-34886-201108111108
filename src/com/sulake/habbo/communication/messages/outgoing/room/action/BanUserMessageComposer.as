package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class BanUserMessageComposer implements IMessageComposer 
    {

        private var _userId:int;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function BanUserMessageComposer(param1:int, param2:int=0, param3:int=0)
        {
            this._userId = param1;
            this._roomId = param2;
            this._roomCategory = param3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this._userId]);
        }


    }
}