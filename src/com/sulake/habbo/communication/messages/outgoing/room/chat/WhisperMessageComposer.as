package com.sulake.habbo.communication.messages.outgoing.room.chat
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class WhisperMessageComposer implements IMessageComposer 
    {

        private var _text:String;
        private var var_3605:String;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function WhisperMessageComposer(param1:String, param2:String, param3:int=0, param4:int=0)
        {
            this.var_3605 = param1;
            this._text = param2;
            this._roomId = param3;
            this._roomCategory = param4;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            var _loc1_:String = ((this.var_3605 + " ") + this._text);
            return ([_loc1_]);
        }


    }
}