package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.club.ClubBuyController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.club.ClubBuyItem;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.purse.IPurse;
    import com.sulake.habbo.catalog.viewer.ICatalogViewer;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.catalog.viewer.CatalogPage;
    import com.sulake.habbo.catalog.club.ClubBuyOfferData;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.assets.XmlAsset;

    public class ClubBuyCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var var_2438:ClubBuyController;
        private var _offers:Array;

        public function ClubBuyCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            if (this.var_2438 != null)
            {
                this.var_2438.unRegisterVisualization(this);
            };
            this.var_2438 = null;
            this.reset();
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            this._offers = [];
            this.displayMainView();
            this.var_2438 = (page.viewer.catalog as HabboCatalog).getClubBuyController();
            this.var_2438.registerVisualization(this);
            this.var_2438.requestOffers();
            return (true);
        }

        private function displayMainView():void
        {
            var _loc1_:XML = this.getAssetXML("clubBuyWidget");
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
        }

        public function reset():void
        {
            var _loc1_:ClubBuyItem;
            for each (_loc1_ in this._offers)
            {
                _loc1_.dispose();
            };
            this._offers = [];
        }

        public function initClubType(clubType:int):void
        {
            var catalog:HabboCatalog;
            var localization:ICoreLocalizationManager;
            var purse:IPurse;
            var clubDays:int;
            var clubPeriods:int;
            var clubDaysTotal:int;
            if (disposed)
            {
                return;
            };
            var viewer:ICatalogViewer = page.viewer;
            if (viewer)
            {
                catalog = (viewer.catalog as HabboCatalog);
                if (catalog)
                {
                    localization = catalog.localization;
                    purse = catalog.getPurse();
                    if (((purse) && (localization)))
                    {
                        clubDays = purse.clubDays;
                        clubPeriods = purse.clubPeriods;
                        clubDaysTotal = ((clubPeriods * 31) + clubDays);
                        localization.registerParameter("catalog.club.buy.remaining.hc", "days", String(clubDaysTotal));
                        localization.registerParameter("catalog.club.buy.remaining.vip", "days", String(clubDaysTotal));
                    };
                };
            };
            try
            {
                if (_window)
                {
                    switch (clubType)
                    {
                        case HabboClubLevelEnum.var_255:
                            _window.findChildByName("club_header").caption = "${catalog.club.buy.header.none}";
                            _window.findChildByName("club_info").caption = "${catalog.club.buy.info.none}";
                            _window.findChildByName("club_remaining").visible = false;
                            _window.findChildByName("club_remaining_bg").visible = false;
                            break;
                        case HabboClubLevelEnum.var_256:
                            _window.findChildByName("club_header").caption = "${catalog.club.buy.header.hc}";
                            _window.findChildByName("club_info").caption = "${catalog.club.buy.info.hc}";
                            _window.findChildByName("club_remaining").caption = "${catalog.club.buy.remaining.hc}";
                            break;
                        case HabboClubLevelEnum.var_114:
                            _window.findChildByName("club_header").caption = "${catalog.club.buy.header.vip}";
                            _window.findChildByName("club_info").caption = "${catalog.club.buy.info.vip}";
                            _window.findChildByName("club_remaining").caption = "${catalog.club.buy.remaining.vip}";
                            this.showClubInfo();
                            break;
                    };
                };
            }
            catch(e:Error)
            {
                ErrorReportStorage.addDebugData("ClubBuyCatalogWidget", "initClubType - Window not properly constructed!");
            };
            this.initLinks();
        }

        private function initLinks():void
        {
            var _loc1_:IWindow;
            if (_window)
            {
                _loc1_ = _window.findChildByName("club_link");
                if (_loc1_)
                {
                    _loc1_.setParamFlag(WindowParam.var_609);
                    _loc1_.mouseThreshold = 0;
                    _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickLink);
                };
            };
        }

        public function showOffer(offer:ClubBuyOfferData):void
        {
            var target:IItemListWindow;
            var item:ClubBuyItem;
            if (disposed)
            {
                return;
            };
            Logger.log(("Offer: " + [offer.offerId, offer.productCode, offer.price, offer.upgrade, offer.vip, offer.periods, offer.daysLeftAfterPurchase, offer.year, offer.month, offer.day, offer.upgradeHcPeriodToVip]));
            offer.page = page;
            try
            {
                item = new ClubBuyItem(offer, (page as CatalogPage));
            }
            catch(e:Error)
            {
                ErrorReportStorage.addDebugData("ClubBuyCatalogWidget", (((("showOffer - new ClubBuyItem(" + String(offer)) + ", ") + String((page as CatalogPage))) + ") crashed!"));
                return;
            };
            if (offer.vip)
            {
                target = (_window.findChildByName("item_list_vip") as IItemListWindow);
            }
            else
            {
                target = (_window.findChildByName("item_list_hc") as IItemListWindow);
            };
            if (target != null)
            {
                target.addListItem(item.window);
            };
            this._offers.push(item);
        }

        private function onClickLink(param1:WindowMouseEvent):void
        {
            var _loc3_:IHabboConfigurationManager;
            var _loc4_:String;
            var _loc2_:String = IWindow(param1.target).name;
            _loc3_ = (page.viewer.catalog as HabboCatalog).configuration;
            switch (_loc2_)
            {
                case "club_link":
                    _loc4_ = _loc3_.getKey("link.format.club", "credits/habboclub");
                    this.openExternalLink(_loc4_);
                    return;
            };
        }

        private function openExternalLink(param1:String):void
        {
            var _loc2_:IHabboConfigurationManager = (page.viewer.catalog as HabboCatalog).configuration;
            if (param1 != "")
            {
                page.viewer.catalog.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.onExternalLink);
                HabboWebTools.navigateToURL(param1, "habboMain");
            };
        }

        private function onExternalLink(param1:IAlertDialog, param2:WindowEvent):void
        {
            param1.dispose();
        }

        private function showClubInfo():void
        {
            var _loc2_:XML;
            var _loc3_:IWindow;
            var _loc1_:IItemListWindow = (_window.findChildByName("item_list_hc") as IItemListWindow);
            if (_loc1_ != null)
            {
                _loc2_ = this.getAssetXML("club_buy_info_item");
                _loc3_ = page.viewer.catalog.windowManager.buildFromXML(_loc2_);
                _loc1_.addListItem(_loc3_);
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