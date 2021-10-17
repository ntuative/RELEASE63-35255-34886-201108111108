package com.sulake.habbo.session.furniture
{
    import flash.events.EventDispatcher;
    import com.sulake.core.utils.Map;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.assets.AssetLibrary;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;
    import com.sulake.habbo.utils.HabboWebTools;

    public class FurnitureDataParser extends EventDispatcher 
    {

        public static const var_444:String = "ready";

        private var var_4979:Map;
        private var _wallItems:Map;
        private var var_4980:Map;
        private var _localization:ICoreLocalizationManager;
        private var var_3359:AssetLibrary;

        public function FurnitureDataParser(param1:Map, param2:Map, param3:Map, param4:ICoreLocalizationManager)
        {
            this.var_4979 = param1;
            this._wallItems = param2;
            this.var_4980 = param3;
            this._localization = param4;
            this.var_3359 = new AssetLibrary("FurniDataParserAssetLib");
        }

        public function dispose():void
        {
            if (this.var_3359)
            {
                this.var_3359.dispose();
                this.var_3359 = null;
            };
            this._localization = null;
            this.var_4979 = null;
            this._wallItems = null;
            this.var_4980 = null;
        }

        public function loadData(param1:String):void
        {
            var _loc2_:AssetLoaderStruct = this.var_3359.loadAssetFromFile(param1, new URLRequest(param1), "text/plain");
            _loc2_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.parseFurnitureData);
            _loc2_.addEventListener(AssetLoaderEvent.var_34, this.furnitureDataError);
        }

        private function parseFurnitureData(param1:AssetLoaderEvent):void
        {
            var _loc10_:String;
            var _loc11_:Array;
            var _loc12_:String;
            var _loc13_:Array;
            var _loc14_:String;
            var _loc15_:int;
            var _loc16_:Array;
            var _loc17_:String;
            var _loc18_:int;
            var _loc19_:int;
            var _loc20_:int;
            var _loc21_:int;
            var _loc22_:int;
            var _loc23_:Array;
            var _loc24_:Array;
            var _loc25_:int;
            var _loc26_:String;
            var _loc27_:String;
            var _loc28_:String;
            var _loc29_:int;
            var _loc30_:int;
            var _loc31_:FurnitureData;
            var _loc32_:Array;
            var _loc33_:String;
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            if (_loc2_ == null)
            {
                return;
            };
            if (((_loc2_.assetLoader == null) || (_loc2_.assetLoader.content == null)))
            {
                return;
            };
            var _loc3_:String = (_loc2_.assetLoader.content as String);
            var _loc4_:Array = new Array();
            var _loc5_:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
            var _loc6_:RegExp = /^\s+|\s+$/g;
            var _loc7_:RegExp = /\[+?((.)*?)\]/g;
            var _loc8_:Array = _loc3_.split(_loc5_);
            var _loc9_:int;
            for each (_loc10_ in _loc8_)
            {
                _loc11_ = _loc10_.match(_loc7_);
                for each (_loc12_ in _loc11_)
                {
                    _loc12_ = _loc12_.replace(/\[{1,}/mg, "");
                    _loc12_ = _loc12_.replace(/\]{1,}/mg, "");
                    _loc13_ = _loc12_.split('"');
                    this.removePatternFrom(_loc13_, ", ");
                    this.removePatternFrom(_loc13_, ",");
                    _loc13_.splice(0, 1);
                    _loc13_.splice((_loc13_.length - 1), 1);
                    _loc14_ = _loc13_[0];
                    _loc15_ = parseInt(_loc13_[1]);
                    _loc16_ = String(_loc13_[2]).split("*");
                    _loc17_ = _loc16_[0];
                    _loc18_ = 0;
                    if (_loc16_.length > 1)
                    {
                        _loc18_ = parseInt(_loc16_[1]);
                    };
                    _loc19_ = parseInt(_loc13_[3]);
                    _loc20_ = parseInt(_loc13_[4]);
                    _loc21_ = parseInt(_loc13_[5]);
                    _loc22_ = parseInt(_loc13_[6]);
                    _loc23_ = new Array();
                    _loc24_ = _loc13_[7].split(",");
                    _loc25_ = 0;
                    while (_loc25_ < _loc24_.length)
                    {
                        _loc33_ = _loc24_[_loc25_];
                        if (_loc33_.charAt(0) == "#")
                        {
                            _loc33_ = _loc33_.replace("#", "");
                            _loc23_.push(parseInt(_loc33_, 16));
                        }
                        else
                        {
                            _loc23_.push(-(parseInt(_loc33_)));
                        };
                        _loc25_++;
                    };
                    _loc26_ = _loc13_[8];
                    _loc27_ = _loc13_[9];
                    _loc28_ = _loc13_[10];
                    _loc29_ = parseInt(_loc13_[11]);
                    _loc30_ = parseInt(_loc13_[12]);
                    if (this._localization != null)
                    {
                        if (_loc14_ == "s")
                        {
                            this._localization.updateKey(("roomItem.name." + _loc15_), _loc26_);
                            this._localization.updateKey(("roomItem.desc." + _loc15_), _loc27_);
                        }
                        else
                        {
                            if (_loc14_ == "i")
                            {
                                this._localization.updateKey(("wallItem.name." + _loc15_), _loc26_);
                                this._localization.updateKey(("wallItem.desc." + _loc15_), _loc27_);
                            };
                        };
                    };
                    _loc31_ = new FurnitureData(_loc14_, _loc15_, _loc17_, _loc18_, _loc19_, _loc20_, _loc21_, _loc22_, _loc23_, _loc26_, _loc27_, _loc28_, _loc29_, _loc30_);
                    if (_loc14_ == "s")
                    {
                        this.var_4979.add(_loc15_, _loc31_);
                    }
                    else
                    {
                        if (_loc14_ == "i")
                        {
                            this._wallItems.add(_loc15_, _loc31_);
                        };
                    };
                    _loc32_ = this.var_4980[_loc17_];
                    if (_loc32_ == null)
                    {
                        _loc32_ = [];
                        this.var_4980.add(_loc17_, _loc32_);
                    };
                    _loc32_[_loc18_] = _loc15_;
                };
                _loc9_++;
            };
            dispatchEvent(new Event(var_444));
        }

        private function furnitureDataError(param1:AssetLoaderEvent):void
        {
            HabboWebTools.logEventLog(("furnituredata download error " + param1.status));
        }

        public function registerFurnitureLocalizations():void
        {
            var _loc1_:FurnitureData;
            if (!this._localization)
            {
                return;
            };
            for each (_loc1_ in this.var_4979.getValues())
            {
                this._localization.updateKey(("roomItem.name." + _loc1_.id), _loc1_.title);
                this._localization.updateKey(("roomItem.desc." + _loc1_.id), _loc1_.description);
            };
            for each (_loc1_ in this._wallItems.getValues())
            {
                this._localization.updateKey(("wallItem.name." + _loc1_.id), _loc1_.title);
                this._localization.updateKey(("wallItem.desc." + _loc1_.id), _loc1_.description);
            };
        }

        private function removePatternFrom(param1:Array, param2:Object):void
        {
            var _loc3_:int;
            while (_loc3_ < param1.length)
            {
                if (param1[_loc3_] == param2)
                {
                    param1.splice(_loc3_, 1);
                    _loc3_--;
                };
                _loc3_++;
            };
        }

        public function set localization(param1:ICoreLocalizationManager):void
        {
            this._localization = param1;
        }


    }
}