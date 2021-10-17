package com.sulake.habbo.communication.messages.outgoing.room.chat
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class CancelTypingMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function CancelTypingMessageComposer(param1:int=0, param2:int=0)
        {
            this._roomId = param1;
            this._roomCategory = param2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([]);
        }


    }
}