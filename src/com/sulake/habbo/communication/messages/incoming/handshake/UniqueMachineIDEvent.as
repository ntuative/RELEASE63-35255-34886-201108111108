package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UniqueMachineIDParser;

    public class UniqueMachineIDEvent extends MessageEvent implements IMessageEvent 
    {

        public function UniqueMachineIDEvent(param1:Function)
        {
            super(param1, UniqueMachineIDParser);
        }

        private function getParser():UniqueMachineIDParser
        {
            return (this.var_334 as UniqueMachineIDParser);
        }

        public function get machineID():String
        {
            return (this.getParser().machineID);
        }


    }
}