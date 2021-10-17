package com.sulake.habbo.communication.messages.outgoing.room.session
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class OpenConnectionMessageComposer implements IMessageComposer 
    {

        private var _roomId:int;
        private var var_3616:Boolean;
        private var var_3617:int;

        public function OpenConnectionMessageComposer(param1:Boolean, param2:int, param3:int=0)
        {
            this._roomId = param2;
            this.var_3616 = param1;
            this.var_3617 = param3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([int(this.var_3616), this._roomId, this.var_3617]);
        }


    }
}