package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class LagWarningReportMessageComposer implements IMessageComposer 
    {

        private var var_3620:int;

        public function LagWarningReportMessageComposer(param1:int)
        {
            this.var_3620 = param1;
        }

        public function getMessageArray():Array
        {
            return ([this.var_3620]);
        }

        public function dispose():void
        {
        }


    }
}