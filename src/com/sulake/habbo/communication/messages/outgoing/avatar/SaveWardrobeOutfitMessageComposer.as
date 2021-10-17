package com.sulake.habbo.communication.messages.outgoing.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SaveWardrobeOutfitMessageComposer implements IMessageComposer 
    {

        private var _data:Array = [];

        public function SaveWardrobeOutfitMessageComposer(param1:int, param2:String, param3:String)
        {
            this._data.push(param1);
            this._data.push(param2);
            this._data.push(param3);
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