package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import flash.utils.getTimer;

    public class SSOTicketMessageComposer implements IMessageComposer 
    {

        private var _message:Array;

        public function SSOTicketMessageComposer(param1:String)
        {
            this._message = new Array();
            this._message.push(param1);
            this._message.push(getTimer());
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return (this._message);
        }


    }
}