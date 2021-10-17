package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetSellablePetBreedsComposer implements IMessageComposer 
    {

        private var _data:Array = [];

        public function GetSellablePetBreedsComposer(param1:String)
        {
            this._data = [param1];
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