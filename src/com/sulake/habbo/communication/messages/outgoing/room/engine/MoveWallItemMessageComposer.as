package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class MoveWallItemMessageComposer implements IMessageComposer 
    {

        private var _data:Array = [];

        public function MoveWallItemMessageComposer(param1:int, param2:int, param3:String, param4:int=0, param5:int=0)
        {
            this._data.push(param1);
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