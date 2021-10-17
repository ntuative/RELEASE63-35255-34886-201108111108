package com.sulake.habbo.ui.widget.furniture.teaser
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.net.URLRequest;

    public class ImageDownloader implements IDisposable 
    {

        private var _widget:TeaserFurniWidget;
        private var _assets:IAssetLibrary;
        private var var_3826:String;
        private var var_5299:String;
        private var var_5300:String;
        private var var_2551:AssetLoaderStruct;
        private var _disposed:Boolean;

        public function ImageDownloader(param1:TeaserFurniWidget, param2:IAssetLibrary, param3:String, param4:String, param5:String, param6:String)
        {
            this._widget = param1;
            this._assets = param2;
            this.var_3826 = param3;
            this.var_5299 = param5;
            this.var_5300 = param6;
            this.downloadImage(param4, param5);
        }

        public function dispose():void
        {
            this._widget = null;
            this._assets = null;
            if (this.var_2551)
            {
                this.var_2551.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onImageReady);
            };
            this.var_2551 = null;
            this._disposed = true;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get campaignID():String
        {
            return (this.var_3826);
        }

        public function get imageName():String
        {
            return (this.var_5299);
        }

        public function get viewElementID():String
        {
            return (this.var_5300);
        }

        public function downloadImage(param1:String, param2:String):void
        {
            var _loc3_:URLRequest = new URLRequest(((param1 + "") + param2));
            if (_loc3_ != null)
            {
                this.var_2551 = this._assets.loadAssetFromFile(param2, _loc3_, "image/png");
                this.var_2551.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onImageReady);
            };
        }

        private function onImageReady(param1:AssetLoaderEvent):void
        {
            if (this._widget != null)
            {
                this._widget.onDecoImageReady(this);
            };
            if (this.var_2551)
            {
                this.var_2551.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onImageReady);
            };
            this.var_2551 = null;
        }


    }
}