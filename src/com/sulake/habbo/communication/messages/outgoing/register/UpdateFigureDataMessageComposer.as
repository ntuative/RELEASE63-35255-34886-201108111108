package com.sulake.habbo.communication.messages.outgoing.register
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class UpdateFigureDataMessageComposer implements IMessageComposer 
    {

        private var _data:Array = [];

        public function UpdateFigureDataMessageComposer(param1:String, param2:String)
        {
            this._data.push(param2);
            this._data.push(param1);
        }

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