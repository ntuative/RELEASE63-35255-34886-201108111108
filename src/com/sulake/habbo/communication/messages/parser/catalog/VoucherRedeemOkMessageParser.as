package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoucherRedeemOkMessageParser implements IMessageParser 
    {

        private var var_3226:String = "";
        private var var_3227:String = "";


        public function flush():Boolean
        {
            this.var_3227 = "";
            this.var_3226 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3227 = param1.readString();
            this.var_3226 = param1.readString();
            return (true);
        }

        public function get productName():String
        {
            return (this.var_3226);
        }

        public function get productDescription():String
        {
            return (this.var_3227);
        }


    }
}