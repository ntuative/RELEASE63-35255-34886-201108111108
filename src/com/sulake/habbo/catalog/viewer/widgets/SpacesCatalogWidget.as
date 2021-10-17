package com.sulake.habbo.catalog.viewer.widgets
{
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.localization.ICoreLocalizationManager;

    public class SpacesCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private static const var_806:String = "floor";
        private static const var_2282:String = "wallpaper";
        private static const TYPE_LANDSCAPE:String = "landscape";

        private var var_3264:Array = [];
        private var var_3265:Array = [];
        private var var_3266:int = 0;
        private var var_3267:int = 0;
        private var var_3268:int = 0;
        private var _floorType:String = "com.sulake.habbo.communication.messages.outgoing.help";
        private var var_3269:Array = [];
        private var var_3270:Array = [];
        private var var_3271:int = 0;
        private var var_3272:int = 0;
        private var var_3273:int = 0;
        private var var_3192:String = "com.sulake.habbo.communication.messages.outgoing.help";
        private var _landscapeOffers:Array = [];
        private var var_3274:Array = [];
        private var var_3275:int = 0;
        private var var_3276:int = 0;
        private var var_3277:int = 0;
        private var var_3193:String = "1.1";
        private var var_3278:Dictionary;
        private var var_3279:Dictionary;
        private var var_3280:Dictionary;

        public function SpacesCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            this.var_3278 = null;
            this.var_3279 = null;
            this.var_3280 = null;
            this.var_3264 = null;
            this.var_3265 = null;
            this.var_3269 = null;
            this.var_3270 = null;
            this._landscapeOffers = null;
            this.var_3274 = null;
            super.dispose();
        }

        override public function init():Boolean
        {
            var _loc3_:Offer;
            var _loc4_:int;
            var _loc5_:IProduct;
            var _loc6_:String;
            var _loc7_:Array;
            var _loc8_:String;
            var _loc9_:String;
            var _loc10_:String;
            var _loc11_:Array;
            var _loc12_:IWindow;
            if (!super.init())
            {
                return (false);
            };
            if (window == null)
            {
                return (false);
            };
            var _loc1_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("configuration_catalog_spaces") as XmlAsset);
            if (_loc1_ == null)
            {
                return (false);
            };
            var _loc2_:XML = (_loc1_.content as XML);
            if (_loc2_ == null)
            {
                return (false);
            };
            this.var_3278 = this.parseElements(_loc2_.floors.pattern);
            this.var_3279 = this.parseElements(_loc2_.walls.pattern);
            this.var_3280 = this.parseElements(_loc2_.landscapes.pattern);
            for each (_loc3_ in page.offers)
            {
                _loc5_ = _loc3_.productContainer.firstProduct;
                _loc6_ = _loc3_.localizationId;
                _loc7_ = ((_loc6_ != null) ? _loc6_.split(" ") : null);
                if (!((_loc7_ == null) || (!(_loc7_.length == 2))))
                {
                    _loc8_ = _loc7_[1];
                    _loc9_ = _loc5_.furnitureData.name;
                    switch (_loc9_)
                    {
                        case "floor":
                            for (_loc10_ in this.var_3278)
                            {
                                _loc11_ = this.var_3278[_loc10_];
                                if (this.var_3265.indexOf(_loc10_) == -1)
                                {
                                    this.var_3265.push(_loc10_);
                                    this.var_3264.push(_loc3_);
                                };
                            };
                            break;
                        case "wallpaper":
                            if (this.var_3279[_loc8_] != null)
                            {
                                this.var_3270.push(_loc8_);
                                this.var_3269.push(_loc3_);
                            }
                            else
                            {
                                Logger.log(("[SpacesCatalogWidget] Could not find wallpaper pattern configuration! " + [_loc6_, _loc9_]));
                            };
                            break;
                        case "landscape":
                            if (this.var_3280[_loc8_] != null)
                            {
                                this.var_3274.push(_loc8_);
                                this._landscapeOffers.push(_loc3_);
                            }
                            else
                            {
                                Logger.log(("[SpacesCatalogWidget] Could not find landscape pattern configuration! " + [_loc6_, _loc9_]));
                            };
                            break;
                        default:
                            Logger.log(("[SpacesCatalogWidget] : " + _loc9_));
                    };
                };
            };
            _loc4_ = 0;
            while (_loc4_ < _window.numChildren)
            {
                _loc12_ = _window.getChildAt(_loc4_);
                if ((_loc12_ is IButtonWindow))
                {
                    _loc12_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClick);
                };
                _loc4_++;
            };
            this.changePattern(var_806, 0);
            this.changePattern(var_2282, 0);
            this.changePattern(TYPE_LANDSCAPE, 0);
            this.updateConfiguration();
            events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(this._floorType, this.var_3192, this.var_3193, 64));
            return (true);
        }

        private function parseElements(param1:XMLList):Dictionary
        {
            var _loc3_:XML;
            var _loc4_:String;
            var _loc5_:Array;
            var _loc6_:XMLList;
            var _loc7_:XML;
            var _loc8_:String;
            var _loc2_:Dictionary = new Dictionary();
            if (param1 != null)
            {
                for each (_loc3_ in param1)
                {
                    _loc4_ = String(_loc3_.@id);
                    if (_loc4_ != null)
                    {
                        _loc5_ = new Array();
                        _loc2_[_loc4_] = _loc5_;
                        _loc6_ = _loc3_.children();
                        if (((!(_loc6_ == null)) && (_loc6_.length() > 0)))
                        {
                            for each (_loc7_ in _loc6_)
                            {
                                _loc8_ = _loc7_.@id;
                                if (((!(_loc8_ == null)) && (_loc5_.indexOf(_loc8_) == -1)))
                                {
                                    _loc5_.push(_loc8_);
                                };
                            };
                        };
                    };
                };
            };
            return (_loc2_);
        }

        private function onClick(param1:WindowMouseEvent):void
        {
            var _loc3_:Offer;
            var _loc2_:IWindow = (param1.target as IWindow);
            if (_loc2_ == null)
            {
                return;
            };
            switch (_loc2_.name)
            {
                case "ctlg_wall_pattern_prev":
                    this.changePattern(var_2282, -1);
                    break;
                case "ctlg_wall_pattern_next":
                    this.changePattern(var_2282, 1);
                    break;
                case "ctlg_wall_color_prev":
                    this.changeColor(var_2282, -1);
                    break;
                case "ctlg_wall_color_next":
                    this.changeColor(var_2282, 1);
                    break;
                case "ctlg_buy_wall":
                    _loc3_ = this.var_3269[this.var_3271];
                    if (_loc3_ != null)
                    {
                        (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_, page.pageId, this.var_3192);
                    };
                    break;
                case "ctlg_floor_pattern_prev":
                    this.changePattern(var_806, -1);
                    break;
                case "ctlg_floor_pattern_next":
                    this.changePattern(var_806, 1);
                    break;
                case "ctlg_floor_color_prev":
                    this.changeColor(var_806, -1);
                    break;
                case "ctlg_floor_color_next":
                    this.changeColor(var_806, 1);
                    break;
                case "ctlg_buy_floor":
                    _loc3_ = this.var_3264[this.var_3266];
                    if (_loc3_ != null)
                    {
                        (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_, page.pageId, this._floorType);
                    };
                    break;
                case "ctlg_landscape_pattern_next":
                    this.changePattern(TYPE_LANDSCAPE, -1);
                    break;
                case "ctlg_landscape_pattern_prev":
                    this.changePattern(TYPE_LANDSCAPE, 1);
                    break;
                case "ctlg_landscape_color_prev":
                    this.changeColor(TYPE_LANDSCAPE, -1);
                    break;
                case "ctlg_landscape_color_next":
                    this.changeColor(TYPE_LANDSCAPE, 1);
                    break;
                case "ctlg_buy_landscape":
                    _loc3_ = this._landscapeOffers[this.var_3275];
                    if (_loc3_ != null)
                    {
                        (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_, page.pageId, this.var_3193);
                    };
                    break;
                default:
                    Logger.log(("Spaces, unknown button: " + _loc2_.name));
            };
            this.updateConfiguration();
            events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(this._floorType, this.var_3192, this.var_3193, 64));
        }

        private function updateConfiguration():void
        {
            var _loc11_:String;
            var _loc12_:ITextWindow;
            var _loc13_:String;
            var _loc14_:ITextWindow;
            var _loc15_:String;
            var _loc16_:ITextWindow;
            var _loc1_:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            var _loc2_:String = this.var_3265[this.var_3266];
            var _loc3_:Array = this.var_3278[_loc2_];
            if (((!(_loc3_ == null)) && (this.var_3267 >= 0)))
            {
                _loc11_ = _loc3_[this.var_3267];
                if (_loc11_ != null)
                {
                    this._floorType = _loc11_;
                };
            };
            var _loc4_:Offer = this.var_3264[this.var_3266];
            if (_loc4_ != null)
            {
                _loc12_ = (_window.findChildByName("ctlg_floor_price") as ITextWindow);
                if (_loc12_ != null)
                {
                    _loc12_.caption = _loc1_.registerParameter("catalog.purchase.price.credits", "credits", String(_loc4_.priceInCredits));
                };
            };
            var _loc5_:String = this.var_3270[this.var_3271];
            var _loc6_:Array = this.var_3279[_loc5_];
            if (((!(_loc6_ == null)) && (this.var_3272 >= 0)))
            {
                _loc13_ = _loc6_[this.var_3272];
                if (_loc13_ != null)
                {
                    this.var_3192 = _loc13_;
                };
            };
            var _loc7_:Offer = this.var_3269[this.var_3271];
            if (_loc7_ != null)
            {
                _loc14_ = (_window.findChildByName("ctlg_wall_price") as ITextWindow);
                if (_loc14_ != null)
                {
                    _loc14_.caption = _loc1_.registerParameter("catalog.purchase.price.credits", "credits", String(_loc7_.priceInCredits));
                };
            };
            var _loc8_:String = this.var_3274[this.var_3275];
            var _loc9_:Array = this.var_3280[_loc8_];
            if (((!(_loc9_ == null)) && (this.var_3276 >= 0)))
            {
                _loc15_ = _loc9_[this.var_3276];
                if (_loc15_ != null)
                {
                    this.var_3193 = _loc15_;
                };
            };
            var _loc10_:Offer = this._landscapeOffers[this.var_3275];
            if (_loc10_ != null)
            {
                _loc16_ = (_window.findChildByName("ctlg_landscape_price") as ITextWindow);
                if (_loc16_ != null)
                {
                    _loc16_.caption = _loc1_.registerParameter("catalog.purchase.price.credits", "credits", String(_loc10_.priceInCredits));
                };
            };
        }

        private function changePattern(param1:String, param2:int):void
        {
            var _loc3_:IButtonWindow;
            var _loc4_:IButtonWindow;
            var _loc5_:String;
            var _loc6_:Array;
            var _loc7_:String;
            var _loc8_:Array;
            var _loc9_:String;
            var _loc10_:Array;
            switch (param1)
            {
                case var_806:
                    this.var_3266 = (this.var_3266 + param2);
                    if (this.var_3266 < 0)
                    {
                        this.var_3266 = (this.var_3265.length - 1);
                    };
                    if (this.var_3266 >= this.var_3265.length)
                    {
                        this.var_3266 = 0;
                    };
                    this.var_3267 = 0;
                    this.var_3268 = 0;
                    _loc5_ = this.var_3265[this.var_3266];
                    _loc6_ = this.var_3278[_loc5_];
                    if (_loc6_ != null)
                    {
                        this.var_3268 = _loc6_.length;
                    };
                    _loc4_ = (_window.findChildByName("ctlg_floor_color_prev") as IButtonWindow);
                    _loc3_ = (_window.findChildByName("ctlg_floor_color_next") as IButtonWindow);
                    if (this.var_3268 < 2)
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.disable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.disable();
                        };
                    }
                    else
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.enable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.enable();
                        };
                    };
                    return;
                case var_2282:
                    this.var_3271 = (this.var_3271 + param2);
                    if (this.var_3271 < 0)
                    {
                        this.var_3271 = (this.var_3270.length - 1);
                    };
                    if (this.var_3271 == this.var_3270.length)
                    {
                        this.var_3271 = 0;
                    };
                    this.var_3272 = 0;
                    this.var_3273 = 0;
                    _loc7_ = this.var_3270[this.var_3271];
                    _loc8_ = this.var_3279[_loc7_];
                    if (_loc8_ != null)
                    {
                        this.var_3273 = _loc8_.length;
                    };
                    _loc4_ = (_window.findChildByName("ctlg_wall_color_prev") as IButtonWindow);
                    _loc3_ = (_window.findChildByName("ctlg_wall_color_next") as IButtonWindow);
                    if (this.var_3273 < 2)
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.disable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.disable();
                        };
                    }
                    else
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.enable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.enable();
                        };
                    };
                    return;
                case TYPE_LANDSCAPE:
                    this.var_3275 = (this.var_3275 + param2);
                    if (this.var_3275 < 0)
                    {
                        this.var_3275 = (this.var_3274.length - 1);
                    };
                    if (this.var_3275 >= this.var_3274.length)
                    {
                        this.var_3275 = 0;
                    };
                    this.var_3276 = 0;
                    this.var_3277 = 0;
                    _loc9_ = this.var_3274[this.var_3275];
                    _loc10_ = this.var_3280[_loc9_];
                    if (_loc10_ != null)
                    {
                        this.var_3277 = _loc10_.length;
                    };
                    _loc4_ = (_window.findChildByName("ctlg_landscape_color_prev") as IButtonWindow);
                    _loc3_ = (_window.findChildByName("ctlg_landscape_color_next") as IButtonWindow);
                    if (this.var_3277 < 2)
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.disable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.disable();
                        };
                    }
                    else
                    {
                        if (_loc4_ != null)
                        {
                            _loc4_.enable();
                        };
                        if (_loc3_ != null)
                        {
                            _loc3_.enable();
                        };
                    };
                    return;
            };
        }

        private function changeColor(param1:String, param2:int):void
        {
            switch (param1)
            {
                case var_806:
                    this.var_3267 = (this.var_3267 + param2);
                    if (this.var_3267 < 0)
                    {
                        if (this.var_3268 > 0)
                        {
                            this.var_3267 = (this.var_3268 - 1);
                        }
                        else
                        {
                            this.var_3267 = 0;
                        };
                    };
                    if (this.var_3267 >= this.var_3268)
                    {
                        this.var_3267 = 0;
                    };
                    return;
                case var_2282:
                    this.var_3272 = (this.var_3272 + param2);
                    if (this.var_3272 < 0)
                    {
                        if (this.var_3273 > 0)
                        {
                            this.var_3272 = (this.var_3273 - 1);
                        }
                        else
                        {
                            this.var_3272 = 0;
                        };
                    };
                    if (this.var_3272 >= this.var_3273)
                    {
                        this.var_3272 = 0;
                    };
                    return;
                case TYPE_LANDSCAPE:
                    this.var_3276 = (this.var_3276 + param2);
                    if (this.var_3276 < 0)
                    {
                        if (this.var_3277 > 0)
                        {
                            this.var_3276 = (this.var_3277 - 1);
                        }
                        else
                        {
                            this.var_3276 = 0;
                        };
                    };
                    if (this.var_3276 >= this.var_3277)
                    {
                        this.var_3276 = 0;
                    };
                    return;
            };
        }


    }
}