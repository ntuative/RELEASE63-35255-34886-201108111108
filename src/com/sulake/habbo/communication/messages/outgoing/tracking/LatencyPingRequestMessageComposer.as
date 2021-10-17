package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class LatencyPingRequestMessageComposer implements IMessageComposer 
    {

        private var _id:int = 0;

        public function LatencyPingRequestMessageComposer(param1:int)
        {
            this._id = param1;
        }

        public function getMessageArray():Array
        {
            return ([this._id]);
        }

        public function dispose():void
        {
        }


    }
}