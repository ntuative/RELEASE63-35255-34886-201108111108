package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetHabboGroupsWhereMemberMessageComposer implements IMessageComposer 
    {

        private var _data:Array = [];


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