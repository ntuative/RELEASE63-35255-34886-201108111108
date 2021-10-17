package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubOfferData 
    {

        private var var_3082:int;
        private var var_3083:String;
        private var var_3084:int;
        private var _upgrade:Boolean;
        private var var_3085:Boolean;
        private var var_3086:int;
        private var var_3087:int;
        private var var_3088:int;
        private var var_3089:int;
        private var var_3090:int;

        public function ClubOfferData(param1:IMessageDataWrapper)
        {
            this.var_3082 = param1.readInteger();
            this.var_3083 = param1.readString();
            this.var_3084 = param1.readInteger();
            this._upgrade = param1.readBoolean();
            this.var_3085 = param1.readBoolean();
            this.var_3086 = param1.readInteger();
            this.var_3087 = param1.readInteger();
            this.var_3088 = param1.readInteger();
            this.var_3089 = param1.readInteger();
            this.var_3090 = param1.readInteger();
        }

        public function get offerId():int
        {
            return (this.var_3082);
        }

        public function get productCode():String
        {
            return (this.var_3083);
        }

        public function get price():int
        {
            return (this.var_3084);
        }

        public function get upgrade():Boolean
        {
            return (this._upgrade);
        }

        public function get vip():Boolean
        {
            return (this.var_3085);
        }

        public function get periods():int
        {
            return (this.var_3086);
        }

        public function get daysLeftAfterPurchase():int
        {
            return (this.var_3087);
        }

        public function get year():int
        {
            return (this.var_3088);
        }

        public function get month():int
        {
            return (this.var_3089);
        }

        public function get day():int
        {
            return (this.var_3090);
        }


    }
}