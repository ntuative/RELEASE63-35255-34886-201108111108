package com.sulake.habbo.catalog.marketplace
{
    import flash.display.BitmapData;

    public class MarketPlaceOfferData implements IMarketPlaceOfferData 
    {

        public static const var_806:int = 1;
        public static const var_807:int = 2;

        private var var_3082:int;
        private var _furniId:int;
        private var var_3128:int;
        private var var_3129:String;
        private var var_3084:int;
        private var var_3108:int;
        private var var_3130:int;
        private var var_2549:int;
        private var var_3131:int = -1;
        private var var_3132:int;
        private var var_1033:BitmapData;

        public function MarketPlaceOfferData(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:int=-1)
        {
            this.var_3082 = param1;
            this._furniId = param2;
            this.var_3128 = param3;
            this.var_3129 = param4;
            this.var_3084 = param5;
            this.var_2549 = param6;
            this.var_3108 = param7;
            this.var_3132 = param8;
        }

        public function dispose():void
        {
            if (this.var_1033)
            {
                this.var_1033.dispose();
                this.var_1033 = null;
            };
        }

        public function get offerId():int
        {
            return (this.var_3082);
        }

        public function get furniId():int
        {
            return (this._furniId);
        }

        public function get furniType():int
        {
            return (this.var_3128);
        }

        public function get stuffData():String
        {
            return (this.var_3129);
        }

        public function get price():int
        {
            return (this.var_3084);
        }

        public function get averagePrice():int
        {
            return (this.var_3108);
        }

        public function get image():BitmapData
        {
            return (this.var_1033);
        }

        public function set image(param1:BitmapData):void
        {
            if (this.var_1033 != null)
            {
                this.var_1033.dispose();
            };
            this.var_1033 = param1;
        }

        public function set imageCallback(param1:int):void
        {
            this.var_3130 = param1;
        }

        public function get imageCallback():int
        {
            return (this.var_3130);
        }

        public function get status():int
        {
            return (this.var_2549);
        }

        public function get timeLeftMinutes():int
        {
            return (this.var_3131);
        }

        public function set timeLeftMinutes(param1:int):void
        {
            this.var_3131 = param1;
        }

        public function set price(param1:int):void
        {
            this.var_3084 = param1;
        }

        public function set offerId(param1:int):void
        {
            this.var_3082 = param1;
        }

        public function get offerCount():int
        {
            return (this.var_3132);
        }

        public function set offerCount(param1:int):void
        {
            this.var_3132 = param1;
        }


    }
}