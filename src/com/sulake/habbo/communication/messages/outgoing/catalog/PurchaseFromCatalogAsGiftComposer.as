package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PurchaseFromCatalogAsGiftComposer implements IMessageComposer 
    {

        private var _data:Array = [];

        public function PurchaseFromCatalogAsGiftComposer(param1:int, param2:int, param3:String, param4:String, param5:String, param6:int, param7:int, param8:int)
        {
            this._data.push(param1);
            this._data.push(param2);
            this._data.push(param3);
            this._data.push(param4);
            this._data.push(param5);
            this._data.push(param6);
            this._data.push(param7);
            this._data.push(param8);
        }

        public function dispose():void
        {
            this._data = [];
        }

        public function getMessageArray():Array
        {
            return (this._data);
        }


    }
}