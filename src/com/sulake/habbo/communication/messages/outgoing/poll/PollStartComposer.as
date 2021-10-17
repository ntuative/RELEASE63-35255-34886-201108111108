package com.sulake.habbo.communication.messages.outgoing.poll
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PollStartComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function PollStartComposer(param1:int)
        {
            this._data = [param1];
        }

        public function getMessageArray():Array
        {
            return (this._data);
        }

        public function dispose():void
        {
            this._data = null;
        }


    }
}