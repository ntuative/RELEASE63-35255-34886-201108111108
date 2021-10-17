package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PurchaseVipMembershipExtensionComposer implements IMessageComposer 
    {

        private var _data:Array = [];

        public function PurchaseVipMembershipExtensionComposer(param1:int)
        {
            this._data.push(param1);
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return (this._data);
        }


    }
}