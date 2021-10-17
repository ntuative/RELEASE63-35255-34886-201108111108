package com.sulake.habbo.session
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.AssetLibrary;
    import flash.display.BitmapData;
    import flash.net.URLRequest;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.display.Bitmap;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;

    public class BadgeImageManager 
    {

        public static const var_449:String = "group_badge";
        public static const var_447:String = "normal_badge";

        private const var_4982:String = "badge_";

        private var _assets:IAssetLibrary;
        private var _events:IEventDispatcher;
        private var _configuration:IHabboConfigurationManager;
        private var _localization:IHabboLocalizationManager;

        public function BadgeImageManager(param1:IAssetLibrary, param2:IEventDispatcher, param3:IHabboConfigurationManager, param4:IHabboLocalizationManager)
        {
            if (param1 == null)
            {
                param1 = new AssetLibrary("badge_images");
            };
            this._assets = param1;
            this._events = param2;
            this._configuration = param3;
            this._localization = param4;
        }

        public function dispose():void
        {
            this._assets = null;
        }

        public function getBadgeImage(param1:String, param2:String="normal_badge", param3:Boolean=true):BitmapData
        {
            var _loc4_:BitmapData = this.getBadgeImageInternal(param1, param2);
            if (((!(_loc4_)) && (param3)))
            {
                _loc4_ = this.getPlaceholder();
            };
            return (_loc4_);
        }

        public function getBadgeImageWithInfo(param1:String):BadgeInfo
        {
            var _loc2_:BitmapData = this.getBadgeImageInternal(param1);
            return ((_loc2_ != null) ? new BadgeInfo(_loc2_, false) : new BadgeInfo(this.getPlaceholder(), true));
        }

        private function getBadgeImageInternal(param1:String, param2:String="normal_badge"):BitmapData
        {
            var _loc4_:URLRequest;
            var _loc5_:String;
            var _loc6_:BitmapDataAsset;
            var _loc7_:AssetLoaderStruct;
            var _loc3_:String = (this.var_4982 + param1);
            Logger.log(("Request badge: " + param1));
            if (this._assets.hasAsset(_loc3_))
            {
                _loc6_ = (this._assets.getAssetByName(_loc3_) as BitmapDataAsset);
                return ((_loc6_.content as BitmapData).clone());
            };
            switch (param2)
            {
                case var_447:
                    if (this._configuration != null)
                    {
                        _loc5_ = this._configuration.getKey("image.library.url", "http://images.habbo.com/c_images/");
                        _loc5_ = (_loc5_ + (("album1584/" + param1) + ".gif"));
                        _loc4_ = new URLRequest(_loc5_);
                    };
                    break;
                case var_449:
                    if (this._configuration != null)
                    {
                        if (this._configuration != null)
                        {
                            _loc5_ = this._configuration.getKey("group.badge.url");
                            _loc5_ = _loc5_.replace("%imagerdata%", param1);
                            _loc4_ = new URLRequest(_loc5_);
                        };
                    };
                    break;
            };
            if (_loc4_ != null)
            {
                _loc7_ = this._assets.loadAssetFromFile(_loc3_, _loc4_, "image/gif");
                _loc7_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onBadgeImageReady);
            };
            return (null);
        }

        private function getPlaceholder():BitmapData
        {
            return (BitmapData(this._assets.getAssetByName("loading_icon").content));
        }

        private function onBadgeImageReady(param1:AssetLoaderEvent):void
        {
            var _loc3_:Bitmap;
            var _loc4_:String;
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            if (_loc2_ != null)
            {
                if (((!(_loc2_.assetLoader == null)) && (!(_loc2_.assetLoader.content == null))))
                {
                    _loc3_ = (_loc2_.assetLoader.content as Bitmap);
                    if (_loc3_ == null)
                    {
                        return;
                    };
                    _loc4_ = _loc2_.assetName.replace(this.var_4982, "");
                    this._events.dispatchEvent(new BadgeImageReadyEvent(_loc4_, _loc3_.bitmapData.clone()));
                };
            };
        }


    }
}