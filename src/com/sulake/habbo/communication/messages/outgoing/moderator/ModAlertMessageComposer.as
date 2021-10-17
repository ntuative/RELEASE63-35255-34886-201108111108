package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class ModAlertMessageComposer implements IMessageComposer, IDisposable 
    {

        private var var_2493:Array = new Array();

        public function ModAlertMessageComposer(param1:int, param2:String, param3:String)
        {
            this.var_2493.push(param1);
            this.var_2493.push(param2);
            this.var_2493.push(param3);
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