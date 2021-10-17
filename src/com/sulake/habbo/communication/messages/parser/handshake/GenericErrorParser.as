package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GenericErrorParser implements IMessageParser 
    {

        private var var_2550:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2550 = param1.readInteger();
            return (true);
        }

        public function get errorCode():int
        {
            return (this.var_2550);
        }


    }
}