package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.IProductContainer;

    public class ClubBuyOfferData implements IPurchasableOffer 
    {

        private var var_3082:int;
        private var var_3083:String;
        private var var_3084:int;
        private var _upgrade:Boolean;
        private var var_3085:Boolean;
        private var var_3086:int;
        private var var_3087:int;
        private var var_3081:ICatalogPage;
        private var var_3088:int;
        private var var_3089:int;
        private var var_3090:int;
        private var var_3091:String;
        private var var_3092:Boolean = false;
        private var _disposed:Boolean = false;

        public function ClubBuyOfferData(param1:int, param2:String, param3:int, param4:Boolean, param5:Boolean, param6:int, param7:int, param8:int, param9:int, param10:int)
        {
            this.var_3082 = param1;
            this.var_3083 = param2;
            this.var_3084 = param3;
            this._upgrade = param4;
            this.var_3085 = param5;
            this.var_3086 = param6;
            this.var_3087 = param7;
            this.var_3088 = param8;
            this.var_3089 = param9;
            this.var_3090 = param10;
        }

        public function dispose():void
        {
            if (this.disposed)
            {
                return;
            };
            this._disposed = true;
            this.var_3081 = null;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get extraParameter():String
        {
            return (this.var_3091);
        }

        public function set extraParameter(param1:String):void
        {
            this.var_3091 = param1;
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

        public function get priceInActivityPoints():int
        {
            return (0);
        }

        public function get activityPointType():int
        {
            return (ActivityPointTypeEnum.PIXEL);
        }

        public function get priceInCredits():int
        {
            return (this.var_3084);
        }

        public function get page():ICatalogPage
        {
            return (this.var_3081);
        }

        public function get priceType():String
        {
            return (Offer.var_745);
        }

        public function get productContainer():IProductContainer
        {
            return (null);
        }

        public function get localizationId():String
        {
            return (this.var_3083);
        }

        public function set page(param1:ICatalogPage):void
        {
            this.var_3081 = param1;
        }

        public function get upgradeHcPeriodToVip():Boolean
        {
            return (this.var_3092);
        }

        public function set upgradeHcPeriodToVip(param1:Boolean):void
        {
            this.var_3092 = param1;
        }


    }
}