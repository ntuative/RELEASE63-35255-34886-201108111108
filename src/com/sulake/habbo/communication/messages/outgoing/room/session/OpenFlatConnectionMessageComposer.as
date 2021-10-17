package com.sulake.habbo.communication.messages.outgoing.room.session
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class OpenFlatConnectionMessageComposer implements IMessageComposer 
    {

        private var _message:Array;

        public function OpenFlatConnectionMessageComposer(param1:int, param2:String="", param3:int=-1)
        {
            this._message = [param1, param2, param3];
        }

        public function dispose():void
        {
            this._message = null;
        }

        public function getMessageArray():Array
        {
            return (this._message);
        }


    }
}