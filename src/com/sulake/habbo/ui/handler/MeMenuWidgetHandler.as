package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
    import com.sulake.habbo.avatar.enum.AvatarEditorInstanceId;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
    import com.sulake.habbo.catalog.purse.PurseEvent;
    import com.sulake.habbo.avatar.IAvatarImage;
    import flash.geom.Rectangle;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import flash.geom.Point;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetToolbarClickedUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetWaveMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetEffectsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetSelectEffectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenInventoryMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenCatalogMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStopEffectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetNavigateToRoomMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarEditorMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetSelectOutfitMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetShowOwnRoomsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMeMenuMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetSettingsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStoreSettingsMessage;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetHabboClubUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPurseUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTutorialEvent;

    public class MeMenuWidgetHandler implements IRoomWidgetHandler, IAvatarImageListener 
    {

        private static const var_2253:int = 50;
        private static const var_2254:int = 3;

        private var var_1023:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var var_3071:IHabboInventory;
        private var var_3317:IHabboToolbar;
        private var _catalog:IHabboCatalog;
        private var var_5175:String;
        private var var_5176:BitmapData;
        private var var_5177:BitmapData;
        private var _widget:MeMenuWidget;

        public function MeMenuWidgetHandler()
        {
            Logger.log("[MeMenuWidgetHandler]");
        }

        public function set widget(param1:MeMenuWidget):void
        {
            this._widget = param1;
        }

        public function dispose():void
        {
            if (((this._container) && (this._container.avatarEditor)))
            {
                this._container.avatarEditor.close(AvatarEditorInstanceId.var_540);
            };
            this.var_1023 = true;
            this.container = null;
            this.var_3071 = null;
            this.var_3317 = null;
            this._catalog = null;
            this.var_5175 = null;
            this.var_5176 = null;
            this.var_5177 = null;
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_407);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            if (this._container != null)
            {
                if ((((this._container.sessionDataManager) && (!(this._container.sessionDataManager.disposed))) && (this._container.sessionDataManager.events)))
                {
                    this._container.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.var_1412, this.onFigureUpdate);
                };
                if ((((this.var_3071) && (!(this.var_3071.disposed))) && (this.var_3071.events)))
                {
                    this.var_3071.events.removeEventListener(HabboInventoryEffectsEvent.var_257, this.onAvatarEffectsChanged);
                    this.var_3071.events.removeEventListener(HabboInventoryHabboClubEvent.var_1717, this.onHabboClubSubscriptionChanged);
                };
                if ((((this.var_3317) && (!(this.var_3317.disposed))) && (this.var_3317.events)))
                {
                    this.var_3317.events.removeEventListener(HabboToolbarEvent.var_48, this.onHabboToolbarEvent);
                };
                if ((((this._container.habboHelp) && (!(this._container.habboHelp.disposed))) && (this._container.habboHelp.events)))
                {
                    this._container.habboHelp.events.removeEventListener(HabboHelpTutorialEvent.var_2156, this.onHelpTutorialEvent);
                    this._container.habboHelp.events.removeEventListener(HabboHelpTutorialEvent.var_1413, this.onHelpTutorialEvent);
                };
                if ((((this._container.catalog) && (!(this._container.catalog.disposed))) && (this._container.catalog.events)))
                {
                    this._container.catalog.events.removeEventListener(PurseEvent.var_140, this.onCreditBalance);
                };
            };
            this._container = param1;
            if (this._container == null)
            {
                return;
            };
            if (this._container.sessionDataManager != null)
            {
                this._container.sessionDataManager.events.addEventListener(HabboSessionFigureUpdatedEvent.var_1412, this.onFigureUpdate);
            };
            this.var_3071 = this._container.inventory;
            if (this.var_3071 != null)
            {
                this.var_3071.events.addEventListener(HabboInventoryEffectsEvent.var_257, this.onAvatarEffectsChanged);
                this.var_3071.events.addEventListener(HabboInventoryHabboClubEvent.var_1717, this.onHabboClubSubscriptionChanged);
            };
            this.var_3317 = this._container.toolbar;
            if (((this.var_3317) && (this.var_3317.events)))
            {
                this.var_3317.events.addEventListener(HabboToolbarEvent.var_48, this.onHabboToolbarEvent);
                this.setMeMenuToolbarIcon();
            };
            if (this._container.habboHelp != null)
            {
                this._container.habboHelp.events.addEventListener(HabboHelpTutorialEvent.var_2156, this.onHelpTutorialEvent);
                this._container.habboHelp.events.addEventListener(HabboHelpTutorialEvent.var_1413, this.onHelpTutorialEvent);
            };
            this._catalog = this._container.catalog;
            if (this._container.catalog != null)
            {
                this._container.catalog.events.addEventListener(PurseEvent.var_140, this.onCreditBalance);
            };
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (this._container);
        }

        private function setMeMenuToolbarIcon():void
        {
            var _loc1_:BitmapData;
            var _loc2_:BitmapData;
            var _loc3_:String;
            var _loc4_:String;
            var _loc5_:IAvatarImage;
            var _loc6_:BitmapData;
            var _loc7_:BitmapData;
            var _loc8_:Rectangle;
            if (this._container.avatarRenderManager != null)
            {
                _loc3_ = this._container.sessionDataManager.figure;
                if (_loc3_ != this.var_5175)
                {
                    _loc4_ = this._container.sessionDataManager.gender;
                    _loc5_ = this._container.avatarRenderManager.createAvatarImage(_loc3_, AvatarScaleType.var_128, _loc4_, this);
                    if (_loc5_ != null)
                    {
                        _loc5_.setDirection(AvatarSetType.var_129, 2);
                        _loc1_ = _loc5_.getCroppedImage(AvatarSetType.var_129);
                        _loc2_ = _loc5_.getCroppedImage(AvatarSetType.var_130);
                        _loc5_.dispose();
                    };
                    this.var_5175 = _loc3_;
                    this.var_5176 = _loc1_;
                    this.var_5177 = _loc2_;
                }
                else
                {
                    _loc1_ = this.var_5176;
                    _loc2_ = this.var_5177;
                };
            };
            if (this.var_3317 != null)
            {
                if (((!(_loc1_ == null)) && (!(_loc2_ == null))))
                {
                    if (_loc1_.height > var_2253)
                    {
                        _loc7_ = new BitmapData(_loc1_.width, var_2253, true, 0);
                        _loc8_ = _loc7_.rect.clone();
                        if (_loc2_.height > (var_2253 - var_2254))
                        {
                            _loc8_.offset(0, ((_loc2_.height - var_2253) + var_2254));
                        };
                        _loc7_.copyPixels(_loc1_, _loc8_, new Point(0, 0));
                        _loc6_ = _loc7_;
                    }
                    else
                    {
                        _loc6_ = _loc1_;
                    };
                };
                this.var_3317.setIconBitmap(HabboToolbarIconEnum.MEMENU, _loc6_);
            };
        }

        private function onHabboToolbarEvent(param1:HabboToolbarEvent):void
        {
            if ((((this.disposed) || (!(this._container))) || (!(this._container.events))))
            {
                return;
            };
            if (param1.type == HabboToolbarEvent.var_48)
            {
                switch (param1.iconId)
                {
                    case HabboToolbarIconEnum.MEMENU:
                        this._container.events.dispatchEvent(new RoomWidgetToolbarClickedUpdateEvent(RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ME_MENU));
                        return;
                };
            };
        }

        public function getWidgetMessages():Array
        {
            var _loc1_:Array = [];
            _loc1_.push(RoomWidgetWaveMessage.var_2255);
            _loc1_.push(RoomWidgetDanceMessage.var_2256);
            _loc1_.push(RoomWidgetGetEffectsMessage.var_2257);
            _loc1_.push(RoomWidgetSelectEffectMessage.var_2258);
            _loc1_.push(RoomWidgetSelectEffectMessage.var_2259);
            _loc1_.push(RoomWidgetSelectEffectMessage.var_2260);
            _loc1_.push(RoomWidgetOpenInventoryMessage.var_2261);
            _loc1_.push(RoomWidgetOpenCatalogMessage.var_2262);
            _loc1_.push(RoomWidgetStopEffectMessage.var_2263);
            _loc1_.push(RoomWidgetNavigateToRoomMessage.var_2264);
            _loc1_.push(RoomWidgetNavigateToRoomMessage.var_2265);
            _loc1_.push(RoomWidgetAvatarEditorMessage.var_2266);
            _loc1_.push(RoomWidgetAvatarEditorMessage.var_2267);
            _loc1_.push(RoomWidgetSelectOutfitMessage.var_2268);
            _loc1_.push(RoomWidgetShowOwnRoomsMessage.var_2269);
            _loc1_.push(RoomWidgetRequestWidgetMessage.var_1700);
            _loc1_.push(RoomWidgetMeMenuMessage.var_1701);
            _loc1_.push(RoomWidgetGetSettingsMessage.var_2270);
            _loc1_.push(RoomWidgetStoreSettingsMessage.var_2271);
            _loc1_.push(RoomWidgetStoreSettingsMessage.var_2272);
            _loc1_.push(RoomWidgetStoreSettingsMessage.var_2273);
            _loc1_.push(RoomWidgetAvatarEditorMessage.var_2274);
            _loc1_.push(RoomWidgetRequestWidgetMessage.var_2275);
            return (_loc1_);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetOpenCatalogMessage;
            var _loc3_:RoomWidgetOpenInventoryMessage;
            var _loc4_:RoomWidgetMeMenuMessage;
            var _loc5_:HabboToolbarEvent;
            var _loc6_:RoomWidgetDanceMessage;
            var _loc7_:Array;
            var _loc8_:RoomWidgetSelectEffectMessage;
            var _loc9_:RoomWidgetSelectEffectMessage;
            var _loc10_:Boolean;
            var _loc11_:int;
            var _loc12_:IUserData;
            var _loc13_:int;
            var _loc14_:int;
            if (!param1)
            {
                return (null);
            };
            switch (param1.type)
            {
                case RoomWidgetRequestWidgetMessage.var_1700:
                    if ((((!(this._container == null)) && (!(this._container.toolbar == null))) && (!(this._container.toolbar.events == null))))
                    {
                        _loc5_ = new HabboToolbarEvent(HabboToolbarEvent.var_48);
                        _loc5_.iconId = HabboToolbarIconEnum.MEMENU;
                        if (((((!(this.disposed)) && (this._container)) && (this._container.toolbar)) && (this._container.toolbar.events)))
                        {
                            this._container.toolbar.events.dispatchEvent(_loc5_);
                        };
                    };
                    break;
                case RoomWidgetWaveMessage.var_2255:
                    if (((!(this._container == null)) && (!(this._container.roomSession == null))))
                    {
                        this._container.roomSession.sendWaveMessage();
                    };
                    break;
                case RoomWidgetDanceMessage.var_2256:
                    if (((!(this._container == null)) && (!(this._container.roomSession == null))))
                    {
                        _loc6_ = (param1 as RoomWidgetDanceMessage);
                        if (_loc6_ != null)
                        {
                            this._container.roomSession.sendDanceMessage(_loc6_.style);
                        };
                    };
                    break;
                case RoomWidgetGetEffectsMessage.var_2257:
                    if (this.var_3071 != null)
                    {
                        _loc7_ = this.var_3071.getAvatarEffects();
                        this._container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc7_));
                    };
                    break;
                case RoomWidgetSelectEffectMessage.var_2258:
                    if (this.var_3071 != null)
                    {
                        _loc8_ = (param1 as RoomWidgetSelectEffectMessage);
                        this.var_3071.setEffectSelected(_loc8_.effectType);
                    };
                    break;
                case RoomWidgetSelectEffectMessage.var_2259:
                    if (this.var_3071 != null)
                    {
                        _loc9_ = (param1 as RoomWidgetSelectEffectMessage);
                        this.var_3071.setEffectDeselected(_loc9_.effectType);
                    };
                    break;
                case RoomWidgetOpenCatalogMessage.var_2262:
                    _loc2_ = (param1 as RoomWidgetOpenCatalogMessage);
                    if (((!(this._catalog == null)) && (_loc2_.pageKey == RoomWidgetOpenCatalogMessage.var_2276)))
                    {
                        this._catalog.openCatalogPage(CatalogPageName.var_160, true);
                    };
                    break;
                case RoomWidgetOpenInventoryMessage.var_2261:
                    _loc3_ = (param1 as RoomWidgetOpenInventoryMessage);
                    if (this.var_3071 != null)
                    {
                        Logger.log(("MeMenuWidgetHandler open inventory: " + _loc3_.inventoryType));
                        switch (_loc3_.inventoryType)
                        {
                            case RoomWidgetOpenInventoryMessage.var_2277:
                                this._catalog.openCatalogPage(CatalogPageName.var_737, true);
                                break;
                            case RoomWidgetOpenInventoryMessage.var_2278:
                                this.var_3071.toggleInventoryPage(InventoryCategory.var_124);
                                break;
                            case RoomWidgetOpenInventoryMessage.var_2279:
                                this.var_3071.toggleInventoryPage(InventoryCategory.var_125);
                                break;
                            case RoomWidgetOpenInventoryMessage.var_2280:
                                break;
                            default:
                                Logger.log(("MeMenuWidgetHandler: unknown inventory type: " + _loc3_.inventoryType));
                        };
                    };
                    break;
                case RoomWidgetSelectEffectMessage.var_2260:
                case RoomWidgetStopEffectMessage.var_2263:
                    Logger.log("STOP ALL EFFECTS");
                    if (this.var_3071 != null)
                    {
                        this.var_3071.deselectAllEffects();
                    };
                    break;
                case RoomWidgetNavigateToRoomMessage.var_2265:
                    Logger.log("MeMenuWidgetHandler: GO HOME");
                    if (this._container != null)
                    {
                        this._container.navigator.goToHomeRoom();
                    };
                    break;
                case RoomWidgetShowOwnRoomsMessage.var_2269:
                    if (this._container != null)
                    {
                        this._container.navigator.showOwnRooms();
                    };
                    break;
                case RoomWidgetMeMenuMessage.var_1701:
                    _loc4_ = (param1 as RoomWidgetMeMenuMessage);
                    if ((((!(_loc4_)) || (!(this._container))) || (!(this._container.events))))
                    {
                        return (null);
                    };
                    if (this.var_3071 != null)
                    {
                        _loc10_ = false;
                        if (((!(this._container == null)) && (!(this._container.sessionDataManager == null))))
                        {
                            _loc10_ = this._container.sessionDataManager.hasUserRight("fuse_use_club_dance", HabboClubLevelEnum.var_256);
                        };
                        this._container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(this.var_3071.clubDays, this.var_3071.clubPeriods, this.var_3071.clubPastPeriods, _loc10_, this.var_3071.clubLevel));
                    };
                    if (((!(this._catalog == null)) && (!(this._catalog.getPurse() == null))))
                    {
                        this._container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.var_140, this._catalog.getPurse().credits));
                    };
                    if ((((this._container.roomSession) && (this._container.roomSession.userDataManager)) && (this._container.roomEngine)))
                    {
                        _loc11_ = ((this._container.sessionDataManager != null) ? this._container.sessionDataManager.userId : -1);
                        _loc12_ = this._container.roomSession.userDataManager.getUserData(_loc11_);
                        if (!_loc12_)
                        {
                            return (null);
                        };
                        _loc13_ = 0;
                        _loc14_ = 0;
                        this._container.roomEngine.selectAvatar(_loc13_, _loc14_, _loc12_.id);
                    };
                    break;
                case RoomWidgetAvatarEditorMessage.var_2266:
                    Logger.log("MeMenuWidgetHandler: Open avatar editor...");
                    if (this._container)
                    {
                        this._container.avatarEditor.openEditor(AvatarEditorInstanceId.var_540, null, null, true);
                        this._container.avatarEditor.loadOwnAvatarInEditor(AvatarEditorInstanceId.var_540);
                        if (((this._container.habboHelp) && (this._container.habboHelp.events)))
                        {
                            this._container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.var_1410));
                        };
                    };
                    break;
                case RoomWidgetGetSettingsMessage.var_2270:
                    this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.var_1698, this._container.soundManager.volume));
                    break;
                case RoomWidgetStoreSettingsMessage.var_2272:
                    this._container.soundManager.volume = (param1 as RoomWidgetStoreSettingsMessage).volume;
                    this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.var_1698, this._container.soundManager.volume));
                    break;
                case RoomWidgetStoreSettingsMessage.var_2273:
                    this._container.soundManager.previewVolume = (param1 as RoomWidgetStoreSettingsMessage).volume;
                    this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.var_1698, this._container.soundManager.volume));
                    break;
                case RoomWidgetAvatarEditorMessage.var_2274:
                    if (((this._container.habboHelp) && (this._container.habboHelp.events)))
                    {
                        this._container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.var_1411));
                    };
                    break;
                default:
                    Logger.log(("Unhandled message in MeMenuWidgetHandler: " + param1.type));
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function processEvent(param1:Event):void
        {
        }

        public function update():void
        {
        }

        private function onAvatarEffectsChanged(param1:Event=null):void
        {
            var _loc2_:Array;
            if (this._container == null)
            {
                return;
            };
            Logger.log("[MeMenuWidgetHandler] Received Avatar Effects Have Changed Event...\t");
            if (this.var_3071 != null)
            {
                _loc2_ = this.var_3071.getAvatarEffects();
                this._container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc2_));
            };
        }

        private function onHabboClubSubscriptionChanged(param1:Event=null):void
        {
            var _loc2_:Boolean;
            if (this.var_3071 != null)
            {
                _loc2_ = false;
                if (((!(this._container == null)) && (!(this._container.sessionDataManager == null))))
                {
                    _loc2_ = this._container.sessionDataManager.hasUserRight("fuse_use_club_dance", HabboClubLevelEnum.var_256);
                };
                this._container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(this.var_3071.clubDays, this.var_3071.clubPeriods, this.var_3071.clubPastPeriods, _loc2_, this.var_3071.clubLevel));
            };
        }

        private function onFigureUpdate(param1:HabboSessionFigureUpdatedEvent):void
        {
            if (this._container == null)
            {
                return;
            };
            if (param1 == null)
            {
                return;
            };
            var _loc2_:* = (param1.userId == this._container.sessionDataManager.userId);
            if (_loc2_)
            {
                this.setMeMenuToolbarIcon();
            };
            if (((!(this._container == null)) && (!(this._container.events == null))))
            {
            };
        }

        private function onCreditBalance(param1:PurseEvent):void
        {
            if ((((param1 == null) || (this._container == null)) || (this._container.events == null)))
            {
                return;
            };
            this._container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.var_140, param1.balance));
        }

        private function onHelpTutorialEvent(param1:HabboHelpTutorialEvent):void
        {
            if (this._container == null)
            {
                return;
            };
            switch (param1.type)
            {
                case HabboHelpTutorialEvent.var_1413:
                    this._container.events.dispatchEvent(new RoomWidgetTutorialEvent(RoomWidgetTutorialEvent.var_1413));
                    return;
                case HabboHelpTutorialEvent.var_2156:
                    this._container.events.dispatchEvent(new RoomWidgetTutorialEvent(RoomWidgetTutorialEvent.var_1699));
                    return;
            };
        }

        public function avatarImageReady(param1:String):void
        {
            this.var_5175 = "";
            this.setMeMenuToolbarIcon();
        }


    }
}