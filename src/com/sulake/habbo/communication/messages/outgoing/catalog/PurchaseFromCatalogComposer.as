package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PurchaseFromCatalogComposer implements IMessageComposer 
    {

        private var _data:Array = [];

        public function PurchaseFromCatalogComposer(param1:int, param2:int, param3:String)
        {
            this._data.push(param1);
            this._data.push(param2);
            this._data.push(param3);
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