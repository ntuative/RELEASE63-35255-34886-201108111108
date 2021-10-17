package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class AddSpamWallPostItMessageComposer implements IMessageComposer 
    {

        private var var_3608:int;
        private var var_2957:String;
        private var _message:String;

        public function AddSpamWallPostItMessageComposer(param1:int, param2:String, param3:String)
        {
            this.var_3608 = param1;
            this.var_2957 = param2;
            this._message = param3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3608, this.var_2957, this._message]);
        }


    }
}