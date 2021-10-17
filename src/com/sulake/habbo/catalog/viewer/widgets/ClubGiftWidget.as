package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.club.ClubGiftController;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.viewer.Product;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.catalog.viewer.IProductContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Rectangle;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.room.utils.Vector3d;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.assets.XmlAsset;

    public class ClubGiftWidget extends CatalogWidget implements ICatalogWidget 
    {

        private const var_3196:int = 31;

        private var var_2438:ClubGiftController;
        private var _itemList:IItemListWindow;
        private var _offers:Map;
        private var var_3195:IWindowContainer;

        public function ClubGiftWidget(param1:IWindowContainer, param2:ClubGiftController)
        {
            super(param1);
            this.var_2438 = param2;
            this._offers = new Map();
        }

        override public function dispose():void
        {
            super.dispose();
            this.var_2438 = null;
            if (this.var_3195)
            {
                this.var_3195.dispose();
                this.var_3195 = null;
            };
        }

        override public function init():Boolean
        {
            if (!window)
            {
                return (false);
            };
            if (!super.init())
            {
                return (false);
            };
            this.var_2438.widget = this;
            var _loc1_:IWindowContainer = (window.findChildByName("widget_main_container") as IWindowContainer);
            if (!_loc1_)
            {
                _loc1_ = (this.createWindow("clubGiftWidget") as IWindowContainer);
                if (!_loc1_)
                {
                    return (false);
                };
                window.addChild(_loc1_);
                this._itemList = (_loc1_.findChildByName("gift_list") as IItemListWindow);
            };
            this.update();
            return (true);
        }

        public function update():void
        {
            this.updateInfo();
            this.updateList();
        }

        private function updateInfo():void
        {
            var _loc2_:String;
            var _loc3_:int;
            var _loc4_:int;
            var _loc7_:int;
            if (((!(this.var_2438)) || (!(window))))
            {
                return;
            };
            var _loc1_:ITextWindow = (window.findChildByName("info_text") as ITextWindow);
            if (!_loc1_)
            {
                return;
            };
            if (this.var_2438.giftsAvailable > 0)
            {
                _loc2_ = "catalog.club_gift.available";
                this.var_2438.localization.registerParameter(_loc2_, "amount", this.var_2438.giftsAvailable.toString());
            }
            else
            {
                if (this.var_2438.daysUntilNextGift > 0)
                {
                    _loc2_ = "catalog.club_gift.days_until_next";
                    this.var_2438.localization.registerParameter(_loc2_, "days", this.var_2438.daysUntilNextGift.toString());
                }
                else
                {
                    if (this.var_2438.hasClub)
                    {
                        _loc2_ = "catalog.club_gift.not_available";
                    }
                    else
                    {
                        _loc2_ = "catalog.club_gift.no_club";
                    };
                };
            };
            _loc1_.text = this.var_2438.localization.getKey(_loc2_);
            if (!this.var_2438.purse)
            {
                return;
            };
            var _loc5_:ITextWindow = (window.findChildByName("past_club_days") as ITextWindow);
            if (_loc5_)
            {
                _loc7_ = (this.var_2438.purse.pastClubDays + this.var_2438.purse.pastVipDays);
                _loc2_ = ((_loc7_ >= this.var_3196) ? "catalog.club_gift.past_club.long" : "catalog.club_gift.past_club");
                _loc3_ = (_loc7_ % this.var_3196);
                _loc4_ = int((_loc7_ / this.var_3196));
                this.var_2438.localization.registerParameter(_loc2_, "days", _loc3_.toString());
                this.var_2438.localization.registerParameter(_loc2_, "months", _loc4_.toString());
                _loc5_.text = this.var_2438.localization.getKey(_loc2_);
            };
            var _loc6_:ITextWindow = (window.findChildByName("past_vip_days") as ITextWindow);
            if (_loc6_)
            {
                _loc2_ = ((this.var_2438.purse.pastVipDays >= this.var_3196) ? "catalog.club_gift.past_vip.long" : "catalog.club_gift.past_vip");
                _loc3_ = (this.var_2438.purse.pastVipDays % this.var_3196);
                _loc4_ = int((this.var_2438.purse.pastVipDays / this.var_3196));
                this.var_2438.localization.registerParameter(_loc2_, "days", _loc3_.toString());
                this.var_2438.localization.registerParameter(_loc2_, "months", _loc4_.toString());
                _loc6_.text = this.var_2438.localization.getKey(_loc2_);
            };
        }

        private function updateList():void
        {
            var _loc1_:Offer;
            var _loc2_:Array;
            var _loc5_:IWindow;
            var _loc6_:CatalogPageMessageOfferData;
            var _loc7_:Array;
            var _loc8_:IProductData;
            var _loc9_:CatalogPageMessageProductData;
            var _loc10_:ClubGiftData;
            var _loc11_:IFurnitureData;
            var _loc12_:Product;
            if ((((!(this.var_2438)) || (!(window))) || (!(page))))
            {
                return;
            };
            for each (_loc1_ in this._offers)
            {
                _loc1_.dispose();
            };
            this._offers.reset();
            _loc2_ = this.var_2438.getOffers();
            if (!_loc2_)
            {
                return;
            };
            var _loc3_:Map = this.var_2438.getGiftData();
            if (!_loc3_)
            {
                return;
            };
            var _loc4_:IItemListWindow = (window.findChildByName("gift_list") as IItemListWindow);
            if (!_loc4_)
            {
                return;
            };
            _loc4_.destroyListItems();
            for each (_loc6_ in _loc2_)
            {
                _loc7_ = new Array();
                _loc8_ = this.var_2438.catalog.getProductData(_loc6_.localizationId);
                for each (_loc9_ in _loc6_.products)
                {
                    _loc11_ = this.var_2438.catalog.getFurnitureData(_loc9_.furniClassId, _loc9_.productType);
                    _loc12_ = new Product(_loc9_.productType, _loc9_.furniClassId, _loc9_.extraParam, _loc9_.productCount, _loc9_.expiration, _loc8_, _loc11_);
                    _loc7_.push(_loc12_);
                };
                _loc1_ = new Offer(_loc6_.offerId, _loc6_.localizationId, _loc6_.priceInCredits, _loc6_.priceInActivityPoints, _loc6_.activityPointType, _loc6_.clubLevel, _loc7_, page);
                _loc10_ = (_loc3_.getValue(_loc1_.offerId) as ClubGiftData);
                _loc5_ = this.createListItem(_loc1_, _loc10_);
                if (_loc5_)
                {
                    _loc4_.addListItem(_loc5_);
                    this._offers.add(_loc1_.offerId, _loc1_);
                };
            };
        }

        private function createListItem(param1:Offer, param2:ClubGiftData):IWindow
        {
            var _loc6_:int;
            var _loc7_:String;
            var _loc12_:int;
            var _loc13_:int;
            if (((((!(param1)) || (!(param1.productContainer))) || (!(param1.productContainer.firstProduct))) || (!(param2))))
            {
                return (null);
            };
            var _loc3_:IWindowContainer = (this.createWindow("club_gift_list_item") as IWindowContainer);
            if (!_loc3_)
            {
                return (null);
            };
            _loc3_.procedure = this.clickHandler;
            var _loc4_:IProduct = param1.productContainer.firstProduct;
            if (!_loc4_)
            {
                return (null);
            };
            var _loc5_:IProductData = _loc4_.productData;
            if (!_loc5_)
            {
                return (null);
            };
            this.setText(_loc3_.findChildByName("gift_name"), _loc5_.name);
            this.setText(_loc3_.findChildByName("gift_desc"), _loc5_.description);
            if (param2.isVip)
            {
                _loc6_ = (param2.daysRequired - this.var_2438.purse.pastVipDays);
            }
            else
            {
                _loc6_ = (param2.daysRequired - (this.var_2438.purse.pastClubDays + this.var_2438.purse.pastVipDays));
            };
            if (((!(param2.isSelectable)) && (_loc6_ > 0)))
            {
                if (param2.isVip)
                {
                    _loc7_ = "catalog.club_gift.vip_missing";
                }
                else
                {
                    _loc7_ = "catalog.club_gift.club_missing";
                };
                if (_loc6_ >= this.var_3196)
                {
                    _loc7_ = (_loc7_ + ".long");
                };
                _loc12_ = (_loc6_ % this.var_3196);
                _loc13_ = int((_loc6_ / this.var_3196));
                this.var_2438.localization.registerParameter(_loc7_, "days", _loc12_.toString());
                this.var_2438.localization.registerParameter(_loc7_, "months", _loc13_.toString());
            }
            else
            {
                if (this.var_2438.giftsAvailable > 0)
                {
                    _loc7_ = "catalog.club_gift.selectable";
                }
                else
                {
                    _loc7_ = "";
                };
            };
            this.setText(_loc3_.findChildByName("months_required"), ((_loc7_.length > 0) ? this.var_2438.localization.getKey(_loc7_) : ""));
            var _loc8_:IIconWindow = (_loc3_.findChildByName("vip_icon") as IIconWindow);
            if (_loc8_)
            {
                _loc8_.visible = param2.isVip;
            };
            var _loc9_:IButtonWindow = (_loc3_.findChildByName("select_button") as IButtonWindow);
            if (_loc9_)
            {
                if (((param2.isSelectable) && (this.var_2438.giftsAvailable > 0)))
                {
                    _loc9_.enable();
                }
                else
                {
                    _loc9_.disable();
                };
                _loc9_.id = param1.offerId;
            };
            var _loc10_:IProductContainer = param1.productContainer;
            if (!_loc10_)
            {
                return (null);
            };
            if ((((!(page)) || (!(page.viewer))) || (!(page.viewer.roomEngine))))
            {
                return (null);
            };
            var _loc11_:IWindowContainer = (_loc3_.findChildByName("image_container") as IWindowContainer);
            if (_loc11_)
            {
                _loc10_.view = _loc11_;
                _loc10_.initProductIcon(page.viewer.roomEngine);
                _loc11_.procedure = this.mouseOverHandler;
                _loc11_.id = param1.offerId;
            };
            return (_loc3_);
        }

        private function setText(param1:IWindow, param2:String):void
        {
            var _loc3_:ITextWindow = (param1 as ITextWindow);
            if (!_loc3_)
            {
                return;
            };
            _loc3_.text = param2;
        }

        private function clickHandler(param1:WindowEvent, param2:IWindow):void
        {
            if (((((!(param1)) || (!(param2))) || (!(this._offers))) || (!(this.var_2438))))
            {
                return;
            };
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            if (param2.name != "select_button")
            {
                return;
            };
            var _loc3_:Offer = (this._offers.getValue(param2.id) as Offer);
            if (!_loc3_)
            {
                return;
            };
            this.var_2438.selectGift(_loc3_);
        }

        private function mouseOverHandler(param1:WindowEvent, param2:IWindow):void
        {
            var _loc4_:Rectangle;
            if ((((!(param1)) || (!(param2))) || (!(this._offers))))
            {
                return;
            };
            if (param2.name != "image_container")
            {
                return;
            };
            var _loc3_:Offer = (this._offers.getValue(param2.id) as Offer);
            if (!_loc3_)
            {
                return;
            };
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
            {
                _loc4_ = new Rectangle();
                param2.getGlobalRectangle(_loc4_);
            };
            if (param1.type == WindowMouseEvent.var_624)
            {
                this.hidePreview();
            };
        }

        private function showPreview(param1:Offer, param2:Rectangle):void
        {
            var _loc5_:ImageResult;
            if (((!(param1)) || (!(param1.productContainer))))
            {
                return;
            };
            if ((((!(page)) || (!(page.viewer))) || (!(page.viewer.roomEngine))))
            {
                return;
            };
            var _loc3_:IProduct = param1.productContainer.firstProduct;
            if (!_loc3_)
            {
                return;
            };
            if (!this.var_3195)
            {
                this.var_3195 = (this.createWindow("club_gift_preview") as IWindowContainer);
            };
            if (!this.var_3195)
            {
                return;
            };
            var _loc4_:IBitmapWrapperWindow = (this.var_3195.findChildByName("image") as IBitmapWrapperWindow);
            if (!_loc4_)
            {
                return;
            };
            switch (_loc3_.productType)
            {
                case "s":
                    _loc5_ = page.viewer.roomEngine.getFurnitureImage(_loc3_.productClassId, new Vector3d(90), 64, null, 0, _loc3_.extraParam);
                    break;
                case "i":
                    _loc5_ = page.viewer.roomEngine.getWallItemImage(_loc3_.productClassId, new Vector3d(90), 64, null, 0, _loc3_.extraParam);
                    break;
                default:
                    return;
            };
            if (((!(_loc5_)) || (!(_loc5_.data))))
            {
                return;
            };
            _loc4_.width = _loc5_.data.width;
            _loc4_.height = _loc5_.data.height;
            if (_loc4_.bitmap)
            {
                _loc4_.bitmap.dispose();
            };
            _loc4_.bitmap = new BitmapData(_loc4_.width, _loc4_.height);
            _loc4_.bitmap.draw(_loc5_.data);
            _loc5_.data.dispose();
            var _loc6_:Point = Point.interpolate(param2.topLeft, param2.bottomRight, 0.5);
            this.var_3195.setGlobalPosition(_loc6_.subtract(new Point((this.var_3195.width / 2), (this.var_3195.height / 2))));
            this.var_3195.visible = true;
            this.var_3195.activate();
        }

        private function hidePreview():void
        {
            if (this.var_3195)
            {
                this.var_3195.visible = false;
            };
        }

        private function createWindow(param1:String):IWindow
        {
            if ((((!(this.var_2438)) || (!(this.var_2438.assets))) || (!(this.var_2438.windowManager))))
            {
                return (null);
            };
            var _loc2_:XmlAsset = (this.var_2438.assets.getAssetByName(param1) as XmlAsset);
            if (((!(_loc2_)) || (!(_loc2_.content))))
            {
                return (null);
            };
            var _loc3_:XML = (_loc2_.content as XML);
            if (!_loc3_)
            {
                return (null);
            };
            return (this.var_2438.windowManager.buildFromXML(_loc3_));
        }


    }
}