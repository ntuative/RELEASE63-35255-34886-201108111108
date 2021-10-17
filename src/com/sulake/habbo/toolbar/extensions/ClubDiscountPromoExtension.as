package com.sulake.habbo.toolbar.extensions
{
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
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.utils.Timer;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboClubExtendOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboBasicMembershipExtendOfferComposer;
    import com.sulake.habbo.toolbar.ExtensionFixedSlotsEnum;
    import com.sulake.core.window.components.ITextWindow;
    import flash.events.TimerEvent;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.core.window.components.IIconWindow;

    public class ClubDiscountPromoExtension 
    {

        private static const var_1718:String = "club_promo";
        private static const var_623:int = 13;
        private static const var_622:int = 14;
        private static const var_627:uint = 0xFFFFFF;
        private static const var_626:uint = 12247545;

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
        private var var_5102:IBitmapWrapperWindow;
        private var var_5100:Timer;
        private var var_5103:int = 0;
        private var var_5104:int;
        private var var_5105:Timer;
        private var var_5106:BitmapData;
        private var var_5107:IRegionWindow;

        public function ClubDiscountPromoExtension(param1:HabboToolbar, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IEventDispatcher, param5:IHabboConfigurationManager, param6:ICoreLocalizationManager, param7:IHabboInventory, param8:IHabboCatalog, param9:IConnection)
        {
            this._windowManager = param2;
            this._assets = param3;
            this._events = param4;
            this._config = param5;
            this._localization = param6;
            this.var_3071 = param7;
            this._catalog = param8;
            this._connection = param9;
            this._extensionView = param1.extensionView;
            if (this.var_3071)
            {
                this.var_3071.events.addEventListener(HabboInventoryHabboClubEvent.var_1717, this.onClubChanged);
            };
        }

        private function createWindow(param1:IAssetLibrary, param2:IHabboWindowManager):IWindowContainer
        {
            var _loc5_:IAsset;
            var _loc3_:IWindowContainer;
            var _loc4_:XmlAsset = (param1.getAssetByName("club_discount_promotion_xml") as XmlAsset);
            if (_loc4_)
            {
                _loc3_ = (param2.buildFromXML((_loc4_.content as XML), 1) as IWindowContainer);
                if (_loc3_)
                {
                    this.var_5102 = (_loc3_.findChildByName("flashing_animation") as IBitmapWrapperWindow);
                    if (this.var_5102)
                    {
                        _loc5_ = (this._assets.getAssetByName("extend_hilite_png") as IAsset);
                        if (_loc5_)
                        {
                            this.var_5106 = (_loc5_.content as BitmapData);
                            if (this.var_5106)
                            {
                                this.var_5102.bitmap = this.var_5106.clone();
                            };
                        };
                        this.var_5102.visible = false;
                    };
                    this.var_5107 = (_loc3_.findChildByName("text_region") as IRegionWindow);
                    if (this.var_5107)
                    {
                        this.var_5107.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onTextRegionClicked);
                        this.var_5107.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onTextRegionMouseOver);
                        this.var_5107.addEventListener(WindowMouseEvent.var_624, this.onTextRegionMouseOut);
                    };
                    this.assignState();
                };
            };
            return (_loc3_);
        }

        private function destroyWindow():void
        {
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
                this.var_5102 = null;
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
                this.animate(false);
                this.clearAnimation();
                this.destroyWindow();
                if (this.var_3071)
                {
                    this.var_3071.events.removeEventListener(HabboInventoryHabboClubEvent.var_1717, this.onClubChanged);
                    this.var_3071 = null;
                };
                this._catalog = null;
                this._localization = null;
                this._config = null;
                this._assets = null;
                this._events = null;
                this._disposed = true;
            };
        }

        private function onTextRegionClicked(param1:WindowMouseEvent):void
        {
            if (this._connection)
            {
                if (this.var_3071.clubLevel == HabboClubLevelEnum.var_114)
                {
                    this._connection.send(new EventLogMessageComposer("DiscountPromo", "discount", "client.club.extend.discount.clicked"));
                    this._connection.send(new GetHabboClubExtendOfferMessageComposer());
                };
                if (this.var_3071.clubLevel == HabboClubLevelEnum.var_256)
                {
                    this._connection.send(new EventLogMessageComposer("DiscountPromo", "discount", "client.club.extend.basic.discount.clicked"));
                    this._connection.send(new GetHabboBasicMembershipExtendOfferComposer());
                };
            };
        }

        private function assignState():void
        {
            switch (this.var_3071.clubLevel)
            {
                case HabboClubLevelEnum.var_255:
                    this.setText(this._localization.getKey("discount.bar.no.club.promo"));
                    this.setClubIcon(var_622);
                    break;
                case HabboClubLevelEnum.var_256:
                    this.setText(this._localization.getKey("discount.bar.hc.expiring", "Save 5 cr by extending your HC subscription now!"));
                    this.setClubIcon(var_623);
                    break;
                case HabboClubLevelEnum.var_114:
                    this.setText(this._localization.getKey("discount.bar.vip.expiring", "Save 5 cr by extending your VIP subscription now!"));
                    this.setClubIcon(var_622);
                    break;
            };
            this.animate(true);
        }

        private function onClubChanged(param1:HabboInventoryHabboClubEvent):void
        {
            if ((((this.var_3071.clubIsExpiring) && (!(this._view))) && (this.isExtensionEnabled())))
            {
                this._view = this.createWindow(this._assets, this._windowManager);
                this.assignState();
                this._extensionView.attachExtension(var_1718, this._view, ExtensionFixedSlotsEnum.var_1719);
            }
            else
            {
                this._extensionView.detachExtension(var_1718);
                this.destroyWindow();
            };
        }

        private function isExtensionEnabled():Boolean
        {
            if (((this.var_3071.clubLevel == HabboClubLevelEnum.var_114) && (this._config.getBoolean("club.membership.extend.vip.promotion.enabled", false))))
            {
                return (true);
            };
            if (((this.var_3071.clubLevel == HabboClubLevelEnum.var_256) && (this._config.getBoolean("club.membership.extend.basic.promotion.enabled", false))))
            {
                return (true);
            };
            return (false);
        }

        private function setText(param1:String):void
        {
            var _loc2_:ITextWindow;
            var _loc3_:ITextWindow;
            if (this._view)
            {
                _loc2_ = (this._view.findChildByName("promo_text") as ITextWindow);
                _loc3_ = (this._view.findChildByName("promo_text_shadow") as ITextWindow);
                if (_loc2_)
                {
                    _loc2_.text = param1;
                };
                if (_loc3_)
                {
                    _loc3_.text = param1;
                };
            };
        }

        private function animate(param1:Boolean):void
        {
            if (param1)
            {
                Logger.log("Animate window");
                if (this.var_5105)
                {
                    this.var_5105.stop();
                };
                this.var_5105 = new Timer(15000);
                this.var_5105.addEventListener(TimerEvent.TIMER, this.onTriggerTimer);
                this.var_5105.start();
            }
            else
            {
                if (this.var_5105)
                {
                    this.var_5105.stop();
                    this.var_5105 = null;
                };
                this.clearAnimation();
            };
        }

        private function clearAnimation():void
        {
            if (this.var_5102)
            {
                this.var_5102.visible = false;
                this.var_5102.bitmap = null;
                this._view.invalidate();
                if (this.var_5100)
                {
                    this.var_5100.stop();
                    this.var_5100 = null;
                };
            };
        }

        private function onTriggerTimer(param1:TimerEvent):void
        {
            if (this.var_5102)
            {
                if (this.var_5102.context)
                {
                    this.var_5102.visible = true;
                    this.resetAnimationVariables();
                    this.startAnimationTimer();
                };
            };
        }

        private function resetAnimationVariables():void
        {
            this.var_5102.x = 3;
            this.var_5102.y = 3;
            this.var_5102.bitmap = this.var_5106.clone();
            this.var_5102.height = (this._view.height - 6);
            this.var_5102.width = this.var_5102.bitmap.width;
            this.var_5102.invalidate();
            this.var_5104 = ((this._view.width - 7) - this.var_5102.bitmap.width);
            this.var_5103 = 0;
        }

        private function startAnimationTimer():void
        {
            this.var_5100 = new Timer(25, 26);
            this.var_5100.addEventListener(TimerEvent.TIMER, this.onAnimationTimer);
            this.var_5100.addEventListener(TimerEvent.TIMER_COMPLETE, this.onAnimationTimerComplete);
            this.var_5100.start();
        }

        private function onAnimationTimer(param1:TimerEvent):void
        {
            var _loc2_:int;
            var _loc3_:BitmapData;
            this.var_5102.x = (3 + ((this.var_5103 / 20) * this.var_5104));
            if (this.var_5102.x > this.var_5104)
            {
                _loc2_ = ((this._view.width - 4) - this.var_5102.x);
                _loc3_ = new BitmapData(_loc2_, this.var_5106.height);
                _loc3_.copyPixels(this.var_5106, new Rectangle(0, 0, _loc2_, this.var_5106.height), new Point(0, 0));
                this.var_5102.bitmap = _loc3_;
                this.var_5102.width = _loc2_;
            };
            this.var_5102.invalidate();
            this.var_5103++;
        }

        private function onAnimationTimerComplete(param1:TimerEvent):void
        {
            this.clearAnimation();
        }

        private function setClubIcon(param1:int):void
        {
            var _loc2_:IIconWindow;
            if (this._view)
            {
                _loc2_ = (this._view.findChildByName("club_icon") as IIconWindow);
                if (_loc2_)
                {
                    _loc2_.style = param1;
                    _loc2_.invalidate();
                };
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


    }
}