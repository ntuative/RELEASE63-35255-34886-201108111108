package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.tracking.HabboTracking;

    public class PurchaseCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var var_3235:XML;
        private var var_3236:XML;
        private var var_3237:XML;
        private var var_3238:XML;
        private var var_3239:XML;
        private var var_3240:XML;
        private var var_3241:IWindowContainer;
        private var var_3242:IButtonWindow;
        private var var_3243:IButtonWindow;
        private var var_3244:IButtonWindow;
        private var var_3245:ITextWindow;
        private var var_3246:ITextWindow;
        private var var_3247:ITextWindow;
        private var var_3248:ITextWindow;
        private var var_3078:Offer;
        private var var_3249:String = "";
        private var var_3250:Function;
        private var var_2487:ISessionDataManager;

        public function PurchaseCatalogWidget(param1:IWindowContainer, param2:ISessionDataManager)
        {
            super(param1);
            this.var_2487 = param2;
        }

        override public function dispose():void
        {
            events.removeEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            events.removeEventListener(WidgetEvent.var_1869, this.onSetParameter);
            events.removeEventListener(WidgetEvent.CWE_PURCHASE_OVERRIDE, this.onPurchaseOverride);
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            var _loc1_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsStub") as XmlAsset);
            if (_loc1_ != null)
            {
                this.var_3235 = (_loc1_.content as XML);
            };
            var _loc2_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetPixelsStub") as XmlAsset);
            if (_loc2_ != null)
            {
                this.var_3236 = (_loc2_.content as XML);
            };
            var _loc3_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsPixelsStub") as XmlAsset);
            if (_loc3_ != null)
            {
                this.var_3237 = (_loc3_.content as XML);
            };
            var _loc4_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsOrCreditsAndPixelsStub") as XmlAsset);
            var _loc5_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetBuyClubStub") as XmlAsset);
            if (_loc5_ != null)
            {
                this.var_3238 = (_loc5_.content as XML);
            };
            var _loc6_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetBuyVipStub") as XmlAsset);
            if (_loc6_ != null)
            {
                this.var_3239 = (_loc6_.content as XML);
            };
            var _loc7_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetBuyVipStub") as XmlAsset);
            if (_loc7_ != null)
            {
                this.var_3240 = (_loc7_.content as XML);
            };
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            events.addEventListener(WidgetEvent.var_1869, this.onSetParameter);
            events.addEventListener(WidgetEvent.CWE_PURCHASE_OVERRIDE, this.onPurchaseOverride);
            events.addEventListener(WidgetEvent.CWE_INIT_PURCHASE, this.initPurchase);
            return (true);
        }

        private function onPurchaseOverride(param1:CatalogWidgetPurchaseOverrideEvent):void
        {
            this.var_3250 = param1.callback;
        }

        private function attachStub(param1:String, param2:int):void
        {
            var _loc3_:IWindowContainer;
            if (this.var_2487.hasUserRight(null, param2))
            {
                switch (param1)
                {
                    case Offer.var_745:
                        _loc3_ = (page.viewer.catalog.windowManager.buildFromXML(this.var_3235) as IWindowContainer);
                        break;
                    case Offer.var_817:
                        _loc3_ = (page.viewer.catalog.windowManager.buildFromXML(this.var_3236) as IWindowContainer);
                        break;
                    case Offer.var_818:
                        _loc3_ = (page.viewer.catalog.windowManager.buildFromXML(this.var_3237) as IWindowContainer);
                        break;
                    default:
                        Logger.log(("Unknown price-type, can't attach..." + this.var_3078.priceType));
                };
            }
            else
            {
                switch (param2)
                {
                    case HabboClubLevelEnum.var_256:
                        _loc3_ = (page.viewer.catalog.windowManager.buildFromXML(this.var_3238) as IWindowContainer);
                        break;
                    case HabboClubLevelEnum.var_114:
                        if (!this.var_2487.hasUserRight(null, HabboClubLevelEnum.var_256))
                        {
                            _loc3_ = (page.viewer.catalog.windowManager.buildFromXML(this.var_3239) as IWindowContainer);
                        }
                        else
                        {
                            _loc3_ = (page.viewer.catalog.windowManager.buildFromXML(this.var_3240) as IWindowContainer);
                        };
                        break;
                };
            };
            if (_loc3_ != null)
            {
                if (this.var_3241 != null)
                {
                    _window.removeChild(this.var_3241);
                    this.var_3241.dispose();
                };
                this.var_3241 = _loc3_;
                _window.addChild(_loc3_);
                this.var_3241.x = 0;
                this.var_3241.y = 0;
            };
            this.var_3245 = (_window.findChildByName("ctlg_price_credits") as ITextWindow);
            this.var_3246 = (_window.findChildByName("ctlg_price_pixels") as ITextWindow);
            this.var_3247 = (_window.findChildByName("ctlg_price_credits_pixels") as ITextWindow);
            this.var_3248 = (_window.findChildByName("ctlg_special_txt") as ITextWindow);
            this.var_3242 = (window.findChildByName("ctlg_buy_button") as IButtonWindow);
            this.var_3244 = (window.findChildByName("ctlg_buy_club_button") as IButtonWindow);
            if (this.var_3242 != null)
            {
                if (this.var_3250 != null)
                {
                    this.var_3242.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.var_3250);
                }
                else
                {
                    this.var_3242.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.var_3250);
                    this.var_3242.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPurchase);
                };
                this.var_3242.disable();
            };
            if (this.var_3244 != null)
            {
                this.var_3244.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBuyClub);
            };
        }

        private function onSelectProduct(param1:SelectProductEvent):void
        {
            var _loc4_:String;
            var _loc2_:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            this.var_3078 = param1.offer;
            this.attachStub(this.var_3078.priceType, this.var_3078.clubLevel);
            if (this.var_3245 != null)
            {
                _loc2_.registerParameter("catalog.purchase.price.credits", "credits", String(this.var_3078.priceInCredits));
                this.var_3245.caption = "${catalog.purchase.price.credits}";
            };
            var _loc3_:String = ((this.var_3078.activityPointType == ActivityPointTypeEnum.PIXEL) ? "pixels" : "activitypoints");
            if (this.var_3246 != null)
            {
                _loc4_ = ("catalog.purchase.price.activitypoints." + this.var_3078.activityPointType);
                _loc2_.registerParameter(_loc4_, _loc3_, this.var_3078.priceInActivityPoints.toString());
                this.var_3246.caption = _loc2_.getKey(_loc4_);
            };
            if (this.var_3247 != null)
            {
                _loc4_ = ("catalog.purchase.price.credits_and_activitypoints." + this.var_3078.activityPointType);
                _loc2_.registerParameter(_loc4_, "credits", String(this.var_3078.priceInCredits));
                _loc2_.registerParameter(_loc4_, _loc3_, String(this.var_3078.priceInActivityPoints));
                this.var_3247.caption = _loc2_.getKey(_loc4_);
            };
            var _loc5_:IWindow = _window.findChildByName("activity_points_bg");
            if (_loc5_ != null)
            {
                _loc5_.color = ((this.var_3078.activityPointType == 0) ? 6737151 : 0xCCCCCC);
            };
            if (this.var_3242 != null)
            {
                this.var_3242.enable();
            };
        }

        private function onSetParameter(param1:SetExtraPurchaseParameterEvent):void
        {
            this.var_3249 = param1.parameter;
        }

        private function onPurchase(param1:WindowMouseEvent):void
        {
            if (this.var_3078 != null)
            {
                (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this.var_3078, page.pageId, this.var_3249);
            };
        }

        private function initPurchase(param1:CatalogWidgetInitPurchaseEvent):void
        {
            if (this.var_3078 != null)
            {
                (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this.var_3078, page.pageId, this.var_3249, param1.enableBuyAsGift);
            };
        }

        private function onBuyClub(param1:WindowMouseEvent):void
        {
            (page.viewer.catalog as HabboCatalog).openCatalogPage(CatalogPageName.var_160, true);
            HabboTracking.getInstance().trackEventLog("Catalog", "click", "BUY_CLUB");
        }


    }
}