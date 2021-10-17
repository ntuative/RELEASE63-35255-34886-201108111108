package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InitCryptoMessageParser implements IMessageParser 
    {

        protected var var_3675:Boolean;
        protected var var_3676:Boolean;
        protected var var_3354:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3354 = param1.readString();
            var _loc2_:int = param1.readInteger();
            this.var_3676 = ((_loc2_ > 0) ? true : false);
            return (true);
        }

        public function get token():String
        {
            return (this.var_3354);
        }

        public function get isServerEncrypted():Boolean
        {
            return (this.var_3676);
        }

        public function get isClientEncrypted():Boolean
        {
            return (this.var_3675);
        }


    }
}