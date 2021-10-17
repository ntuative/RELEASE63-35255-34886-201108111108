package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RemoveItemMessageComposer implements IMessageComposer 
    {

        private var var_1678:int;
        private var _roomId:int;
        private var _roomCategory:int;

        public function RemoveItemMessageComposer(param1:int, param2:int=0, param3:int=0)
        {
            this.var_1678 = param1;
            this._roomId = param2;
            this._roomCategory = param3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_1678]);
        }


    }
}