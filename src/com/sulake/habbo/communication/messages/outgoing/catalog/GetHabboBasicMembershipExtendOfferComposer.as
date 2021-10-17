package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetHabboBasicMembershipExtendOfferComposer implements IMessageComposer, IDisposable 
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

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}