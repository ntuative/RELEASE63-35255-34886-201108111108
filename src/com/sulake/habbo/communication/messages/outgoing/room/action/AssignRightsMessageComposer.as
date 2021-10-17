package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class AssignRightsMessageComposer implements IMessageComposer 
    {

        private var _userId:int;

        public function AssignRightsMessageComposer(param1:int)
        {
            this._userId = param1;
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