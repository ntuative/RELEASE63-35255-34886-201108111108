package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SetItemDataMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_1678:int;
        private var _data:String;

        public function SetItemDataMessageComposer(param1:int, param2:String="", param3:int=0, param4:int=0)
        {
            this.var_1678 = param1;
            this._data = param2;
            this._roomId = param3;
            this._roomCategory = param4;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_1678, this._data]);
        }


    }
}