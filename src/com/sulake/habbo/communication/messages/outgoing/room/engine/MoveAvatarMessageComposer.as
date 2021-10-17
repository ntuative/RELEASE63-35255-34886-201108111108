package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class MoveAvatarMessageComposer implements IMessageComposer 
    {

        private var _x:int;
        private var var_2960:int;
        private var _roomId:int;
        private var _roomCategory:int = 0;

        public function MoveAvatarMessageComposer(param1:int, param2:int, param3:int=0, param4:int=0)
        {
            this._x = param1;
            this.var_2960 = param2;
            this._roomId = param3;
            this._roomCategory = param4;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this._x, this.var_2960]);
        }


    }
}