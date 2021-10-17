package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetHabboGroupDetailsMessageComposer implements IMessageComposer 
    {

        private var _data:Array = [];

        public function GetHabboGroupDetailsMessageComposer(param1:int)
        {
            this._data.push(param1);
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