package com.sulake.habbo.communication.messages.outgoing.marketplace
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class MakeOfferMessageComposer implements IMessageComposer, IDisposable 
    {

        public static const var_2087:int = 1;
        public static const var_2088:int = 2;

        private var var_2493:Array = new Array();

        public function MakeOfferMessageComposer(param1:int, param2:int, param3:int)
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