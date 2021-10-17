package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.VoucherRedeemOkMessageParser;

    public class VoucherRedeemOkMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function VoucherRedeemOkMessageEvent(param1:Function)
        {
            super(param1, VoucherRedeemOkMessageParser);
        }

        public function get productName():String
        {
            return ((var_334 as VoucherRedeemOkMessageParser).productName);
        }

        public function get productDescription():String
        {
            return ((var_334 as VoucherRedeemOkMessageParser).productDescription);
        }


    }
}