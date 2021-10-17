package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UniqueMachineIDParser implements IMessageParser 
    {

        private var var_3592:String;

        public function UniqueMachineIDParser()
        {
            this.var_3592 = "";
        }

        public function flush():Boolean
        {
            this.var_3592 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3592 = param1.readString();
            return (true);
        }

        public function get machineID():String
        {
            return (this.var_3592);
        }


    }
}