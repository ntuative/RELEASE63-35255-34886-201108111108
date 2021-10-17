package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class LatencyPingReportMessageComposer implements IMessageComposer 
    {

        private var var_3621:int;
        private var var_3622:int;
        private var var_3623:int;

        public function LatencyPingReportMessageComposer(param1:int, param2:int, param3:int)
        {
            this.var_3621 = param1;
            this.var_3622 = param2;
            this.var_3623 = param3;
        }

        public function getMessageArray():Array
        {
            return ([this.var_3621, this.var_3622, this.var_3623]);
        }

        public function dispose():void
        {
        }


    }
}