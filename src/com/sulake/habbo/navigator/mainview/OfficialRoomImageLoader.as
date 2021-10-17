package com.sulake.habbo.navigator.mainview
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.display.BitmapData;

    public class OfficialRoomImageLoader implements IDisposable 
    {

        private var _navigator:HabboNavigator;
        private var var_3489:String;
        private var var_2552:String;
        private var var_4306:IBitmapWrapperWindow;
        private var _disposed:Boolean;

        public function OfficialRoomImageLoader(param1:HabboNavigator, param2:String, param3:IBitmapWrapperWindow)
        {
            this._navigator = param1;
            this.var_3489 = param2;
            this.var_4306 = param3;
            var _loc4_:String = this._navigator.configuration.getKey("image.library.url");
            this.var_2552 = (_loc4_ + this.var_3489);
            Logger.log(("[OFFICIAL ROOM ICON IMAGE DOWNLOADER] : " + this.var_2552));
        }

        public function startLoad():void
        {
            var _loc1_:URLRequest;
            var _loc2_:AssetLoaderStruct;
            if (this._navigator.assets.hasAsset(this.var_3489))
            {
                this.setImage();
            }
            else
            {
                _loc1_ = new URLRequest(this.var_2552);
                _loc2_ = this._navigator.assets.loadAssetFromFile(this.var_3489, _loc1_, "image/gif");
                _loc2_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onImageReady);
                _loc2_.addEventListener(AssetLoaderEvent.var_34, this.onLoadError);
            };
        }

        private function onImageReady(param1:AssetLoaderEvent):void
        {
            if (this._disposed)
            {
                return;
            };
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            if (_loc2_ == null)
            {
                Logger.log((("Loading pic from url: " + this.var_2552) + " failed. loaderStruct == null"));
                return;
            };
            Logger.log(((("IMAGE READY: " + this.var_3489) + ", ") + _loc2_));
            this.setImage();
        }

        private function setImage():void
        {
            var _loc1_:BitmapData = this._navigator.getButtonImage(this.var_3489, "");
            this.var_4306.bitmap = _loc1_;
            this.var_4306.width = _loc1_.width;
            this.var_4306.height = _loc1_.height;
            this.var_4306.visible = true;
            this.dispose();
        }

        private function onLoadError(param1:AssetLoaderEvent):void
        {
            Logger.log(((("Error loading image: " + this.var_2552) + ", ") + param1));
            this.dispose();
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            this.var_4306 = null;
            this._navigator = null;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }


    }
}