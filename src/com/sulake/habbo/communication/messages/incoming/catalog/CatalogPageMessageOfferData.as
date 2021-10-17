package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogPageMessageOfferData 
    {

        private var var_3082:int;
        private var var_3294:String;
        private var var_3295:int;
        private var var_3296:int;
        private var var_3297:int;
        private var _clubLevel:int;
        private var var_3305:Array;

        public function CatalogPageMessageOfferData(param1:IMessageDataWrapper)
        {
            this.var_3082 = param1.readInteger();
            this.var_3294 = param1.readString();
            this.var_3295 = param1.readInteger();
            this.var_3296 = param1.readInteger();
            this.var_3297 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            this.var_3305 = new Array();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3305.push(new CatalogPageMessageProductData(param1));
                _loc3_++;
            };
            this._clubLevel = param1.readInteger();
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

        public function get products():Array
        {
            return (this.var_3305);
        }

        public function get activityPointType():int
        {
            return (this.var_3297);
        }

        public function get clubLevel():int
        {
            return (this._clubLevel);
        }


    }
}