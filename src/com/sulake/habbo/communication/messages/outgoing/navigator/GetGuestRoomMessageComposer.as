package com.sulake.habbo.communication.messages.outgoing.navigator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetGuestRoomMessageComposer implements IMessageComposer, IDisposable 
    {

        private var var_2493:Array = new Array();

        public function GetGuestRoomMessageComposer(param1:int, param2:Boolean, param3:Boolean)
        {
            this.var_2493.push(param1);
            this.var_2493.push(((param2) ? 1 : 0));
            this.var_2493.push(((param3) ? 1 : 0));
        }

        public function getMessageArray():Array
        {
            return (this.var_2493);
        }

        public function dispose():void
        {
            this.var_2493 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}