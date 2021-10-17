package com.sulake.habbo.communication.messages.outgoing.room.chat
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ChatMessageComposer implements IMessageComposer 
    {

        private var _text:String;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_3604:int = 0;

        public function ChatMessageComposer(param1:String, param2:int=-1, param3:int=0, param4:int=0)
        {
            this._text = param1;
            this._roomId = param3;
            this._roomCategory = param4;
            this.var_3604 = param2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this._text, this.var_3604]);
        }


    }
}