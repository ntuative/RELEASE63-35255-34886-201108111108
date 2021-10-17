package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SecretKeyMessageParser implements IMessageParser 
    {

        protected var var_3677:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3677 = param1.readString();
            return (true);
        }

        public function get serverPublicKey():String
        {
            return (this.var_3677);
        }


    }
}