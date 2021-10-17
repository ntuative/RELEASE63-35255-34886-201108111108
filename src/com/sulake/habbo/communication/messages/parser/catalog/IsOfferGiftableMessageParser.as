package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IsOfferGiftableMessageParser implements IMessageParser 
    {

        private var var_3082:int;
        private var var_3645:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3082 = param1.readInteger();
            this.var_3645 = param1.readBoolean();
            return (true);
        }

        public function get offerId():int
        {
            return (this.var_3082);
        }

        public function get isGiftable():Boolean
        {
            return (this.var_3645);
        }


    }
}