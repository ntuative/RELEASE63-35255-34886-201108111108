package com.sulake.habbo.toolbar.extensions
{
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.toolbar.IExtensionView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.toolbar.ExtensionFixedSlotsEnum;

    public class VideoOfferExtension 
    {

        private static const var_1718:String = "video_offer";
        private static const var_1720:String = "supersaverAdsOnCampaignsReady";
        private static const var_1721:String = "supersaverAdsOnCampaignCompleted";
        private static const var_1722:String = "supersaverAdsOnCampaignOpen";
        private static const var_1723:String = "supersaverAdsOnCampaignClose";
        private static const var_1724:String = "supersaverAdsLoadCampaigns";
        private static const var_1727:String = "supersaverAdsCamapaignEngage";
        private static const var_627:uint = 0xFFFFFF;
        private static const var_626:uint = 12247545;
        private static const var_1726:uint = 0x666666;
        private static const var_1725:uint = 0xCCCCCC;

        private var var_4391:HabboToolbar;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _events:IEventDispatcher;
        private var _config:IHabboConfigurationManager;
        private var _localization:ICoreLocalizationManager;
        private var var_3071:IHabboInventory;
        private var _catalog:IHabboCatalog;
        private var _connection:IConnection;
        private var _extensionView:IExtensionView;
        private var _view:IWindowContainer;
        private var _disposed:Boolean = false;
        private var var_5107:IRegionWindow;
        private var var_5109:IIconWindow;
        private var var_3858:Number = -1;
        private var var_5110:Boolean = false;
        private var var_5111:int = 0;
        private var var_5112:int = 0;

        public function VideoOfferExtension(param1:HabboToolbar, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IEventDispatcher, param5:IHabboConfigurationManager, param6:ICoreLocalizationManager, param7:IHabboInventory, param8:IHabboCatalog, param9:IConnection)
        {
            this._windowManager = param2;
            this._assets = param3;
            this._events = param4;
            this._config = param5;
            this._localization = param6;
            this.var_3071 = param7;
            this._catalog = param8;
            this._connection = param9;
            this.var_4391 = param1;
            this._extensionView = param1.extensionView;
            if (this.var_3071)
            {
                this.var_3071.events.addEventListener(HabboInventoryHabboClubEvent.var_1717, this.onClubChanged);
            };
        }

        private function onClubChanged(param1:HabboInventoryHabboClubEvent):void
        {
            if ((((this.var_3071.clubIsExpiring) && (!(this._view))) && (this.isClubExtensionEnabled())))
            {
                this._extensionView.detachExtension(var_1718);
                this.destroyWindow();
                return;
            };
            if ((((ExternalInterface.available) && (!(this.var_5110))) && (!(this._view))))
            {
                ExternalInterface.addCallback(var_1720, this.onCampaignsReady);
                ExternalInterface.addCallback(var_1721, this.onCampaignComplete);
                ExternalInterface.addCallback(var_1722, this.onCampaignOpen);
                ExternalInterface.addCallback(var_1723, this.onCampaignClose);
                ExternalInterface.call(var_1724);
            };
        }

        private function isClubExtensionEnabled():Boolean
        {
            if ((((this.var_3071.clubLevel == HabboClubLevelEnum.var_114) && (this._config.getBoolean("club.membership.extend.vip.promotion.enabled", false))) || ((this.var_3071.clubLevel == HabboClubLevelEnum.var_256) && (this._config.getBoolean("club.membership.extend.basic.promotion.enabled", false)))))
            {
                return (true);
            };
            return (false);
        }

        private function onCampaignsReady(param1:String):void
        {
            this.var_5111 = parseInt(param1);
            if (isNaN(this.var_5111))
            {
                this.var_5111 = 0;
            };
            if ((((this.var_5111 <= 0) || (this.var_5110)) || ((this.var_3071.clubIsExpiring) && (this.isClubExtensionEnabled()))))
            {
                if (this._view)
                {
                    this.destroyWindow();
                };
                return;
            };
            if (!this._view)
            {
                this._view = this.createWindow(this._assets, this._windowManager);
            };
        }

        private function onCampaignOpen():void
        {
        }

        private function onCampaignClose():void
        {
            this.turnVolumeUp();
            if (this._connection)
            {
                this._connection.send(new EventLogMessageComposer("SuperSaverAds", "client_action", "supersaverads.video.promo.close"));
            };
        }

        private function onCampaignComplete():void
        {
            this.turnVolumeUp();
            if (this._connection)
            {
                this._connection.send(new EventLogMessageComposer("SuperSaverAds", "client_action", "supersaverads.video.promo.complete"));
            };
        }

        private function createWindow(param1:IAssetLibrary, param2:IHabboWindowManager):IWindowContainer
        {
            var _loc5_:String;
            var _loc6_:ITextWindow;
            var _loc7_:ITextWindow;
            var _loc8_:BitmapDataAsset;
            var _loc9_:BitmapData;
            var _loc10_:IBitmapWrapperWindow;
            var _loc3_:IWindowContainer;
            var _loc4_:XmlAsset = (param1.getAssetByName("video_offer_promotion_xml") as XmlAsset);
            if (_loc4_)
            {
                _loc3_ = (param2.buildFromXML((_loc4_.content as XML), 1) as IWindowContainer);
                if (_loc3_)
                {
                    _loc5_ = this._localization.getKey("supersaverads.video.promo.offer", "Watch a video and earn a credit!");
                    _loc6_ = (_loc3_.findChildByName("promo_text") as ITextWindow);
                    _loc7_ = (_loc3_.findChildByName("promo_text_shadow") as ITextWindow);
                    if (_loc6_)
                    {
                        _loc6_.text = _loc5_;
                    };
                    if (_loc7_)
                    {
                        _loc7_.text = _loc5_;
                    };
                    _loc8_ = (this._assets.getAssetByName("offer_icon_png") as BitmapDataAsset);
                    if (_loc8_ != null)
                    {
                        _loc9_ = (_loc8_.content as BitmapData);
                        _loc10_ = (_loc3_.findChildByName("promo_icon") as IBitmapWrapperWindow);
                        if (((!(_loc9_ == null)) && (!(_loc10_ == null))))
                        {
                            _loc10_.bitmap = new BitmapData(_loc10_.width, _loc10_.height, true, 0);
                            _loc10_.bitmap.copyPixels(_loc9_, _loc9_.rect, new Point(0, 0));
                        };
                    };
                    this.var_5107 = (_loc3_.findChildByName("text_region") as IRegionWindow);
                    if (this.var_5107)
                    {
                        this.var_5107.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onTextRegionClicked);
                        this.var_5107.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onTextRegionMouseOver);
                        this.var_5107.addEventListener(WindowMouseEvent.var_624, this.onTextRegionMouseOut);
                    };
                    this.var_5109 = (_loc3_.findChildByName("promo_close_icon") as IIconWindow);
                    if (this.var_5109)
                    {
                        this.var_5109.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCloseClicked);
                        this.var_5109.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onCloseMouseOver);
                        this.var_5109.addEventListener(WindowMouseEvent.var_624, this.onCloseMouseOut);
                    };
                    this._extensionView.attachExtension(var_1718, _loc3_, ExtensionFixedSlotsEnum.var_1719);
                };
            };
            return (_loc3_);
        }

        private function destroyWindow():void
        {
            if (this._view)
            {
                if (this.var_5107)
                {
                    this.var_5107.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onTextRegionClicked);
                    this.var_5107.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onTextRegionMouseOver);
                    this.var_5107.removeEventListener(WindowMouseEvent.var_624, this.onTextRegionMouseOut);
                    this.var_5107 = null;
                };
                if (this.var_5109)
                {
                    this.var_5109.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCloseClicked);
                    this.var_5109.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onCloseMouseOver);
                    this.var_5109.removeEventListener(WindowMouseEvent.var_624, this.onCloseMouseOut);
                    this.var_5109 = null;
                };
                this._view.dispose();
                this._view = null;
            };
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                if (this._extensionView)
                {
                    this._extensionView.detachExtension(var_1718);
                    this._extensionView = null;
                };
                this.destroyWindow();
                if (ExternalInterface.available)
                {
                    ExternalInterface.addCallback(var_1720, null);
                    ExternalInterface.addCallback(var_1721, null);
                    ExternalInterface.addCallback(var_1722, null);
                    ExternalInterface.addCallback(var_1723, null);
                };
                if (this.var_3071)
                {
                    this.var_3071.events.removeEventListener(HabboInventoryHabboClubEvent.var_1717, this.onClubChanged);
                    this.var_3071 = null;
                };
                this.var_4391 = null;
                this.var_3071 = null;
                this._catalog = null;
                this._localization = null;
                this._config = null;
                this._assets = null;
                this._events = null;
                this._disposed = true;
            };
        }

        private function onCloseClicked(param1:WindowMouseEvent):void
        {
            this.var_5110 = true;
            this.destroyWindow();
            if (this._connection)
            {
                this._connection.send(new EventLogMessageComposer("SuperSaverAds", "client_action", "supersaverads.video.promo.close_clicked"));
            };
        }

        private function onCloseMouseOver(param1:WindowMouseEvent):void
        {
            if (this.var_5109)
            {
                this.var_5109.color = var_1725;
            };
        }

        private function onCloseMouseOut(param1:WindowMouseEvent):void
        {
            if (this.var_5109)
            {
                this.var_5109.color = var_1726;
            };
        }

        private function onTextRegionClicked(param1:WindowMouseEvent):void
        {
            if (ExternalInterface.available)
            {
                this.var_5112 = (this.var_5112 + 1);
                ExternalInterface.call(var_1727);
                this.turnVolumeDown();
                if (this._connection)
                {
                    this._connection.send(new EventLogMessageComposer("SuperSaverAds", "client_action", "supersaverads.video.promo.launched"));
                };
            };
            if (this.var_5111 == this.var_5112)
            {
                this.destroyWindow();
            };
        }

        private function onTextRegionMouseOver(param1:WindowMouseEvent):void
        {
            var _loc2_:ITextWindow;
            if (this._view)
            {
                _loc2_ = (this._view.findChildByName("promo_text") as ITextWindow);
                _loc2_.textColor = var_626;
            };
        }

        private function onTextRegionMouseOut(param1:WindowMouseEvent):void
        {
            var _loc2_:ITextWindow;
            if (this._view)
            {
                _loc2_ = (this._view.findChildByName("promo_text") as ITextWindow);
                _loc2_.textColor = var_627;
            };
        }

        private function turnVolumeDown():void
        {
            if (this.var_4391.soundManager)
            {
                this.var_3858 = this.var_4391.soundManager.volume;
                this.var_4391.soundManager.volume = 0;
            };
        }

        private function turnVolumeUp():void
        {
            if (((this.var_4391.soundManager) && (!(this.var_3858 == -1))))
            {
                this.var_4391.soundManager.volume = this.var_3858;
            };
        }


    }
}