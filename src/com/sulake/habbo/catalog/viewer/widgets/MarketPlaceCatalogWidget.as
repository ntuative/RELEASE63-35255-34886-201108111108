package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.marketplace.IMarketPlaceVisualization;
    import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferData;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.core.utils.Map;
    import flash.events.TimerEvent;
    import com.sulake.habbo.catalog.marketplace.MarketplaceChart;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.marketplace.MarketplaceItemStats;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.catalog.marketplace.IMarketPlace;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.ImageResult;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Matrix;
    import com.sulake.core.window.components.ITextFieldWindow;

    public class MarketPlaceCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener, IMarketPlaceVisualization 
    {

        private const var_3208:int = 1;
        private const var_3209:int = 2;
        private const var_3210:int = 40;
        private const var_3211:int = 10;

        private var var_3212:Array = [];
        private var var_3213:MarketPlaceOfferData;
        private var _itemList:IItemListWindow;
        private var var_3214:IWindowContainer;
        private var var_3215:Timer;
        private var _offers:Map;
        private var var_3216:int;

        public function MarketPlaceCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            super.dispose();
            this.var_3213 = null;
            this._offers = null;
            this._itemList = null;
            if (this.var_3214)
            {
                this.var_3214.dispose();
                this.var_3214 = null;
            };
            if (this.var_3215)
            {
                this.var_3215.removeEventListener(TimerEvent.TIMER, this.onPopulationTimer);
                this.var_3215 = null;
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            if (this.marketPlace == null)
            {
                return (false);
            };
            this.marketPlace.registerVisualization(this);
            this.displayMainView();
            return (true);
        }

        public function listUpdatedNotify():void
        {
            this.hideDetails();
            this.updateList();
        }

        public function updateStats():void
        {
            var _loc6_:MarketplaceChart;
            var _loc9_:BitmapData;
            var _loc10_:String;
            if ((((!(this.marketPlace)) || (!(this.marketPlace.localization))) || (!(_window))))
            {
                return;
            };
            var _loc1_:MarketplaceItemStats = this.marketPlace.itemStats;
            if (!_loc1_)
            {
                return;
            };
            var _loc2_:IWindowContainer = (_window.findChildByName("details_container") as IWindowContainer);
            if (((!(_loc2_)) || (!(_loc2_.visible))))
            {
                return;
            };
            var _loc3_:ITextWindow = (_loc2_.findChildByName("offer_count") as ITextWindow);
            if (_loc3_)
            {
                this.marketPlace.localization.registerParameter("catalog.marketplace.offer_details.offer_count", "count", _loc1_.offerCount.toString());
                _loc3_.visible = true;
            };
            var _loc4_:ISelectorWindow = (_loc2_.findChildByName("chart_selector") as ISelectorWindow);
            if (!_loc4_)
            {
                return;
            };
            var _loc5_:ISelectableWindow = _loc4_.getSelected();
            if (!_loc5_)
            {
                return;
            };
            switch (_loc5_.name)
            {
                case "price_development":
                    _loc6_ = new MarketplaceChart(_loc1_.dayOffsets, _loc1_.averagePrices);
                    break;
                case "trade_volume":
                    _loc6_ = new MarketplaceChart(_loc1_.dayOffsets, _loc1_.soldAmounts);
                    break;
                default:
                    return;
            };
            if (!_loc6_)
            {
                return;
            };
            var _loc7_:IBitmapWrapperWindow = (_loc2_.findChildByName("chart_bitmap") as IBitmapWrapperWindow);
            if (_loc7_)
            {
                _loc7_.bitmap = null;
                _loc7_.bitmap = new BitmapData(_loc7_.width, _loc7_.height);
                _loc9_ = _loc6_.draw(_loc7_.width, _loc7_.height);
                _loc7_.bitmap.draw(_loc9_);
                _loc9_.dispose();
            };
            var _loc8_:ITextWindow = (_loc2_.findChildByName("chart_title") as ITextWindow);
            if (_loc8_)
            {
                if (_loc6_.available)
                {
                    _loc10_ = ("catalog.marketplace.offer_details.chart_title." + _loc5_.name);
                    this.marketPlace.localization.registerParameter(_loc10_, "days", _loc1_.historyLength.toString());
                }
                else
                {
                    _loc10_ = "catalog.marketplace.offer_details.chart_title.not_available";
                };
                _loc8_.text = this.marketPlace.localization.getKey(_loc10_);
            };
        }

        private function get marketPlace():IMarketPlace
        {
            if ((((page) && (page.viewer)) && (page.viewer.catalog)))
            {
                return (page.viewer.catalog.getMarketPlace());
            };
            return (null);
        }

        public function displayMainView():void
        {
            var _loc1_:XML = this.getAssetXML("marketPlaceWidget");
            if (_loc1_ == null)
            {
                return;
            };
            window.removeChildAt(0);
            if (((((!(window)) || (!(page))) || (!(page.viewer))) || (!(page.viewer.catalog))))
            {
                return;
            };
            window.addChild(page.viewer.catalog.windowManager.buildFromXML(_loc1_));
            window.procedure = this.onWidgetEvent;
            this._itemList = (window.findChildByName("offer_list") as IItemListWindow);
            this.selectSearchCategory("search_by_activity");
        }

        private function selectSearchCategory(param1:String):void
        {
            var _loc5_:String;
            var _loc2_:ISelectorWindow = (_window.findChildByName("search_selector") as ISelectorWindow);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:ISelectableWindow = _loc2_.getSelectableByName(param1);
            if (_loc3_ == null)
            {
                return;
            };
            _loc2_.setSelected(_loc3_);
            var _loc4_:IWindowContainer = (_window.findChildByName("search_container") as IWindowContainer);
            if (_loc4_ == null)
            {
                return;
            };
            while (_loc4_.numChildren > 0)
            {
                _loc4_.removeChildAt(0);
            };
            switch (param1)
            {
                case "search_by_value":
                    _loc5_ = "marketplace_search_simple";
                    this.var_3212 = [1, 2];
                    break;
                case "search_by_activity":
                    _loc5_ = "marketplace_search_simple";
                    this.var_3212 = [3, 4, 5, 6];
                    break;
                case "search_advanced":
                    _loc5_ = "marketplace_search_advanced";
                    this.var_3212 = [1, 2, 3, 4, 5, 6];
                    break;
                default:
                    return;
            };
            var _loc6_:IWindowContainer = (this.createWindow(_loc5_) as IWindowContainer);
            _loc4_.addChild(_loc6_);
            _loc4_.rectangle = _loc6_.rectangle;
            this.resizeOfferList();
            var _loc7_:IDropMenuWindow = (_window.findChildByName("sort_dropmenu") as IDropMenuWindow);
            if (_loc7_ != null)
            {
                _loc7_.populate(this.getSortKeys(this.var_3212));
                _loc7_.selection = 0;
            };
        }

        private function getSortKeys(param1:Array):Array
        {
            var _loc3_:int;
            var _loc2_:Array = [];
            for each (_loc3_ in param1)
            {
                _loc2_.push(((("$" + "{catalog.marketplace.sort.") + _loc3_) + "}"));
            };
            return (_loc2_);
        }

        private function createWindow(param1:String):IWindow
        {
            if ((((((!(page)) || (!(page.viewer))) || (!(page.viewer.catalog))) || (!(page.viewer.catalog.assets))) || (!(page.viewer.catalog.windowManager))))
            {
                return (null);
            };
            var _loc2_:XmlAsset = (page.viewer.catalog.assets.getAssetByName(param1) as XmlAsset);
            if (((!(_loc2_)) || (!(_loc2_.content))))
            {
                return (null);
            };
            var _loc3_:XML = (_loc2_.content as XML);
            if (!_loc3_)
            {
                return (null);
            };
            return (page.viewer.catalog.windowManager.buildFromXML(_loc3_));
        }

        private function resizeOfferList():void
        {
            if (!_window)
            {
                return;
            };
            var _loc1_:IItemListWindow = (_window.findChildByName("main_item_list") as IItemListWindow);
            var _loc2_:IWindowContainer = (_window.findChildByName("offer_list_container") as IWindowContainer);
            _loc2_.height = (_loc1_.height - _loc2_.y);
        }

        private function updateStatusDisplay(param1:int, param2:int=-1, param3:int=-1):void
        {
            var _loc6_:String;
            var _loc4_:ICoreLocalizationManager = this.marketPlace.localization;
            if (!_loc4_)
            {
                return;
            };
            if (((((!(window)) || (!(page))) || (!(page.viewer))) || (!(page.viewer.catalog))))
            {
                return;
            };
            var _loc5_:ITextWindow = (window.findChildByName("status_text") as ITextWindow);
            if (_loc5_ == null)
            {
                return;
            };
            if (param1 == this.var_3208)
            {
                _loc6_ = _loc4_.getKey("catalog.marketplace.searching");
            }
            else
            {
                if (this.var_3209)
                {
                    if (param3 > 0)
                    {
                        _loc6_ = _loc4_.getKey("catalog.marketplace.items_found");
                        _loc6_ = _loc6_.replace("%count%", param3);
                        if (((param2 > 0) && (param2 < param3)))
                        {
                            _loc6_ = (_loc6_ + ((". " + _loc4_.getKey("catalog.marketplace.items_shown")) + "."));
                            _loc6_ = _loc6_.replace("%count%", param2);
                        };
                    }
                    else
                    {
                        _loc6_ = _loc4_.getKey("catalog.marketplace.no_items");
                    };
                };
            };
            _loc5_.text = _loc6_;
        }

        private function updateList():void
        {
            var _loc4_:XML;
            var _loc5_:IHabboWindowManager;
            if (((!(this.marketPlace)) || (!(window))))
            {
                return;
            };
            var _loc1_:Map = this.marketPlace.latestOffers();
            if (!_loc1_)
            {
                return;
            };
            var _loc2_:int = this.marketPlace.totalItemsFound();
            this._offers = _loc1_;
            if (!this._itemList)
            {
                return;
            };
            this._itemList.destroyListItems();
            if (!this.var_3214)
            {
                _loc4_ = this.getAssetXML("marketplace_offers_item");
                if (!_loc4_)
                {
                    return;
                };
                _loc5_ = this.marketPlace.windowManager;
                if (_loc5_ == null)
                {
                    return;
                };
                this.var_3214 = (_loc5_.buildFromXML(_loc4_) as IWindowContainer);
            };
            if (!this.var_3214)
            {
                return;
            };
            var _loc3_:Array = _loc1_.getKeys();
            if (_loc3_ == null)
            {
                return;
            };
            this.updateStatusDisplay(this.var_3209, _loc3_.length, _loc2_);
            if (!this.var_3215)
            {
                this.var_3215 = new Timer(25);
                this.var_3215.addEventListener(TimerEvent.TIMER, this.onPopulationTimer);
            };
            this.var_3216 = 0;
            this.populateList();
            this.var_3215.start();
        }

        private function onPopulationTimer(param1:TimerEvent):void
        {
            if (!this.var_3215)
            {
                return;
            };
            if (this.populateList())
            {
                this.var_3215.stop();
            };
        }

        private function populateList():Boolean
        {
            if (!this._offers)
            {
                return (true);
            };
            var _loc1_:int;
            while (_loc1_ < 5)
            {
                if (this.var_3216 >= this._offers.length)
                {
                    return (true);
                };
                this.addListItem(this._offers.getWithIndex(this.var_3216));
                this.var_3216++;
                _loc1_++;
            };
            return (false);
        }

        private function addListItem(param1:MarketPlaceOfferData):void
        {
            var _loc7_:String;
            var _loc8_:String;
            var _loc9_:ImageResult;
            var _loc10_:IBitmapWrapperWindow;
            var _loc11_:Point;
            if (((((!(param1)) || (!(this._itemList))) || (!(this.var_3214))) || (!(this.marketPlace.localization))))
            {
                return;
            };
            var _loc2_:IWindowContainer = (this.var_3214.clone() as IWindowContainer);
            if (((!(_loc2_)) || (_loc2_.disposed)))
            {
                return;
            };
            var _loc3_:ITextWindow = (_loc2_.findChildByName("item_name") as ITextWindow);
            if (_loc3_ != null)
            {
                _loc3_.text = ((("$" + "{") + this.marketPlace.getNameLocalizationKey(param1)) + "}");
            };
            var _loc4_:ITextWindow = (_loc2_.findChildByName("item_desc") as ITextWindow);
            if (_loc4_ != null)
            {
                _loc4_.text = ((("$" + "{") + this.marketPlace.getDescriptionLocalizationKey(param1)) + "}");
            };
            var _loc5_:ITextWindow = (_loc2_.findChildByName("item_price") as ITextWindow);
            if (_loc5_ != null)
            {
                _loc7_ = this.marketPlace.localization.getKey("catalog.marketplace.offer.price_public_item");
                _loc7_ = _loc7_.replace("%price%", param1.price);
                _loc7_ = _loc7_.replace("%average%", ((param1.averagePrice != 0) ? param1.averagePrice.toString() : " - "));
                _loc5_.text = _loc7_;
            };
            var _loc6_:ITextWindow = (_loc2_.findChildByName("offer_count") as ITextWindow);
            if (_loc6_)
            {
                _loc8_ = this.marketPlace.localization.getKey("catalog.marketplace.offer_count");
                _loc8_ = _loc8_.replace("%count%", param1.offerCount);
                _loc6_.text = _loc8_;
            };
            if (param1.image == null)
            {
                _loc9_ = this.getFurniImageResult(param1.furniId, param1.furniType, param1.stuffData);
                if (((!(_loc9_ == null)) && (!(_loc9_.data == null))))
                {
                    param1.image = (_loc9_.data as BitmapData);
                    param1.imageCallback = _loc9_.id;
                    _loc2_.id = _loc9_.id;
                };
            };
            if (param1.image != null)
            {
                _loc10_ = (_loc2_.findChildByName("item_image") as IBitmapWrapperWindow);
                if (_loc10_ != null)
                {
                    _loc11_ = new Point(((_loc10_.width - param1.image.width) / 2), ((_loc10_.height - param1.image.height) / 2));
                    if (_loc10_.bitmap == null)
                    {
                        _loc10_.bitmap = new BitmapData(_loc10_.width, _loc10_.height, true, 0);
                    };
                    _loc10_.bitmap.copyPixels(param1.image, param1.image.rect, _loc11_);
                };
            };
            this._itemList.addListItem(_loc2_);
            _loc2_.procedure = this.onOfferListEvent;
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            var _loc4_:IWindowContainer;
            var _loc5_:MarketPlaceOfferData;
            var _loc6_:IBitmapWrapperWindow;
            var _loc7_:Point;
            if ((((((disposed) || (!(this.marketPlace))) || (!(param2))) || (!(this._itemList))) || (!(this._offers))))
            {
                return;
            };
            var _loc3_:Array = [];
            if (this._itemList.groupListItemsWithID(param1, _loc3_))
            {
                for each (_loc4_ in _loc3_)
                {
                    if (_loc4_)
                    {
                        _loc6_ = (_loc4_.findChildByName("item_image") as IBitmapWrapperWindow);
                        if (_loc6_ != null)
                        {
                            _loc6_.bitmap = new BitmapData(_loc6_.width, _loc6_.height, true, 0xFFFFFF);
                            _loc7_ = new Point(((_loc6_.width - param2.width) / 2), ((_loc6_.height - param2.height) / 2));
                            _loc6_.bitmap.copyPixels(param2, param2.rect, _loc7_, null, null, true);
                        };
                        _loc4_.id = 0;
                    };
                };
            };
            for each (_loc5_ in this._offers)
            {
                if (_loc5_.imageCallback == param1)
                {
                    _loc5_.imageCallback = 0;
                    _loc5_.image = param2;
                };
            };
        }

        private function getFurniImageResult(param1:int, param2:int, param3:String=null):ImageResult
        {
            if ((((!(page)) || (!(page.viewer))) || (!(page.viewer.roomEngine))))
            {
                return (null);
            };
            if (param2 == 1)
            {
                return (page.viewer.roomEngine.getFurnitureIcon(param1, this));
            };
            if (param2 == 2)
            {
                return (page.viewer.roomEngine.getWallItemIcon(param1, this, param3));
            };
            return (null);
        }

        private function onOfferListEvent(param1:WindowEvent, param2:IWindow=null):void
        {
            var _loc3_:int;
            var _loc4_:Map;
            var _loc5_:MarketPlaceOfferData;
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                if ((((!(window)) || (!(this.marketPlace))) || (!(param2))))
                {
                    return;
                };
                if (this._itemList == null)
                {
                    return;
                };
                _loc3_ = this._itemList.getListItemIndex(param1.window.parent);
                _loc4_ = this.marketPlace.latestOffers();
                _loc5_ = (_loc4_.getWithIndex(_loc3_) as MarketPlaceOfferData);
                if (!_loc5_)
                {
                    return;
                };
                switch (param2.name)
                {
                    case "buy_button":
                        this.marketPlace.buyOffer(_loc5_.offerId);
                        return;
                    case "more_button":
                        this.showDetails(_loc5_);
                        return;
                };
            };
        }

        private function showDetails(param1:MarketPlaceOfferData):void
        {
            var _loc9_:ImageResult;
            var _loc10_:IBitmapWrapperWindow;
            if ((((!(param1)) || (!(_window))) || (!(this.marketPlace))))
            {
                return;
            };
            this.var_3213 = param1;
            var _loc2_:ICoreLocalizationManager = this.marketPlace.localization;
            if (!_loc2_)
            {
                return;
            };
            var _loc3_:IWindow = _window.findChildByName("main_item_list");
            if (_loc3_)
            {
                _loc3_.visible = false;
            };
            var _loc4_:IWindowContainer = (_window.findChildByName("details_container") as IWindowContainer);
            if (_loc4_)
            {
                _loc4_.visible = true;
            }
            else
            {
                _loc4_ = (this.createWindow("marketplace_offer_details") as IWindowContainer);
                _window.addChild(_loc4_);
                _loc4_.procedure = this.detailsEventHandler;
            };
            var _loc5_:ITextWindow = (_loc4_.findChildByName("item_name") as ITextWindow);
            if (_loc5_)
            {
                _loc5_.text = ((("$" + "{") + this.marketPlace.getNameLocalizationKey(param1)) + "}");
            };
            _loc5_ = (_loc4_.findChildByName("item_description") as ITextWindow);
            if (_loc5_)
            {
                _loc5_.text = ((("$" + "{") + this.marketPlace.getDescriptionLocalizationKey(param1)) + "}");
            };
            _loc5_ = (_loc4_.findChildByName("item_count") as ITextWindow);
            if (_loc5_)
            {
                _loc5_.visible = false;
            };
            _loc2_.registerParameter("catalog.marketplace.offer_details.price", "price", param1.price.toString());
            _loc2_.registerParameter("catalog.marketplace.offer_details.average_price", "days", this.marketPlace.averagePricePeriod.toString());
            var _loc6_:String = ((param1.averagePrice == 0) ? " - " : param1.averagePrice.toString());
            _loc2_.registerParameter("catalog.marketplace.offer_details.average_price", "average", _loc6_);
            if (param1.image == null)
            {
                _loc9_ = this.getFurniImageResult(param1.furniId, param1.furniType, param1.stuffData);
                if (((!(_loc9_ == null)) && (!(_loc9_.data == null))))
                {
                    param1.image = (_loc9_.data as BitmapData);
                    param1.imageCallback = _loc9_.id;
                };
            };
            if (param1.image != null)
            {
                _loc10_ = (_loc4_.findChildByName("item_image") as IBitmapWrapperWindow);
                if (_loc10_ != null)
                {
                    _loc10_.bitmap = null;
                    _loc10_.bitmap = new BitmapData(_loc10_.width, _loc10_.height, true, 0);
                    _loc10_.bitmap.draw(param1.image, new Matrix(1, 0, 0, 1, ((_loc10_.width - param1.image.width) / 2), ((_loc10_.height - param1.image.height) / 2)));
                };
            };
            var _loc7_:ISelectorWindow = (_loc4_.findChildByName("chart_selector") as ISelectorWindow);
            if (_loc7_)
            {
                _loc7_.setSelected(_loc7_.getSelectableAt(0));
            };
            var _loc8_:IBitmapWrapperWindow = (_loc4_.findChildByName("chart_bitmap") as IBitmapWrapperWindow);
            if (_loc8_)
            {
                _loc8_.bitmap = null;
            };
            this.marketPlace.requestItemStats(param1.furniType, param1.furniId);
        }

        private function hideDetails():void
        {
            if (!_window)
            {
                return;
            };
            this.var_3213 = null;
            var _loc1_:IWindow = _window.findChildByName("details_container");
            if (_loc1_)
            {
                _loc1_.visible = false;
            };
            _loc1_ = _window.findChildByName("main_item_list");
            if (_loc1_)
            {
                _loc1_.visible = true;
            };
        }

        private function doSearch():void
        {
            var _loc5_:ITextFieldWindow;
            this.updateStatusDisplay(this.var_3208);
            var _loc1_:int = -1;
            var _loc2_:int = -1;
            var _loc3_:String = "";
            var _loc4_:int = 1;
            _loc5_ = (_window.findChildByName("min_price_input") as ITextFieldWindow);
            if (_loc5_)
            {
                if (_loc5_.text == "")
                {
                    _loc1_ = -1;
                }
                else
                {
                    _loc1_ = parseInt(_loc5_.text);
                };
            };
            _loc5_ = (_window.findChildByName("max_price_input") as ITextFieldWindow);
            if (_loc5_)
            {
                if (_loc5_.text == "")
                {
                    _loc2_ = -1;
                }
                else
                {
                    _loc2_ = parseInt(_loc5_.text);
                };
            };
            _loc5_ = (_window.findChildByName("search_input") as ITextFieldWindow);
            if (_loc5_)
            {
                _loc3_ = _loc5_.text;
            };
            var _loc6_:IDropMenuWindow = (_window.findChildByName("sort_dropmenu") as IDropMenuWindow);
            if ((((_loc6_) && (_loc6_.selection >= 0)) && (_loc6_.selection < this.var_3212.length)))
            {
                _loc4_ = this.var_3212[_loc6_.selection];
            };
            this.marketPlace.requestOffers(_loc1_, _loc2_, _loc3_, _loc4_);
        }

        private function onWidgetEvent(param1:WindowEvent, param2:IWindow=null):void
        {
            var _loc5_:ISelectorWindow;
            var _loc6_:ISelectableWindow;
            var _loc7_:ITextFieldWindow;
            var _loc8_:int;
            if ((((!(param1)) || (!(param2))) || (!(this.marketPlace))))
            {
                return;
            };
            var _loc3_:ICoreLocalizationManager = this.marketPlace.localization;
            var _loc4_:ITextWindow = (window.findChildByName("search_input") as ITextWindow);
            if (param1.type == WindowEvent.var_576)
            {
                switch (param2.name)
                {
                    case "sort_dropmenu":
                        _loc5_ = (_window.findChildByName("search_selector") as ISelectorWindow);
                        if (!_loc5_)
                        {
                            return;
                        };
                        _loc6_ = _loc5_.getSelected();
                        if (!_loc6_)
                        {
                            return;
                        };
                        if (((_loc6_.name == "search_by_value") || (_loc6_.name == "search_by_activity")))
                        {
                            this.doSearch();
                        };
                        break;
                    case "search_by_value":
                    case "search_by_activity":
                    case "search_advanced":
                        this.selectSearchCategory(param2.name);
                        break;
                };
            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                {
                    switch (param2.name)
                    {
                        case "search_input":
                            if ((((_loc3_) && (_loc4_)) && (_loc4_.text == _loc3_.getKey("catalog.marketplace.search_name"))))
                            {
                                _loc4_.text = "";
                            };
                            break;
                        case "search_button":
                            if ((((_loc3_) && (_loc4_)) && (_loc4_.text == _loc3_.getKey("catalog.marketplace.search_name"))))
                            {
                                return;
                            };
                            this.doSearch();
                            break;
                    };
                }
                else
                {
                    if (param1.type == WindowEvent.var_606)
                    {
                        _loc7_ = (param2 as ITextFieldWindow);
                        if (!_loc7_)
                        {
                            return;
                        };
                        switch (_loc7_.name)
                        {
                            case "min_price_input":
                            case "max_price_input":
                                _loc8_ = this.var_3211;
                                break;
                            case "search_input":
                                _loc8_ = this.var_3210;
                                break;
                            default:
                                return;
                        };
                        if (_loc7_.text.length > _loc8_)
                        {
                            _loc7_.text = _loc7_.text.substr(0, _loc8_);
                        };
                        _loc7_.scrollH = 0;
                    };
                };
            };
        }

        private function detailsEventHandler(param1:WindowEvent, param2:IWindow):void
        {
            if (((!(param1)) || (!(param2))))
            {
                return;
            };
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "back_button":
                        this.hideDetails();
                        return;
                    case "buy_button":
                        this.marketPlace.buyOffer(this.var_3213.offerId);
                        return;
                };
                return;
            };
            if (param1.type == WindowEvent.var_576)
            {
                switch (param2.name)
                {
                    case "price_development":
                    case "trade_volume":
                        this.updateStats();
                        return;
                };
            };
        }

        private function getAssetXML(param1:String):XML
        {
            if (((((!(page)) || (!(page.viewer))) || (!(page.viewer.catalog))) || (!(page.viewer.catalog.assets))))
            {
                return (null);
            };
            var _loc2_:XmlAsset = (page.viewer.catalog.assets.getAssetByName(param1) as XmlAsset);
            if (_loc2_ == null)
            {
                return (null);
            };
            return (_loc2_.content as XML);
        }


    }
}