package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.VoucherRedeemErrorMessageParser;

    public class VoucherRedeemErrorMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function VoucherRedeemErrorMessageEvent(param1:Function)
        {
            super(param1, VoucherRedeemErrorMessageParser);
        }

        public function get errorCode():String
        {
            return ((var_334 as VoucherRedeemErrorMessageParser).errorCode);
        }


    }
}