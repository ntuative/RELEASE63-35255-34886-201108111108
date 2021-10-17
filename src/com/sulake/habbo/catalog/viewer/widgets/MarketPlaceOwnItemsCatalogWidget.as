package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.marketplace.IMarketPlaceVisualization;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferState;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.marketplace.IMarketPlace;
    import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferData;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MarketPlaceOwnItemsCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener, IMarketPlaceVisualization 
    {

        private const var_3208:int = 1;
        private const var_3209:int = 2;

        private var var_3217:Map;
        private var _itemList:IItemListWindow;
        private var _offers:Map;

        public function MarketPlaceOwnItemsCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
            this.var_3217 = new Map();
        }

        override public function dispose():void
        {
            super.dispose();
        }

        override public function init():Boolean
        {
            var _loc2_:IWindowContainer;
            var _loc3_:XML;
            if (!super.init())
            {
                return (false);
            };
            if (this.marketPlace == null)
            {
                return (false);
            };
            var _loc1_:IHabboWindowManager = this.marketPlace.windowManager;
            if (_loc1_ == null)
            {
                return (false);
            };
            _loc3_ = this.getAssetXML("marketplace_ongoing_item");
            if (_loc3_ != null)
            {
                _loc2_ = (_loc1_.buildFromXML(_loc3_) as IWindowContainer);
                if (_loc2_)
                {
                    this.var_3217.add(MarketPlaceOfferState.var_1872, _loc2_);
                };
            };
            _loc3_ = this.getAssetXML("marketplace_sold_item");
            if (_loc3_ != null)
            {
                _loc2_ = (_loc1_.buildFromXML(_loc3_) as IWindowContainer);
                if (_loc2_)
                {
                    this.var_3217.add(MarketPlaceOfferState.var_803, _loc2_);
                };
            };
            _loc3_ = this.getAssetXML("marketplace_expired_item");
            if (_loc3_ != null)
            {
                _loc2_ = (_loc1_.buildFromXML(_loc3_) as IWindowContainer);
                if (_loc2_)
                {
                    this.var_3217.add(MarketPlaceOfferState.var_1873, _loc2_);
                };
            };
            this.marketPlace.registerVisualization(this);
            this.displayMainView();
            this.marketPlace.requestOwnItems();
            this.updateStatusDisplay(this.var_3208);
            this.showRedeemInfo(false);
            return (true);
        }

        private function showRedeemInfo(param1:Boolean):void
        {
            if (!window)
            {
                return;
            };
            var _loc2_:IWindowContainer = (window.findChildByName("redeem_border") as IWindowContainer);
            if (_loc2_)
            {
                _loc2_.visible = param1;
            };
        }

        public function listUpdatedNotify():void
        {
            if (this.marketPlace == null)
            {
                return;
            };
            this.updateList(this.marketPlace.latestOwnOffers());
        }

        private function updateStatusDisplay(param1:int, param2:int=-1):void
        {
            var _loc5_:String;
            if (((!(this.marketPlace)) || (!(window))))
            {
                return;
            };
            var _loc3_:ICoreLocalizationManager = this.marketPlace.localization;
            if (!_loc3_)
            {
                return;
            };
            var _loc4_:ITextWindow = (window.findChildByName("status_text") as ITextWindow);
            if (_loc4_ == null)
            {
                return;
            };
            if (param1 == this.var_3208)
            {
                _loc5_ = _loc3_.getKey("catalog.marketplace.searching");
            }
            else
            {
                if (this.var_3209)
                {
                    if (param2 > 0)
                    {
                        _loc5_ = _loc3_.getKey("catalog.marketplace.items_found");
                        _loc5_ = _loc5_.replace("%count%", param2);
                    }
                    else
                    {
                        _loc5_ = _loc3_.getKey("catalog.marketplace.no_items");
                    };
                };
            };
            _loc4_.text = _loc5_;
        }

        private function get marketPlace():IMarketPlace
        {
            if ((((!(page)) || (!(page.viewer))) || (!(page.viewer.catalog))))
            {
                return (null);
            };
            return (page.viewer.catalog.getMarketPlace());
        }

        private function updateList(param1:Map):void
        {
            var _loc4_:IWindowContainer;
            var _loc10_:int;
            var _loc11_:MarketPlaceOfferData;
            var _loc12_:IWindowContainer;
            var _loc13_:ITextWindow;
            var _loc14_:ITextWindow;
            var _loc15_:ITextWindow;
            var _loc16_:String;
            var _loc17_:ITextWindow;
            var _loc18_:int;
            var _loc19_:int;
            var _loc20_:int;
            var _loc21_:String;
            var _loc22_:String;
            var _loc23_:ITextWindow;
            var _loc24_:ITextWindow;
            var _loc25_:ImageResult;
            var _loc26_:IBitmapWrapperWindow;
            var _loc27_:Point;
            if ((((!(param1)) || (!(this.marketPlace))) || (!(window))))
            {
                return;
            };
            this._offers = param1;
            var _loc2_:ICoreLocalizationManager = this.marketPlace.localization;
            if (!_loc2_)
            {
                return;
            };
            var _loc3_:IItemListWindow = (window.findChildByName("item_list") as IItemListWindow);
            if (!_loc3_)
            {
                return;
            };
            _loc3_.destroyListItems();
            var _loc5_:int;
            var _loc6_:Array = param1.getKeys();
            if (!_loc6_)
            {
                return;
            };
            this.updateStatusDisplay(this.var_3209, _loc6_.length);
            var _loc7_:int;
            while (_loc7_ < _loc6_.length)
            {
                _loc10_ = _loc6_[_loc7_];
                _loc11_ = (param1.getValue(_loc10_) as MarketPlaceOfferData);
                if (_loc11_.status == MarketPlaceOfferState.var_803)
                {
                    _loc5_++;
                };
                _loc4_ = this.var_3217.getValue(_loc11_.status);
                if (_loc4_)
                {
                    _loc12_ = (_loc4_.clone() as IWindowContainer);
                    if (!((!(_loc12_)) || (_loc12_.disposed)))
                    {
                        _loc13_ = (_loc12_.findChildByName("item_name") as ITextWindow);
                        if (_loc13_ != null)
                        {
                            _loc13_.text = ((this.marketPlace != null) ? ((("$" + "{") + this.marketPlace.getNameLocalizationKey(_loc11_)) + "}") : "");
                        };
                        _loc14_ = (_loc12_.findChildByName("item_desc") as ITextWindow);
                        if (_loc14_ != null)
                        {
                            _loc14_.text = ((this.marketPlace != null) ? ((("$" + "{") + this.marketPlace.getDescriptionLocalizationKey(_loc11_)) + "}") : "");
                        };
                        _loc15_ = (_loc12_.findChildByName("item_price") as ITextWindow);
                        if (_loc15_ != null)
                        {
                            _loc16_ = _loc2_.getKey("catalog.marketplace.offer.price_own_item");
                            _loc16_ = _loc16_.replace("%price%", _loc11_.price);
                            _loc15_.text = _loc16_;
                        };
                        if (_loc11_.status == MarketPlaceOfferState.var_1872)
                        {
                            _loc17_ = (_loc12_.findChildByName("item_time") as ITextWindow);
                            if (_loc17_ != null)
                            {
                                _loc18_ = Math.max(1, _loc11_.timeLeftMinutes);
                                _loc19_ = int(Math.floor((_loc18_ / 60)));
                                _loc20_ = (_loc18_ - (_loc19_ * 60));
                                _loc21_ = ((_loc20_ + " ") + _loc2_.getKey("catalog.marketplace.offer.minutes"));
                                if (_loc19_ > 0)
                                {
                                    _loc21_ = ((((_loc19_ + " ") + _loc2_.getKey("catalog.marketplace.offer.hours")) + " ") + _loc21_);
                                };
                                _loc22_ = _loc2_.getKey("catalog.marketplace.offer.time_left");
                                _loc22_ = _loc22_.replace("%time%", _loc21_);
                                _loc17_.text = _loc22_;
                            };
                        };
                        if (_loc11_.status == MarketPlaceOfferState.var_803)
                        {
                            _loc23_ = (_loc12_.findChildByName("item_sold") as ITextWindow);
                            if (_loc23_ != null)
                            {
                                _loc23_.text = _loc2_.getKey("catalog.marketplace.offer.sold");
                            };
                        };
                        if (_loc11_.status == MarketPlaceOfferState.var_1873)
                        {
                            _loc24_ = (_loc12_.findChildByName("item_expired") as ITextWindow);
                            if (_loc24_ != null)
                            {
                                _loc24_.text = _loc2_.getKey("catalog.marketplace.offer.expired");
                            };
                        };
                        if (_loc11_.image == null)
                        {
                            _loc25_ = this.getFurniImageResult(_loc11_.furniId, _loc11_.furniType, _loc11_.stuffData);
                            if (((!(_loc25_ == null)) && (!(_loc25_.data == null))))
                            {
                                _loc11_.image = (_loc25_.data as BitmapData);
                                _loc11_.imageCallback = _loc25_.id;
                                _loc12_.id = _loc25_.id;
                            };
                        };
                        if (_loc11_.image != null)
                        {
                            _loc26_ = (_loc12_.findChildByName("item_image") as IBitmapWrapperWindow);
                            if (_loc26_ != null)
                            {
                                _loc27_ = new Point(((_loc26_.width - _loc11_.image.width) / 2), ((_loc26_.height - _loc11_.image.height) / 2));
                                if (_loc26_.bitmap == null)
                                {
                                    _loc26_.bitmap = new BitmapData(_loc26_.width, _loc26_.height, true, 0);
                                };
                                _loc26_.bitmap.copyPixels(_loc11_.image, _loc11_.image.rect, _loc27_);
                            };
                        };
                        _loc3_.addListItem(_loc12_);
                        _loc12_.procedure = this.onGridEvent;
                    };
                };
                _loc7_++;
            };
            this.showRedeemInfo(true);
            var _loc8_:IButtonWindow = (window.findChildByName("redeem_sold") as IButtonWindow);
            var _loc9_:ITextWindow = (window.findChildByName("redeem_info") as ITextWindow);
            if (((_loc8_) && (_loc9_)))
            {
                if (_loc5_ > 0)
                {
                    _loc8_.enable();
                    _loc2_.registerParameter("catalog.marketplace.redeem.get_credits", "count", _loc5_.toString());
                    _loc2_.registerParameter("catalog.marketplace.redeem.get_credits", "credits", this.marketPlace.creditsWaiting.toString());
                    _loc9_.text = ("$" + "{catalog.marketplace.redeem.get_credits}");
                }
                else
                {
                    _loc8_.disable();
                    _loc9_.text = ("$" + "{catalog.marketplace.redeem.no_sold_items}");
                };
            };
        }

        public function displayMainView():void
        {
            var _loc1_:XML = this.getAssetXML("marketPlaceOwnItemsWidget");
            if (((!(_loc1_)) || (!(window))))
            {
                return;
            };
            window.removeChildAt(0);
            if (((((!(page)) || (!(page.viewer))) || (!(page.viewer.catalog))) || (!(page.viewer.catalog.windowManager))))
            {
                return;
            };
            window.addChild(page.viewer.catalog.windowManager.buildFromXML(_loc1_));
            window.procedure = this.onWidgetEvent;
            this._itemList = (window.findChildByName("item_list") as IItemListWindow);
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

        private function onGridEvent(param1:WindowEvent, param2:IWindow=null):void
        {
            var _loc3_:IItemListWindow;
            var _loc4_:int;
            var _loc5_:Map;
            var _loc6_:MarketPlaceOfferData;
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                if ((((!(this.marketPlace)) || (!(param2))) || (!(window))))
                {
                    return;
                };
                if (param2.name == "pick_button")
                {
                    _loc3_ = (window.findChildByName("item_list") as IItemListWindow);
                    if (_loc3_ == null)
                    {
                        return;
                    };
                    _loc4_ = _loc3_.getListItemIndex(param1.window.parent);
                    _loc5_ = this.marketPlace.latestOwnOffers();
                    if (!_loc5_)
                    {
                        return;
                    };
                    _loc6_ = (_loc5_.getWithIndex(_loc4_) as MarketPlaceOfferData);
                    if (_loc6_)
                    {
                        this.marketPlace.redeemExpiredOffer(_loc6_.offerId);
                    };
                };
            };
        }

        private function onWidgetEvent(param1:WindowEvent, param2:IWindow):void
        {
            if (param2 == null)
            {
                param2 = (param1.target as IWindow);
            };
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "redeem_sold":
                        if (this.marketPlace)
                        {
                            this.marketPlace.redeemSoldOffers();
                        };
                        return;
                };
            };
        }

        public function updateStats():void
        {
        }


    }
}