package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class MoveObjectMessageComposer implements IMessageComposer 
    {

        private var var_1678:int;
        private var _x:int;
        private var var_2960:int;
        private var _direction:int;
        private var _roomId:int;
        private var _roomCategory:int = 0;

        public function MoveObjectMessageComposer(param1:int, param2:int, param3:int, param4:int, param5:int=0, param6:int=0)
        {
            this.var_1678 = param1;
            this._x = param2;
            this.var_2960 = param3;
            this._direction = param4;
            this._roomId = param5;
            this._roomCategory = param6;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_1678, this._x, this.var_2960, this._direction]);
        }


    }
}