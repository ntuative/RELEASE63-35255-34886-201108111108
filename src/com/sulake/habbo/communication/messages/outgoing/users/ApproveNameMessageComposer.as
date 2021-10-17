package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ApproveNameMessageComposer implements IMessageComposer 
    {

        private var _name:String;
        private var _type:int;

        public function ApproveNameMessageComposer(param1:String, param2:int)
        {
            this._name = param1;
            this._type = param2;
        }

        public function getMessageArray():Array
        {
            return ([this._name, this._type]);
        }

        public function dispose():void
        {
        }


    }
}