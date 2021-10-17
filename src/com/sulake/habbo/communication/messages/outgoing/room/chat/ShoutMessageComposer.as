package com.sulake.habbo.communication.messages.outgoing.room.chat
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ShoutMessageComposer implements IMessageComposer 
    {

        private var _text:String;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function ShoutMessageComposer(param1:String, param2:int=0, param3:int=0)
        {
            this._text = param1;
            this._roomId = param2;
            this._roomCategory = param3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this._text]);
        }


    }
}