package com.sulake.habbo.communication.messages.outgoing.poll
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class VoteAnswerMessageComposer implements IMessageComposer 
    {

        private var _data:Array = [];

        public function VoteAnswerMessageComposer(param1:int)
        {
            this._data = [param1];
        }

        public function dispose():void
        {
            this._data = null;
        }

        public function getMessageArray():Array
        {
            return (this._data);
        }


    }
}