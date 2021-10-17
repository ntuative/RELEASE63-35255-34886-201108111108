package com.sulake.core.localization
{
    import com.sulake.core.runtime.Component;
    import flash.utils.Dictionary;
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;
    import com.sulake.core.localization.enum.LocalizationEvent;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.Core;

    public class CoreLocalizationManager extends Component implements ICoreLocalizationManager 
    {

        private var var_1600:Dictionary;
        private var var_2600:Map;
        private var var_2601:String;
        private var var_2602:String = "";
        private var var_2603:Array = [];

        public function CoreLocalizationManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this.var_1600 = new Dictionary();
            this.var_2600 = new Map();
        }

        public function registerLocalizationDefinition(param1:String, param2:String, param3:String):void
        {
            var _loc4_:LocalizationDefinition = this.var_2600[param1];
            if (_loc4_ == null)
            {
                _loc4_ = new LocalizationDefinition(param1, param2, param3);
                this.var_2600[param1] = _loc4_;
            };
        }

        public function activateLocalization(param1:String):Boolean
        {
            var _loc2_:LocalizationDefinition = this.var_2600[param1];
            if (_loc2_ != null)
            {
                this.var_2601 = param1;
                this.loadLocalizationFromURL(_loc2_.url);
                return (true);
            };
            return (false);
        }

        public function getLocalizationDefinitions():Map
        {
            return (this.var_2600);
        }

        public function getLocalizationDefinition(param1:String):ILocalizationDefinition
        {
            return (this.var_2600[param1] as ILocalizationDefinition);
        }

        public function getActiveLocalizationDefinition():ILocalizationDefinition
        {
            return (this.getLocalizationDefinition(this.var_2601));
        }

        public function loadLocalizationFromURL(param1:String):void
        {
            var _loc2_:String = param1;
            if (assets.hasAsset(_loc2_))
            {
                Logger.log(("[CoreLocalizationManager] reload localization for url: " + param1));
            };
            var _loc3_:URLRequest = new URLRequest(param1);
            var _loc4_:AssetLoaderStruct = assets.loadAssetFromFile(_loc2_, _loc3_, "text/plain");
            _loc4_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onLocalizationReady);
            _loc4_.addEventListener(AssetLoaderEvent.var_34, this.onLocalizationFailed);
        }

        private function onLocalizationReady(param1:AssetLoaderEvent):void
        {
            var _loc3_:String;
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            if (_loc2_ != null)
            {
                _loc3_ = _loc2_.assetName;
                this.parseLocalizationData((_loc2_.assetLoader.content as String));
                this.events.dispatchEvent(new Event(LocalizationEvent.var_53));
            };
        }

        protected function onLocalizationFailed(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            ErrorReportStorage.addDebugData("Localization name", _loc2_.assetName);
            ErrorReportStorage.addDebugData("Localization url", _loc2_.assetLoader.url);
            ErrorReportStorage.addDebugData("Localization error", ("Code: " + _loc2_.assetLoader.errorCode));
            Core.error("Failed to download localization", true, Core.var_82);
        }

        public function hasKey(param1:String):Boolean
        {
            var _loc2_:Localization = (this.var_1600[param1] as Localization);
            return (!(_loc2_ == null));
        }

        public function getKey(param1:String, param2:String=""):String
        {
            var _loc3_:Localization = (this.var_1600[param1] as Localization);
            if (_loc3_ == null)
            {
                this.var_2603.push(param1);
                return (param2);
            };
            return (_loc3_.value);
        }

        public function getRawValue(param1:String, param2:String=""):String
        {
            var _loc3_:Localization = (this.var_1600[param1] as Localization);
            if (_loc3_ == null)
            {
                this.var_2603.push(param1);
                return (param2);
            };
            return (_loc3_.raw);
        }

        public function updateKey(param1:String, param2:String):void
        {
            var _loc3_:Localization = this.var_1600[param1];
            if (_loc3_ == null)
            {
                _loc3_ = new Localization(param1, param2);
                this.var_1600[param1] = _loc3_;
            }
            else
            {
                _loc3_.setValue(param2);
            };
            if (param2.indexOf("%predefined%") >= 0)
            {
                _loc3_.registerParameter("predefined", this.var_2602);
            };
        }

        private function updateAllListeners():void
        {
            var _loc1_:Localization;
            for each (_loc1_ in this.var_1600)
            {
                _loc1_.updateListeners();
            };
        }

        public function registerListener(param1:String, param2:ILocalizable):Boolean
        {
            var _loc3_:Localization = this.var_1600[param1];
            if (_loc3_ == null)
            {
                this.var_2603.push(param1);
                _loc3_ = new Localization(param1, param1);
                this.var_1600[param1] = _loc3_;
            };
            _loc3_.registerListener(param2);
            return (true);
        }

        public function removeListener(param1:String, param2:ILocalizable):Boolean
        {
            var _loc3_:Localization = this.var_1600[param1];
            if (_loc3_ != null)
            {
                _loc3_.removeListener(param2);
            };
            return (true);
        }

        public function registerParameter(param1:String, param2:String, param3:String, param4:String="%"):String
        {
            var _loc5_:Localization = this.var_1600[param1];
            if (_loc5_ == null)
            {
                _loc5_ = new Localization(param1);
                this.var_1600[param1] = _loc5_;
            };
            _loc5_.registerParameter(param2, param3, param4);
            return (_loc5_.value);
        }

        public function getLocalization(param1:String):ILocalization
        {
            return (this.var_1600[param1] as ILocalization);
        }

        public function getKeys():Array
        {
            var _loc2_:String;
            var _loc1_:Array = new Array();
            for (_loc2_ in this.var_1600)
            {
                _loc1_.push(_loc2_);
            };
            return (_loc1_);
        }

        public function printNonExistingKeys():void
        {
            var _loc2_:String;
            var _loc1_:String = "";
            for each (_loc2_ in this.var_2603)
            {
                _loc1_ = (_loc1_ + (_loc2_ + "\n"));
            };
            Logger.log(_loc1_);
        }

        protected function parseLocalizationData(param1:String):void
        {
            var _loc6_:String;
            var _loc7_:Array;
            var _loc8_:String;
            var _loc9_:String;
            var _loc2_:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
            var _loc3_:RegExp = /^\s+|\s+$/g;
            var _loc4_:Array = param1.split(_loc2_);
            var _loc5_:RegExp = /\\n/mg;
            for each (_loc6_ in _loc4_)
            {
                if (_loc6_.substr(0, 1) != "#")
                {
                    _loc7_ = _loc6_.split("=");
                    if (_loc7_[0].length > 0)
                    {
                        if (_loc7_.length > 1)
                        {
                            _loc8_ = _loc7_.shift();
                            _loc9_ = _loc7_.join("=");
                            _loc8_ = _loc8_.replace(_loc3_, "");
                            _loc9_ = _loc9_.replace(_loc3_, "");
                            _loc9_ = _loc9_.replace(_loc5_, "\n");
                            if (_loc9_.length > 0)
                            {
                                this.updateKey(_loc8_, _loc9_);
                            };
                        };
                    };
                };
            };
            this.updateAllListeners();
        }

        protected function setPredefinedUrl(param1:String):void
        {
            var _loc2_:Localization;
            this.var_2602 = param1;
            for each (_loc2_ in this.var_1600)
            {
                if (_loc2_.raw.indexOf("%predefined%") >= 0)
                {
                    _loc2_.registerParameter("predefined", this.var_2602);
                };
            };
        }


    }
}