package com.sulake.habbo.inventory
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.inventory.purse.Purse;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.session.events.RoomSessionPropertyUpdateEvent;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.inventory.trading.TradingModel;
    import com.sulake.habbo.inventory.enum.InventorySubCategory;
    import com.sulake.habbo.inventory.effects.EffectsModel;
    import com.sulake.habbo.inventory.badges.BadgesModel;
    import com.sulake.habbo.inventory.recycler.RecyclerModel;
    import com.sulake.habbo.inventory.pets.PetsModel;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.purse.GetCreditsInfoComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.ScrGetUserInfoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgePointLimitsComposer;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.Event;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.iid.*;

    public class HabboInventory extends Component implements IHabboInventory 
    {

        private const var_4123:int = 500;

        private var _communication:IHabboCommunicationManager;
        private var var_4033:IncomingMessages;
        private var _windowManager:IHabboWindowManager;
        private var var_1354:ISessionDataManager;
        private var var_3318:IRoomSessionManager;
        private var _localization:IHabboLocalizationManager;
        private var _config:IHabboConfigurationManager;
        private var _soundManager:IHabboSoundManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:InventoryMainView;
        private var var_4119:Map;
        private var _roomEngine:IRoomEngine;
        private var var_3319:IRoomSession;
        private var var_4120:Array;
        private var var_3322:Purse;
        private var _avatarRenderer:IAvatarRenderManager;
        private var _catalog:IHabboCatalog;
        private var var_3317:IHabboToolbar;
        private var _isInitialized:Boolean;
        private var var_4121:Boolean;
        private var var_4122:int;

        public function HabboInventory(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this._assetLibrary = param3;
            this.var_3322 = new Purse();
            this.var_4120 = new Array();
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationComponentInit);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationManagerReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationManagerReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderManagerReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
        }

        public function get isVisible():Boolean
        {
            return (this._view.isVisible);
        }

        public function get isMainViewActive():Boolean
        {
            return (this._view.isActive);
        }

        override public function dispose():void
        {
            var _loc1_:Array;
            var _loc2_:int;
            var _loc3_:String;
            var _loc4_:IInventoryModel;
            super.dispose();
            if (this.var_4119)
            {
                _loc1_ = this.var_4119.getKeys();
                _loc2_ = 0;
                while (_loc2_ < _loc1_.length)
                {
                    _loc3_ = _loc1_[_loc2_];
                    _loc4_ = (this.var_4119.getValue(_loc3_) as IInventoryModel);
                    if (_loc4_ != null)
                    {
                        _loc4_.dispose();
                    };
                    _loc2_++;
                };
                this.var_4119.dispose();
                this.var_4119 = null;
            };
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            };
            this.var_3319 = null;
            this.var_4033 = null;
            if (this._communication != null)
            {
                release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this.var_4033 != null)
            {
                this.var_4033.dispose();
            };
            if (this._windowManager != null)
            {
                release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._localization != null)
            {
                release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._roomEngine != null)
            {
                release(new IIDRoomEngine());
                this._roomEngine = null;
            };
            if (this._config)
            {
                this._config.release(new IIDHabboConfigurationManager());
                this._config = null;
            };
            if (this.var_1354)
            {
                this.var_1354.release(new IIDSessionDataManager());
                this.var_1354 = null;
            };
            if (this._avatarRenderer)
            {
                this._avatarRenderer.release(new IIDAvatarRenderManager());
                this._avatarRenderer = null;
            };
            if (this._catalog)
            {
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this.var_3318 != null)
            {
                this.var_3318.events.removeEventListener(RoomSessionEvent.var_94, this.roomSessionEventHandler);
                this.var_3318.events.removeEventListener(RoomSessionEvent.var_98, this.roomSessionEventHandler);
                this.var_3318.events.removeEventListener(RoomSessionPropertyUpdateEvent.var_250, this.roomSessionEventHandler);
                this.var_3318.release(new IIDHabboRoomSessionManager());
                this.var_3318 = null;
            };
            if (this._soundManager != null)
            {
                this._soundManager = null;
            };
            if (this.var_3317)
            {
                this.var_3317.release(new IIDHabboToolbar());
                this.var_3317 = null;
            };
        }

        public function get communication():IHabboCommunicationManager
        {
            return (this._communication);
        }

        public function get furniModel():FurniModel
        {
            if (disposed)
            {
                return (null);
            };
            return (FurniModel(this.var_4119.getValue(InventoryCategory.var_125)));
        }

        public function get tradingModel():TradingModel
        {
            if (disposed)
            {
                return (null);
            };
            return (TradingModel(this.var_4119.getValue(InventorySubCategory.var_251)));
        }

        public function get effectsModel():EffectsModel
        {
            if (disposed)
            {
                return (null);
            };
            return (EffectsModel(this.var_4119.getValue(InventoryCategory.var_252)));
        }

        public function get badgesModel():BadgesModel
        {
            if (disposed)
            {
                return (null);
            };
            return (BadgesModel(this.var_4119.getValue(InventoryCategory.var_124)));
        }

        public function get recyclerModel():RecyclerModel
        {
            if (disposed)
            {
                return (null);
            };
            return (RecyclerModel(this.var_4119.getValue(InventorySubCategory.var_253)));
        }

        public function get petsModel():PetsModel
        {
            if (disposed)
            {
                return (null);
            };
            return (PetsModel(this.var_4119.getValue(InventoryCategory.var_126)));
        }

        public function get marketplaceModel():MarketplaceModel
        {
            if (disposed)
            {
                return (null);
            };
            return (this.var_4119.getValue(InventoryCategory.var_254) as MarketplaceModel);
        }

        public function get sessionData():ISessionDataManager
        {
            return (this.var_1354);
        }

        public function get roomSession():IRoomSession
        {
            return (this.var_3319);
        }

        public function get clubDays():int
        {
            return (this.var_3322.clubDays);
        }

        public function get clubPeriods():int
        {
            return (this.var_3322.clubPeriods);
        }

        public function get clubPastPeriods():int
        {
            return (this.var_3322.clubPastPeriods);
        }

        public function get clubHasEverBeenMember():Boolean
        {
            return (this.var_3322.clubHasEverBeenMember);
        }

        public function get clubIsExpiring():Boolean
        {
            return (this.var_3322.clubIsExpiring);
        }

        public function get clubLevel():int
        {
            if (((this.clubDays == 0) && (this.clubPeriods == 0)))
            {
                return (HabboClubLevelEnum.var_255);
            };
            if (this.var_3322.isVIP)
            {
                return (HabboClubLevelEnum.var_114);
            };
            return (HabboClubLevelEnum.var_256);
        }

        public function get hasRoomSession():Boolean
        {
            return (!(this.var_3319 == null));
        }

        public function getCategoryViewId():String
        {
            return (this._view.getCategoryViewId());
        }

        public function getSubCategoryViewId():String
        {
            return (this._view.getSubCategoryViewId());
        }

        public function setClubStatus(param1:int, param2:int, param3:Boolean, param4:Boolean, param5:Boolean):void
        {
            this.var_3322.clubPeriods = param1;
            this.var_3322.clubDays = param2;
            this.var_3322.clubHasEverBeenMember = param3;
            this.var_3322.isVIP = param4;
            this.var_3322.clubIsExpiring = param5;
            this._view.setClubStatus(this.clubPeriods, this.clubDays);
        }

        private function onCommunicationComponentInit(param1:IID=null, param2:IUnknown=null):void
        {
            this._communication = IHabboCommunicationManager(param2);
            this.var_4033 = new IncomingMessages(this);
            this._communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
            this.initInventory();
        }

        private function onWindowManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._windowManager = IHabboWindowManager(param2);
            this.initInventory();
        }

        private function onLocalizationManagerReady(param1:IID, param2:IUnknown):void
        {
            this._localization = (param2 as IHabboLocalizationManager);
            this.initInventory();
        }

        private function onRoomEngineReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._roomEngine = IRoomEngine(param2);
            this.initInventory();
        }

        private function onSessionDataManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_1354 = ISessionDataManager(param2);
            this.initInventory();
        }

        private function onConfigurationManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._config = (param2 as IHabboConfigurationManager);
            this.initInventory();
        }

        private function onCatalogReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._catalog = (param2 as IHabboCatalog);
            this.initInventory();
        }

        private function onAvatarRenderManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._avatarRenderer = (param2 as IAvatarRenderManager);
            this.initInventory();
        }

        private function onRoomSessionManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_3318 = IRoomSessionManager(param2);
            this.var_3318.events.addEventListener(RoomSessionEvent.var_94, this.roomSessionEventHandler);
            this.var_3318.events.addEventListener(RoomSessionEvent.var_98, this.roomSessionEventHandler);
            this.var_3318.events.addEventListener(RoomSessionPropertyUpdateEvent.var_250, this.roomSessionEventHandler);
            this.initInventory();
        }

        private function onSoundManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._soundManager = IHabboSoundManager(param2);
            this.initInventory();
        }

        private function onToolbarReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_3317 = IHabboToolbar(param2);
            this.initInventory();
        }

        private function onAuthenticationOK(param1:IMessageEvent):void
        {
            if (!this._isInitialized)
            {
                this.var_4121 = true;
                return;
            };
            this.requestData();
        }

        private function requestData():void
        {
            this._communication.getHabboMainConnection(null).send(new GetCreditsInfoComposer());
            this._communication.getHabboMainConnection(null).send(new ScrGetUserInfoMessageComposer("habbo_club"));
            this._communication.getHabboMainConnection(null).send(new GetBadgePointLimitsComposer());
        }

        private function roomSessionEventHandler(param1:RoomSessionEvent):void
        {
            if (!this._isInitialized)
            {
                return;
            };
            switch (param1.type)
            {
                case RoomSessionEvent.var_94:
                    this.var_3319 = param1.session;
                    if (this.petsModel != null)
                    {
                        this.petsModel.updatePetsAllowed();
                    };
                    if (this.furniModel != null)
                    {
                        this.furniModel.updateView();
                    };
                    return;
                case RoomSessionEvent.var_98:
                    this.var_3319 = null;
                    this.deselectAllEffects();
                    return;
                case RoomSessionPropertyUpdateEvent.var_250:
                    if (this.petsModel != null)
                    {
                        this.petsModel.updatePetsAllowed();
                    };
                    return;
            };
        }

        private function initInventory():void
        {
            if ((((((((((((!(this._communication)) || (!(this._windowManager))) || (!(this._localization))) || (!(this._roomEngine))) || (!(this.var_1354))) || (!(this._config))) || (!(this._catalog))) || (!(this._avatarRenderer))) || (!(this.var_3318))) || (!(this.var_3317))) || (!(this._soundManager))))
            {
                return;
            };
            this._view = new InventoryMainView(this, this._windowManager, this._assetLibrary);
            this._view.setToolbar(this.var_3317);
            this.var_4119 = new Map();
            var _loc1_:MarketplaceModel = new MarketplaceModel(this, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._localization, this._config);
            this.var_4119.add(InventoryCategory.var_254, _loc1_);
            var _loc2_:FurniModel = new FurniModel(this, _loc1_, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._catalog, this._soundManager);
            this.var_4119.add(InventoryCategory.var_125, _loc2_);
            var _loc3_:BadgesModel = new BadgesModel(this, this._windowManager, this._communication, this._assetLibrary, this.var_1354);
            this.var_4119.add(InventoryCategory.var_124, _loc3_);
            var _loc4_:EffectsModel = new EffectsModel(this, this._windowManager, this._communication, this._assetLibrary, this._localization);
            this.var_4119.add(InventoryCategory.var_252, _loc4_);
            var _loc5_:TradingModel = new TradingModel(this, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._localization, this._soundManager);
            this.var_4119.add(InventorySubCategory.var_251, _loc5_);
            var _loc6_:RecyclerModel = new RecyclerModel(this, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._localization);
            this.var_4119.add(InventorySubCategory.var_253, _loc6_);
            var _loc7_:PetsModel = new PetsModel(this, this._windowManager, this._communication, this._assetLibrary, this._localization, this._roomEngine, this._avatarRenderer, this._catalog);
            this.var_4119.add(InventoryCategory.var_126, _loc7_);
            _loc2_.petsModel = _loc7_;
            _loc7_.furniModel = _loc2_;
            this._isInitialized = true;
            if (this.var_4121)
            {
                this.requestData();
            };
        }

        public function getCategoryWindowContainer(param1:String):IWindowContainer
        {
            var _loc2_:IInventoryModel = IInventoryModel(this.var_4119.getValue(param1));
            if (_loc2_ == null)
            {
                return (null);
            };
            return (_loc2_.getWindowContainer());
        }

        public function getCategorySubWindowContainer(param1:String):IWindowContainer
        {
            var _loc2_:IInventoryModel = IInventoryModel(this.var_4119.getValue(param1));
            if (_loc2_ == null)
            {
                return (null);
            };
            return (_loc2_.getWindowContainer());
        }

        public function getActivatedAvatarEffects():Array
        {
            var _loc1_:EffectsModel = this.effectsModel;
            if (_loc1_ == null)
            {
                return (new Array());
            };
            return (_loc1_.getEffects(1));
        }

        public function getAvatarEffects():Array
        {
            var _loc1_:EffectsModel = this.effectsModel;
            if (_loc1_ == null)
            {
                return (new Array());
            };
            return (_loc1_.getEffects());
        }

        public function setEffectSelected(param1:int):void
        {
            var _loc2_:EffectsModel = this.effectsModel;
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.useEffect(param1);
            this.notifyChangedEffects();
        }

        public function setEffectDeselected(param1:int):void
        {
            var _loc2_:EffectsModel = this.effectsModel;
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.stopUsingEffect(param1, true);
            this.notifyChangedEffects();
        }

        public function deselectAllEffects():void
        {
            var _loc1_:EffectsModel = this.effectsModel;
            if (_loc1_ == null)
            {
                return;
            };
            _loc1_.stopUsingAllEffects();
            this.notifyChangedEffects();
        }

        public function closeView():void
        {
            this._view.hideInventory();
        }

        public function showView():void
        {
            this._view.showInventory();
        }

        public function toggleInventoryPage(param1:String, param2:Boolean=false):void
        {
            this._view.toggleCategoryView(param1, false, param2);
            this.inventoryViewOpened(param1);
            if (!this.isVisible)
            {
                events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED));
            };
        }

        public function toggleInventorySubPage(param1:String):void
        {
            var _loc3_:IInventoryModel;
            this._view.toggleSubCategoryView(param1, false);
            var _loc2_:int;
            while (_loc2_ < this.var_4119.length)
            {
                _loc3_ = (this.var_4119.getWithIndex(_loc2_) as IInventoryModel);
                _loc3_.subCategorySwitch(param1);
                _loc2_++;
            };
            switch (param1)
            {
                case InventorySubCategory.var_251:
                    this._view.toggleCategoryView(InventoryCategory.var_125, false);
                    return;
            };
        }

        public function updateSubView():void
        {
            this._view.updateSubCategoryView();
        }

        public function closingInventoryView():void
        {
            var _loc2_:IInventoryModel;
            var _loc1_:int;
            while (_loc1_ < this.var_4119.length)
            {
                _loc2_ = (this.var_4119.getWithIndex(_loc1_) as IInventoryModel);
                _loc2_.closingInventoryView();
                _loc1_++;
            };
            events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED));
        }

        public function inventoryViewOpened(param1:String):void
        {
            var _loc3_:IInventoryModel;
            var _loc2_:int;
            while (_loc2_ < this.var_4119.length)
            {
                _loc3_ = (this.var_4119.getWithIndex(_loc2_) as IInventoryModel);
                _loc3_.categorySwitch(param1);
                _loc2_++;
            };
        }

        public function setupTrading(param1:int, param2:String):void
        {
            var _loc3_:TradingModel = this.tradingModel;
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.requestOpenTrading(param1);
        }

        public function get tradingActive():Boolean
        {
            var _loc1_:TradingModel = this.tradingModel;
            if (_loc1_ == null)
            {
                return (false);
            };
            return (_loc1_.running);
        }

        public function setupRecycler(param1:Boolean):void
        {
            if (this.recyclerModel != null)
            {
                if (param1)
                {
                    this.recyclerModel.startRecycler();
                }
                else
                {
                    this.recyclerModel.stopRecycler();
                };
            };
        }

        public function requestSelectedFurniToRecycler():int
        {
            if (this.recyclerModel != null)
            {
                return (this.recyclerModel.lockSelectedFurni());
            };
            return (0);
        }

        public function returnInventoryFurniFromRecycler(param1:int):Boolean
        {
            if (this.recyclerModel != null)
            {
                return (this.recyclerModel.releaseFurni(param1));
            };
            return (false);
        }

        public function canUserOfferToTrade():Boolean
        {
            var _loc1_:TradingModel = this.tradingModel;
            return ((_loc1_ != null) ? _loc1_.ownUserCanTrade : false);
        }

        public function setInventoryCategoryInit(param1:String, param2:Boolean=true):void
        {
            var _loc3_:int;
            if (param2)
            {
                if (this.var_4120.indexOf(param1) == -1)
                {
                    this.var_4120.push(param1);
                };
            }
            else
            {
                _loc3_ = this.var_4120.indexOf(param1);
                if (_loc3_ >= 0)
                {
                    this.var_4120.splice(_loc3_, 1);
                };
            };
        }

        public function isInventoryCategoryInit(param1:String):Boolean
        {
            if (this.var_4120.indexOf(param1) >= 0)
            {
                return (true);
            };
            return (false);
        }

        public function checkCategoryInitilization(param1:String):Boolean
        {
            if (this.isInventoryCategoryInit(param1))
            {
                return (true);
            };
            this.requestInventoryCategoryInit(param1);
            return (false);
        }

        public function requestInventoryCategoryInit(param1:String):void
        {
            var _loc2_:IInventoryModel = (this.var_4119.getValue(param1) as IInventoryModel);
            if (_loc2_ != null)
            {
                _loc2_.requestInitialization(this.var_4123);
            };
        }

        public function notifyChangedEffects():void
        {
            events.dispatchEvent(new HabboInventoryEffectsEvent(HabboInventoryEffectsEvent.var_257));
        }

        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }

        public function getItemById(param1:String, param2:int):IItem
        {
            var _loc4_:int;
            var _loc5_:GroupItem;
            var _loc6_:IItem;
            var _loc3_:Array = this.furniModel.getCategoryContent(param1);
            if (_loc3_ != null)
            {
                _loc4_ = 0;
                while (_loc4_ < _loc3_.length)
                {
                    _loc5_ = (_loc3_[_loc4_] as GroupItem);
                    _loc6_ = _loc5_.getItem(param2);
                    if (_loc6_ != null)
                    {
                        return (_loc6_);
                    };
                    _loc4_++;
                };
            };
            return (null);
        }

        public function updateUnseenItemCounts():void
        {
            var _loc1_:int = this.furniModel.getUnseenItemCount();
            _loc1_ = (_loc1_ + this.petsModel.getUnseenItemCount());
            _loc1_ = (_loc1_ + this.badgesModel.getUnseenItemCount());
            if (_loc1_ != this.var_4122)
            {
                this.var_4122 = _loc1_;
                this._view.updateUnseenItemCounts();
                this.var_3317.setUnseenItemCount(HabboToolbarIconEnum.INVENTORY, _loc1_);
            };
        }


    }
}