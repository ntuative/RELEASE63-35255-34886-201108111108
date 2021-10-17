package com.sulake.habbo.advertisement
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.utils.Timer;
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.advertisement.InterstitialMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.advertisement.RoomAdMessageEvent;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.system.Security;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.outgoing.advertisement.GetInterstitialMessageComposer;
    import com.sulake.habbo.communication.messages.parser.advertisement.InterstitialMessageParser;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.loaders.IAssetLoader;
    import flash.display.Bitmap;
    import com.sulake.habbo.advertisement.events.InterstitialEvent;
    import com.sulake.habbo.communication.messages.outgoing.advertisement.GetRoomAdMessageComposer;
    import com.sulake.habbo.communication.messages.parser.advertisement.RoomAdMessageParser;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.core.assets.IAsset;

    public class AdManager extends Component implements IAdManager 
    {

        private var var_2588:IHabboCommunicationManager;
        private var _connection:IConnection;
        private var _config:IHabboConfigurationManager;
        private var var_2826:Boolean;
        private var var_2827:String;
        private var var_2828:String;
        private var var_2829:int = 0;
        private var var_2830:int = 0;
        private var var_2831:int = 0;
        private var var_2832:int = 0;
        private var var_2833:int = 0;
        private var var_2834:Timer;
        private var var_2835:AdImageRequest;
        private var var_2836:BitmapData = null;
        private var var_2837:BitmapData = null;
        private var var_2838:Map;

        public function AdManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this.var_2838 = new Map();
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
        }

        override public function dispose():void
        {
            super.dispose();
            this._connection = null;
            if (this.var_2838 != null)
            {
                this.var_2838.dispose();
                this.var_2838 = null;
            };
            if (this.var_2588 != null)
            {
                release(new IIDHabboCommunicationManager());
                this.var_2588 = null;
            };
            if (this._config != null)
            {
                release(new IIDHabboConfigurationManager());
                this._config = null;
            };
            if (this.var_2836)
            {
                this.var_2836.dispose();
                this.var_2836 = null;
            };
            if (this.var_2837)
            {
                this.var_2837.dispose();
                this.var_2837 = null;
            };
        }

        private function onCommunicationManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_2588 = (param2 as IHabboCommunicationManager);
            if (this.var_2588 == null)
            {
                return;
            };
            this._connection = this.var_2588.getHabboMainConnection(this.onConnectionReady);
            if (this._connection != null)
            {
                this.onConnectionReady(this._connection);
            };
        }

        private function onConnectionReady(param1:IConnection):void
        {
            if (((disposed) || (param1 == null)))
            {
                return;
            };
            this._connection = param1;
            this._connection.addMessageEvent(new InterstitialMessageEvent(this.onInterstitial));
            this._connection.addMessageEvent(new RoomAdMessageEvent(this.onRoomAd));
        }

        private function onConfigurationReady(param1:IID=null, param2:IUnknown=null):void
        {
            var _loc7_:URLRequest;
            var _loc8_:AssetLoaderStruct;
            this._config = (param2 as IHabboConfigurationManager);
            if (this._config == null)
            {
                return;
            };
            this.var_2826 = (this._config.getKey("interstitial.enabled", "false") == "true");
            this.var_2829 = int(this._config.getKey("interstitial.interval", "30000"));
            this.var_2831 = int(this._config.getKey("interstitial.show.time", "5000"));
            this.var_2832 = int(this._config.getKey("interstitial.max.displays.flash", "-1"));
            var _loc3_:String = this._config.getKey("ads.domain");
            if (_loc3_ != "")
            {
                Security.loadPolicyFile((("http://" + _loc3_) + "/crossdomain.xml"));
            };
            var _loc4_:String = this._config.getKey("billboard.adwarning.left.url");
            var _loc5_:String = this._config.getKey("billboard.adwarning.right.url");
            var _loc6_:String = this._config.getKey("image.library.url");
            if (((!(_loc4_ == "")) && (!(_loc5_ == ""))))
            {
                _loc4_ = (_loc6_ + _loc4_);
                _loc5_ = (_loc6_ + _loc5_);
                _loc7_ = new URLRequest(_loc4_);
                _loc8_ = assets.loadAssetFromFile("adWarningL", _loc7_, "image/png");
                _loc8_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.adWarningLeftReady);
                _loc7_ = new URLRequest(_loc5_);
                _loc8_ = assets.loadAssetFromFile("adWarningRight", _loc7_, "image/png");
                _loc8_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.adWarningRightReady);
            };
        }

        public function showInterstitial():Boolean
        {
            if (!this.var_2826)
            {
                return (false);
            };
            if (((!(this.var_2834 == null)) && (this.var_2834.running)))
            {
                this.var_2834.reset();
                return (false);
            };
            if (this.var_2830 == 0)
            {
                this.var_2830 = getTimer();
                return (false);
            };
            if (((this.var_2832 > 0) && (this.var_2833 >= this.var_2832)))
            {
                return (false);
            };
            var _loc1_:int = (getTimer() - this.var_2830);
            if (_loc1_ > this.var_2829)
            {
                this.var_2833++;
                this._connection.send(new GetInterstitialMessageComposer());
                return (true);
            };
            return (false);
        }

        private function onInterstitial(param1:InterstitialMessageEvent):void
        {
            var _loc3_:String;
            var _loc4_:URLRequest;
            var _loc5_:AssetLoaderStruct;
            var _loc2_:InterstitialMessageParser = param1.getParser();
            this.var_2827 = _loc2_.imageUrl;
            this.var_2828 = _loc2_.clickUrl;
            this.var_2830 = getTimer();
            if (this.var_2827 != "")
            {
                _loc3_ = this.var_2827;
                if (assets.hasAsset(_loc3_))
                {
                    assets.removeAsset(assets.getAssetByName(_loc3_));
                };
                if (this.var_2834 == null)
                {
                    this.var_2834 = new Timer(this.var_2831, 1);
                    this.var_2834.addEventListener(TimerEvent.TIMER_COMPLETE, this.interstitialTimerComplete);
                };
                if (this.var_2834.running)
                {
                    this.var_2834.reset();
                };
                this.var_2834.start();
                _loc4_ = new URLRequest(this.var_2827);
                _loc5_ = assets.loadAssetFromFile(_loc3_, _loc4_, "image/jpeg");
                _loc5_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.interstitialLoaderEventHandler);
                _loc5_.addEventListener(AssetLoaderEvent.var_34, this.interstitialLoaderEventHandler);
            }
            else
            {
                this.stopInterstitial();
            };
        }

        private function interstitialLoaderEventHandler(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct;
            var _loc3_:IAssetLoader;
            var _loc4_:Bitmap;
            if (param1 == null)
            {
                return;
            };
            switch (param1.type)
            {
                case AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE:
                    _loc2_ = (param1.target as AssetLoaderStruct);
                    if (_loc2_ != null)
                    {
                        _loc3_ = _loc2_.assetLoader;
                        if (_loc3_ != null)
                        {
                            _loc4_ = (_loc3_.content as Bitmap);
                            this.startInterstitial(_loc4_);
                            return;
                        };
                    };
                    this.stopInterstitial();
                    return;
                case AssetLoaderEvent.var_34:
                    this.stopInterstitial();
                    return;
            };
        }

        private function startInterstitial(param1:Bitmap):void
        {
            if (((!(this.var_2834 == null)) && (!(this.var_2834.running))))
            {
                return;
            };
            if (this.isValidAdImage(param1))
            {
                events.dispatchEvent(new InterstitialEvent(InterstitialEvent.var_339, param1.bitmapData, this.var_2828));
                this.var_2830 = getTimer();
            }
            else
            {
                this.stopInterstitial();
            };
        }

        private function interstitialTimerComplete(param1:TimerEvent):void
        {
            this.stopInterstitial();
        }

        private function stopInterstitial():void
        {
            if (((!(this.var_2834 == null)) && (this.var_2834.running)))
            {
                this.var_2834.reset();
            };
            if (events != null)
            {
                events.dispatchEvent(new InterstitialEvent(InterstitialEvent.var_338));
            };
        }

        public function showRoomAd(param1:int, param2:int):void
        {
            this.var_2835 = new AdImageRequest(param1, param2);
            this._connection.send(new GetRoomAdMessageComposer());
        }

        private function onRoomAd(param1:RoomAdMessageEvent):void
        {
            var _loc3_:String;
            var _loc4_:URLRequest;
            var _loc5_:AssetLoaderStruct;
            var _loc2_:RoomAdMessageParser = param1.getParser();
            if ((((!(this.var_2835 == null)) && (!(_loc2_.imageUrl == ""))) && (!(_loc2_.clickUrl == ""))))
            {
                _loc3_ = _loc2_.imageUrl;
                if (assets.hasAsset(_loc3_))
                {
                    assets.removeAsset(assets.getAssetByName(_loc3_));
                };
                this.var_2835 = new AdImageRequest(this.var_2835.roomId, this.var_2835.roomCategory, _loc2_.imageUrl, _loc2_.clickUrl);
                _loc4_ = new URLRequest(_loc2_.imageUrl);
                _loc5_ = assets.loadAssetFromFile(_loc3_, _loc4_, "image/jpeg");
                _loc5_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.roomAdImageReady);
            }
            else
            {
                this.var_2835 = null;
            };
        }

        private function roomAdImageReady(param1:AssetLoaderEvent):void
        {
            var _loc4_:BitmapData;
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            var _loc3_:Bitmap = (_loc2_.assetLoader.content as Bitmap);
            if (((this.isValidAdImage(_loc3_)) && (!(this.var_2835 == null))))
            {
                _loc4_ = this.emulateBackgroundTransparency(_loc3_.bitmapData);
                events.dispatchEvent(new AdEvent(AdEvent.var_69, this.var_2835.roomId, this.var_2835.roomCategory, _loc4_, _loc2_.assetName, this.var_2835.clickURL, this.var_2836, this.var_2837));
                this.var_2835 = null;
            };
        }

        private function adWarningLeftReady(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            var _loc3_:Bitmap = (_loc2_.assetLoader.content as Bitmap);
            if (_loc3_ != null)
            {
                this.var_2836 = this.emulateBackgroundTransparency(_loc3_.bitmapData);
            };
        }

        private function adWarningRightReady(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            var _loc3_:Bitmap = (_loc2_.assetLoader.content as Bitmap);
            if (_loc3_ != null)
            {
                this.var_2837 = this.emulateBackgroundTransparency(_loc3_.bitmapData);
            };
        }

        private function emulateBackgroundTransparency(param1:BitmapData):BitmapData
        {
            var _loc4_:int;
            var _loc5_:uint;
            if (param1 == null)
            {
                return (null);
            };
            var _loc2_:BitmapData = new BitmapData(param1.width, param1.height, true, 0);
            var _loc3_:int;
            while (_loc3_ < _loc2_.height)
            {
                _loc4_ = 0;
                while (_loc4_ < _loc2_.width)
                {
                    _loc5_ = param1.getPixel32(_loc4_, _loc3_);
                    if (_loc5_ != 0xFFFFFFFF)
                    {
                        _loc2_.setPixel32(_loc4_, _loc3_, _loc5_);
                    };
                    _loc4_++;
                };
                _loc3_++;
            };
            return (_loc2_);
        }

        private function isValidAdImage(param1:Bitmap):Boolean
        {
            if (((!(param1 == null)) && ((param1.width > 1) || (param1.height > 1))))
            {
                return (true);
            };
            return (false);
        }

        public function loadRoomAdImage(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String):void
        {
            var _loc11_:IAsset;
            var _loc12_:BitmapData;
            var _loc13_:AdImageRequest;
            if (((param5 == null) || (param5.length == 0)))
            {
                return;
            };
            var _loc7_:String = param5;
            if (assets.hasAsset(_loc7_))
            {
                _loc11_ = assets.getAssetByName(_loc7_);
                if (_loc11_ != null)
                {
                    _loc12_ = (_loc11_.content as BitmapData);
                    if (_loc12_ != null)
                    {
                        this.dispatchImageAsset(_loc12_.clone(), param1, param2, param3, param4, param5, param6);
                    };
                };
                return;
            };
            var _loc8_:Array = this.var_2838.getValue(_loc7_);
            if (_loc8_ == null)
            {
                _loc8_ = new Array();
                this.var_2838.add(_loc7_, _loc8_);
            };
            if (_loc8_.length > 0)
            {
                for each (_loc13_ in _loc8_)
                {
                    if (((((_loc13_.roomId == param1) && (_loc13_.roomCategory == param2)) && (_loc13_.objectId == param3)) && (_loc13_.objectCategory == param4)))
                    {
                        return;
                    };
                };
            };
            _loc8_.push(new AdImageRequest(param1, param2, param5, param6, param3, param4));
            Logger.log(("trying to load billboard from url " + _loc7_));
            var _loc9_:URLRequest = new URLRequest(_loc7_);
            var _loc10_:AssetLoaderStruct = assets.loadAssetFromFile(_loc7_, _loc9_, "image/png");
            _loc10_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onBillboardImageReady);
            _loc10_.addEventListener(AssetLoaderEvent.var_34, this.onBillboardImageLoadError);
        }

        private function onBillboardImageReady(param1:AssetLoaderEvent):void
        {
            var _loc5_:BitmapData;
            var _loc6_:AdImageRequest;
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            var _loc3_:Bitmap = (_loc2_.assetLoader.content as Bitmap);
            var _loc4_:Array = this.var_2838.remove(_loc2_.assetName);
            if (((_loc4_ == null) || (_loc4_.length == 0)))
            {
                return;
            };
            Logger.log(("billboard image loaded from url " + _loc2_.assetName));
            if (this.isValidAdImage(_loc3_))
            {
                _loc5_ = _loc3_.bitmapData;
                if (_loc5_ != null)
                {
                    for each (_loc6_ in _loc4_)
                    {
                        this.dispatchImageAsset(_loc5_.clone(), _loc6_.roomId, _loc6_.roomCategory, _loc6_.objectId, _loc6_.objectCategory, _loc6_.imageURL, _loc6_.clickURL);
                    };
                };
            };
        }

        private function dispatchImageAsset(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:String, param7:String):void
        {
            if (events != null)
            {
                events.dispatchEvent(new AdEvent(AdEvent.var_323, param2, param3, param1, param6, param7, null, null, param4, param5));
            };
        }

        private function onBillboardImageLoadError(param1:AssetLoaderEvent):void
        {
            var _loc4_:AdImageRequest;
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            var _loc3_:Array = this.var_2838.remove(_loc2_.assetName);
            if (((_loc3_ == null) || (_loc3_.length == 0)))
            {
                return;
            };
            for each (_loc4_ in _loc3_)
            {
                Logger.log((("failed to load billboard image from url '" + _loc2_.assetName) + "'"));
                this.dispatchImageAsset(null, _loc4_.roomId, _loc4_.roomCategory, _loc4_.objectId, _loc4_.objectCategory, _loc4_.imageURL, _loc4_.clickURL);
            };
        }


    }
}