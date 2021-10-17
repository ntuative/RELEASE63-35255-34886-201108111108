package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PlacePetMessageComposer implements IMessageComposer 
    {

        private var var_3606:int;
        private var _x:int;
        private var var_2960:int;
        private var _roomId:int;
        private var _roomCategory:int;

        public function PlacePetMessageComposer(param1:int, param2:int, param3:int, param4:int=0, param5:int=0)
        {
            this.var_3606 = param1;
            this._x = param2;
            this.var_2960 = param3;
            this._roomId = param4;
            this._roomCategory = param5;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3606, this._x, this.var_2960]);
        }


    }
}