package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetCatalogPageComposer implements IMessageComposer 
    {

        private var _data:Array = [];

        public function GetCatalogPageComposer(param1:int, param2:int)
        {
            this._data.push(param1);
            this._data.push(param2);
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