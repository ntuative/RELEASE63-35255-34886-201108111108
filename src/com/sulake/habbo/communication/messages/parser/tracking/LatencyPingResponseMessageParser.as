package com.sulake.habbo.communication.messages.parser.tracking
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class LatencyPingResponseMessageParser implements IMessageParser 
    {

        private var var_3405:int;


        public function get requestId():int
        {
            return (this.var_3405);
        }

        public function flush():Boolean
        {
            this.var_3405 = -1;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3405 = param1.readInteger();
            return (true);
        }


    }
}