package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.product.IProductData;

    public class Offer implements IPurchasableOffer 
    {

        public static const var_812:String = "pricing_model_unknown";
        public static const var_813:String = "pricing_model_single";
        public static const var_814:String = "pricing_model_multi";
        public static const var_815:String = "pricing_model_bundle";
        public static const var_816:String = "price_type_none";
        public static const var_745:String = "price_type_credits";
        public static const var_817:String = "price_type_activitypoints";
        public static const var_818:String = "price_type_credits_and_activitypoints";

        private var var_3292:String;
        private var var_3293:String;
        private var var_3082:int;
        private var var_3294:String;
        private var var_3295:int;
        private var var_3296:int;
        private var var_3297:int;
        private var var_3081:ICatalogPage;
        private var var_3298:IProductContainer;
        private var _disposed:Boolean = false;
        private var _clubLevel:int = 0;
        private var var_3299:int;

        public function Offer(param1:int, param2:String, param3:int, param4:int, param5:int, param6:int, param7:Array, param8:ICatalogPage)
        {
            this.var_3082 = param1;
            this.var_3294 = param2;
            this.var_3295 = param3;
            this.var_3296 = param4;
            this.var_3297 = param5;
            this.var_3081 = param8;
            this._clubLevel = param6;
            this.analyzePricingModel(param7);
            this.analyzePriceType();
            this.createProductContainer(param7);
        }

        public function get clubLevel():int
        {
            return (this._clubLevel);
        }

        public function get page():ICatalogPage
        {
            return (this.var_3081);
        }

        public function get offerId():int
        {
            return (this.var_3082);
        }

        public function get localizationId():String
        {
            return (this.var_3294);
        }

        public function get priceInCredits():int
        {
            return (this.var_3295);
        }

        public function get priceInActivityPoints():int
        {
            return (this.var_3296);
        }

        public function get activityPointType():int
        {
            return (this.var_3297);
        }

        public function get productContainer():IProductContainer
        {
            return (this.var_3298);
        }

        public function get pricingModel():String
        {
            return (this.var_3292);
        }

        public function get priceType():String
        {
            return (this.var_3293);
        }

        public function get previewCallbackId():int
        {
            return (this.var_3299);
        }

        public function set previewCallbackId(param1:int):void
        {
            this.var_3299 = param1;
        }

        public function dispose():void
        {
            if (this.disposed)
            {
                return;
            };
            this._disposed = true;
            this.var_3082 = 0;
            this.var_3294 = "";
            this.var_3295 = 0;
            this.var_3296 = 0;
            this.var_3297 = 0;
            this.var_3081 = null;
            if (this.var_3298 != null)
            {
                this.var_3298.dispose();
                this.var_3298 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        private function createProductContainer(param1:Array):void
        {
            switch (this.var_3292)
            {
                case var_813:
                    this.var_3298 = new SingleProductContainer(this, param1);
                    return;
                case var_814:
                    this.var_3298 = new MultiProductContainer(this, param1);
                    return;
                case var_815:
                    this.var_3298 = new BundleProductContainer(this, param1);
                    return;
                default:
                    Logger.log(("[Offer] Unknown pricing model" + this.var_3292));
            };
        }

        private function analyzePricingModel(param1:Array):void
        {
            var _loc2_:Product;
            if (param1.length == 1)
            {
                _loc2_ = param1[0];
                if (_loc2_.productCount == 1)
                {
                    this.var_3292 = var_813;
                }
                else
                {
                    this.var_3292 = var_814;
                };
            }
            else
            {
                if (param1.length > 1)
                {
                    this.var_3292 = var_815;
                }
                else
                {
                    this.var_3292 = var_812;
                };
            };
        }

        private function analyzePriceType():void
        {
            if (((this.var_3295 > 0) && (this.var_3296 > 0)))
            {
                this.var_3293 = var_818;
            }
            else
            {
                if (this.var_3295 > 0)
                {
                    this.var_3293 = var_745;
                }
                else
                {
                    if (this.var_3296 > 0)
                    {
                        this.var_3293 = var_817;
                    }
                    else
                    {
                        this.var_3293 = var_816;
                    };
                };
            };
        }

        public function clone():Offer
        {
            var _loc3_:Product;
            var _loc4_:IFurnitureData;
            var _loc5_:Product;
            var _loc1_:Array = new Array();
            var _loc2_:IProductData = this.var_3081.viewer.catalog.getProductData(this.localizationId);
            for each (_loc3_ in this.var_3298.products)
            {
                _loc4_ = this.var_3081.viewer.catalog.getFurnitureData(_loc3_.productClassId, _loc3_.productType);
                _loc5_ = new Product(_loc3_.productType, _loc3_.productClassId, _loc3_.extraParam, _loc3_.productCount, _loc3_.expiration, _loc2_, _loc4_);
                _loc1_.push(_loc5_);
            };
            return (new Offer(this.offerId, this.localizationId, this.priceInCredits, this.priceInActivityPoints, this.activityPointType, this.clubLevel, _loc1_, this.page));
        }


    }
}