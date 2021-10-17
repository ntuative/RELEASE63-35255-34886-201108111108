package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class VersionCheckMessageComposer implements IMessageComposer 
    {

        private var var_3593:int;
        private var var_3366:String;
        private var var_3594:String;

        public function VersionCheckMessageComposer(param1:int, param2:String, param3:String)
        {
            this.var_3593 = param1;
            this.var_3366 = param2;
            this.var_3594 = param3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3593, this.var_3366, this.var_3594]);
        }


    }
}