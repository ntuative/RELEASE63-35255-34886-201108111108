package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class SingleProductContainer extends ProductContainer 
    {

        public function SingleProductContainer(param1:Offer, param2:Array)
        {
            super(param1, param2);
        }

        override public function initProductIcon(param1:IRoomEngine):void
        {
            var _loc2_:IProduct = firstProduct;
            var _loc3_:BitmapData = _loc2_.initIcon(this, this, (offer as IPurchasableOffer), _icon, this.onPreviewImageReady);
            this.setIconImage(_loc3_, true);
        }

        private function onPreviewImageReady(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct;
            if (((!(disposed)) && (!(offer.page.viewer.catalog == null))))
            {
                _loc2_ = (param1.target as AssetLoaderStruct);
                if (_loc2_ != null)
                {
                    (offer.page.viewer.catalog as HabboCatalog).setImageFromAsset(_icon, _loc2_.assetName, null);
                };
            };
        }


    }
}