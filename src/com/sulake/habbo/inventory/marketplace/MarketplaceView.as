package com.sulake.habbo.inventory.marketplace
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.utils.IConfirmDialog;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class MarketplaceView implements IGetImageListener 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IFrameWindow;
        private var var_2533:MarketplaceModel;
        private var _roomEngine:IRoomEngine;
        private var _localization:IHabboLocalizationManager;
        private var _config:IHabboConfigurationManager;
        private var _disposed:Boolean = false;
        private var var_4095:int;
        private var var_4096:int;
        private var var_4097:String;

        public function MarketplaceView(param1:MarketplaceModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IRoomEngine, param5:IHabboLocalizationManager, param6:IHabboConfigurationManager)
        {
            this.var_2533 = param1;
            this._assetLibrary = param3;
            this._windowManager = param2;
            this._roomEngine = param4;
            this._localization = param5;
            this._config = param6;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this.var_2533 = null;
                this._assetLibrary = null;
                this._windowManager = null;
                this._roomEngine = null;
                this._localization = null;
                this._config = null;
                this.disposeView();
                this._disposed = true;
            };
        }

        private function disposeView():void
        {
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            };
        }

        public function showBuyTokens(param1:int, param2:int):void
        {
            if (this._localization)
            {
                this._localization.registerParameter("inventory.marketplace.buy_tokens.info", "price", param1.toString());
                this._localization.registerParameter("inventory.marketplace.buy_tokens.info", "count", param2.toString());
                this._localization.registerParameter("inventory.marketplace.buy_tokens.info", "free", (param2 - 1).toString());
                this._localization.registerParameter("inventory.marketplace.buy_tokens.buy", "price", param1.toString());
            };
            this._view = (this.createWindow("buy_marketplace_tokens_xml") as IFrameWindow);
            if (this._view == null)
            {
                return;
            };
            this._view.procedure = this.clickHandler;
            this._view.center();
        }

        public function showMakeOffer(param1:IItem):void
        {
            var _loc4_:ImageResult;
            var _loc5_:String;
            var _loc6_:String;
            if (((((!(param1)) || (!(this._localization))) || (!(this._roomEngine))) || (!(this.var_2533))))
            {
                return;
            };
            this._view = (this.createWindow("make_marketplace_offer_xml") as IFrameWindow);
            if (!this._view)
            {
                return;
            };
            var _loc2_:ITextFieldWindow = (this._view.findChildByName("price_input") as ITextFieldWindow);
            if (_loc2_ != null)
            {
                _loc2_.restrict = "0-9";
            };
            this.checkPrice();
            this._localization.registerParameter("inventory.marketplace.make_offer.expiration_info", "time", this.var_2533.expirationHours.toString());
            this._localization.registerParameter("inventory.marketplace.make_offer.min_price", "minprice", this.var_2533.offerMinPrice.toString());
            this._localization.registerParameter("inventory.marketplace.make_offer.max_price", "maxprice", this.var_2533.offerMaxPrice.toString());
            var _loc3_:uint = 4293848814;
            if ((param1 is FloorItem))
            {
                _loc4_ = this._roomEngine.getFurnitureImage(param1.type, new Vector3d(180, 0, 0), 32, this, _loc3_, String(param1.extra));
            }
            else
            {
                _loc4_ = this._roomEngine.getWallItemImage(param1.type, new Vector3d(180, 0, 0), 32, this, _loc3_, param1.stuffData);
            };
            if (!_loc4_)
            {
                return;
            };
            this.var_4095 = _loc4_.id;
            this.setFurniImage(_loc4_.data);
            if ((param1 is FloorItem))
            {
                _loc5_ = ("roomItem.name." + param1.type);
                _loc6_ = ("roomItem.desc." + param1.type);
            }
            else
            {
                _loc5_ = ("wallItem.name." + param1.type);
                _loc6_ = ("wallItem.desc." + param1.type);
            };
            if (param1.category == FurniCategory.var_615)
            {
                _loc5_ = (("poster_" + param1.stuffData) + "_name");
                _loc6_ = (("poster_" + param1.stuffData) + "_desc");
            };
            this.var_4097 = this._localization.getKey(_loc5_);
            this.setText("furni_name", ((("$" + "{") + _loc5_) + "}"));
            this.setText("furni_desc", ((("$" + "{") + _loc6_) + "}"));
            this._view.procedure = this.clickHandler;
            this._view.center();
            var _loc7_:ITextWindow = (this._view.findChildByName("average_price") as ITextWindow);
            if (_loc7_)
            {
                _loc7_.visible = false;
            };
            this.var_2533.getItemStats();
        }

        private function setFurniImage(param1:BitmapData):void
        {
            if (((param1 == null) || (this._view == null)))
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._view.findChildByName("furni_image") as IBitmapWrapperWindow);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:BitmapData = new BitmapData(_loc2_.width, _loc2_.height, true, 0);
            var _loc4_:int = ((_loc3_.width - param1.width) * 0.5);
            var _loc5_:int = ((_loc3_.height - param1.height) * 0.5);
            _loc3_.draw(param1, new Matrix(1, 0, 0, 1, _loc4_, _loc5_));
            _loc2_.bitmap = _loc3_;
        }

        private function setText(param1:String, param2:String):void
        {
            if (this._view == null)
            {
                return;
            };
            var _loc3_:ITextWindow = (this._view.findChildByName(param1) as ITextWindow);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.text = param2;
        }

        public function showNoCredits(param1:int):void
        {
            if (this._localization)
            {
                this._localization.registerParameter("inventory.marketplace.no_credits.info", "price", param1.toString());
            };
            this._view = (this.createWindow("marketplace_no_credits_xml") as IFrameWindow);
            if (this._view == null)
            {
                return;
            };
            this._view.procedure = this.clickHandler;
            this._view.center();
        }

        private function showConfirmation():void
        {
            this._localization.registerParameter("inventory.marketplace.confirm_offer.info", "furniname", this.var_4097);
            this._localization.registerParameter("inventory.marketplace.confirm_offer.info", "price", this.var_4096.toString());
            var _loc1_:String = ("$" + "{inventory.marketplace.confirm_offer.title}");
            var _loc2_:String = ("$" + "{inventory.marketplace.confirm_offer.info}");
            this._windowManager.confirm(_loc1_, _loc2_, 0, this.confirmationCallback);
        }

        private function confirmationCallback(param1:IConfirmDialog, param2:WindowEvent):void
        {
            if (((param1 == null) || (param2 == null)))
            {
                return;
            };
            param1.dispose();
            if (this.var_2533 == null)
            {
                return;
            };
            if (param2.type == WindowEvent.var_131)
            {
                this.var_2533.makeOffer(this.var_4096);
            };
            this.var_2533.releaseItem();
        }

        private function createWindow(param1:String):IWindow
        {
            if (((this._assetLibrary == null) || (this._windowManager == null)))
            {
                return (null);
            };
            var _loc2_:XmlAsset = (this._assetLibrary.getAssetByName(param1) as XmlAsset);
            if (_loc2_ == null)
            {
                return (null);
            };
            return (this._windowManager.buildFromXML((_loc2_.content as XML)));
        }

        private function clickHandler(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:ITextFieldWindow;
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "buy_tokens_button":
                        this.var_2533.buyMarketplaceTokens();
                        this.disposeView();
                        break;
                    case "cancel_buy_tokens_button":
                    case "cancel_make_offer_button":
                    case "cancel_no_credits_button":
                    case "header_button_close":
                        this.var_2533.releaseItem();
                        this.disposeView();
                        break;
                    case "make_offer_button":
                        _loc3_ = (this._view.findChildByName("price_input") as ITextFieldWindow);
                        if (_loc3_ != null)
                        {
                            this.var_4096 = parseInt(_loc3_.text);
                            this.showConfirmation();
                        };
                        this.disposeView();
                        break;
                    case "get_credits_button":
                        this.var_2533.releaseItem();
                        this.openCreditsPage();
                        this.disposeView();
                        break;
                };
            };
            if (param1.type == WindowEvent.var_606)
            {
                if (param2.name == "price_input")
                {
                    this.checkPrice();
                };
            };
        }

        private function openCreditsPage():void
        {
            var _loc1_:String;
            if (((ExternalInterface.available) && ("true" == this._config.getKey("client.credits.embed.enabled"))))
            {
                ExternalInterface.call("FlashExternalInterface.openHabblet", "credits");
            }
            else
            {
                _loc1_ = this._config.getKey("link.format.credits");
                if (_loc1_ != "")
                {
                    this._windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.closeAlert);
                    HabboWebTools.navigateToURL(_loc1_, "habboMain");
                };
            };
        }

        private function checkPrice():void
        {
            if (this._view == null)
            {
                return;
            };
            var _loc1_:ITextFieldWindow = (this._view.findChildByName("price_input") as ITextFieldWindow);
            if (_loc1_ == null)
            {
                return;
            };
            var _loc2_:int = parseInt(_loc1_.text);
            if (_loc2_ > this.var_2533.offerMaxPrice)
            {
                _loc1_.text = this.var_2533.offerMaxPrice.toString();
                _loc2_ = this.var_2533.offerMaxPrice;
            };
            var _loc3_:int = Math.max(Math.ceil(((this.var_2533.commission * 0.01) * _loc2_)), 1);
            var _loc4_:int = (_loc2_ + _loc3_);
            var _loc5_:IButtonWindow = (this._view.findChildByName("make_offer_button") as IButtonWindow);
            var _loc6_:ITextWindow = (this._view.findChildByName("final_price") as ITextWindow);
            if (((_loc5_ == null) || (_loc6_ == null)))
            {
                return;
            };
            this._localization.registerParameter("inventory.marketplace.make_offer.final_price", "commission", _loc3_.toString());
            this._localization.registerParameter("inventory.marketplace.make_offer.final_price", "finalprice", _loc4_.toString());
            if (_loc2_ < this.var_2533.offerMinPrice)
            {
                _loc6_.text = ("$" + "{inventory.marketplace.make_offer.min_price}");
                _loc5_.disable();
            }
            else
            {
                _loc6_.text = ("$" + "{inventory.marketplace.make_offer.final_price}");
                _loc5_.enable();
            };
        }

        public function showResult(param1:int):void
        {
            var _loc2_:String;
            if (param1 == 1)
            {
                _loc2_ = ("$" + "{inventory.marketplace.result.title.success}");
            }
            else
            {
                _loc2_ = ("$" + "{inventory.marketplace.result.title.failure}");
            };
            var _loc3_:* = ((("$" + "{inventory.marketplace.result.") + param1) + "}");
            this._windowManager.alert(_loc2_, _loc3_, 0, this.closeAlert);
        }

        private function closeAlert(param1:IAlertDialog, param2:WindowEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            this.var_2533.releaseItem();
            param1.dispose();
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            if (this.var_4095 == param1)
            {
                this.setFurniImage(param2);
            };
        }

        public function showAlert(param1:String, param2:String):void
        {
            this._windowManager.alert(param1, param2, 0, this.closeAlert);
        }

        public function updateAveragePrice(param1:int, param2:int):void
        {
            if ((((!(this._view)) || (!(this._localization))) || (!(this.var_2533))))
            {
                return;
            };
            var _loc3_:ITextWindow = (this._view.findChildByName("average_price") as ITextWindow);
            if (!_loc3_)
            {
                return;
            };
            var _loc4_:int = int(Math.floor((param1 / (1 + (this.var_2533.commission * 0.01)))));
            this._localization.registerParameter("inventory.marketplace.make_offer.average_price", "days", param2.toString());
            var _loc5_:String = ((param1 == 0) ? " - " : param1.toString());
            this._localization.registerParameter("inventory.marketplace.make_offer.average_price", "price", _loc5_);
            var _loc6_:String = ((_loc4_ == 0) ? " - " : _loc4_.toString());
            this._localization.registerParameter("inventory.marketplace.make_offer.average_price", "price_no_commission", _loc6_);
            _loc3_.visible = true;
        }


    }
}