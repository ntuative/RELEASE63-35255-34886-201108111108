package com.sulake.habbo.ui
{
    import com.sulake.core.runtime.ComponentContext;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.moderation.IHabboModeration;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
    import com.sulake.habbo.ui.widget.RoomWidgetFactory;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboAvatarEditor;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboAdManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboModeration;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboUserDefinedRoomEvents;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.advertisement.events.InterstitialEvent;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;
    import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.session.events.RoomSessionPresentEvent;
    import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
    import com.sulake.habbo.session.events.RoomSessionViralFurniStatusEvent;
    import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
    import com.sulake.habbo.session.events.RoomSessionQueueEvent;
    import com.sulake.habbo.session.events.RoomSessionVoteEvent;
    import com.sulake.habbo.session.events.RoomSessionPollEvent;
    import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
    import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
    import com.sulake.habbo.session.events.RoomSessionUserNotificationEvent;
    import com.sulake.habbo.session.events.RoomSessionUserDataUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDanceEvent;
    import com.sulake.habbo.toolbar.HabboToolbarEnum;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
    import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.core.assets.XmlAsset;

    public class RoomUI extends ComponentContext implements IRoomUI, IUpdateReceiver 
    {

        private var _windowManager:IHabboWindowManager;
        private var _roomEngine:IRoomEngine;
        private var var_3318:IRoomSessionManager;
        private var var_5470:IRoomWidgetFactory;
        private var var_1354:ISessionDataManager;
        private var _friendList:IHabboFriendList;
        private var var_2860:IAvatarRenderManager;
        private var var_3071:IHabboInventory;
        private var var_3317:IHabboToolbar;
        private var _navigator:IHabboNavigator;
        private var var_2937:IHabboAvatarEditor = null;
        private var _catalog:IHabboCatalog;
        private var var_4906:IAdManager;
        private var _localization:IHabboLocalizationManager;
        private var var_4439:IHabboHelp;
        private var var_5471:IHabboModeration;
        private var _config:IHabboConfigurationManager;
        private var _soundManager:IHabboSoundManager;
        private var var_5485:Map;
        private var var_5486:int = RoomDesktop.var_337;
        private var var_5487:Boolean;
        private var _interstitialRoomId:int;
        private var var_5488:int;
        private var _connection:IConnection;
        private var _habboTracking:IHabboTracking;
        private var var_5472:IHabboUserDefinedRoomEvents;

        public function RoomUI(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            var _loc4_:RoomWidgetFactory = new RoomWidgetFactory(this, 0, param3);
            this.var_5470 = _loc4_;
            attachComponent(_loc4_, []);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            queueInterface(new IIDHabboFriendList(), this.onFriendListReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderManagerReady);
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            queueInterface(new IIDHabboNavigator(), this.onNavigatorReady);
            queueInterface(new IIDHabboAvatarEditor(), this.onAvatarEditorReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboAdManager(), this.onAdManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationManagerReady);
            queueInterface(new IIDHabboHelp(), this.onHabboHelpReady);
            queueInterface(new IIDHabboModeration(), this.onHabboModerationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationManagerReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDHabboUserDefinedRoomEvents(), this.onUserDefinedRoomEventsReady);
            queueInterface(new IIDHabboTracking(), this.onHabboTrackingReady);
            this.var_5485 = new Map();
            registerUpdateReceiver(this, 0);
        }

        override public function dispose():void
        {
            var _loc1_:String;
            var _loc2_:RoomDesktop;
            if (this._windowManager != null)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._roomEngine != null)
            {
                this._roomEngine.release(new IIDRoomEngine());
                this._roomEngine = null;
            };
            if (this.var_3318 != null)
            {
                this.var_3318.release(new IIDHabboRoomSessionManager());
                this.var_3318 = null;
            };
            if (this.var_5470 != null)
            {
                this.var_5470.dispose();
                this.var_5470 = null;
            };
            if (this.var_3071 != null)
            {
                this.var_3071.release(new IIDHabboInventory());
                this.var_3071 = null;
            };
            if (this.var_3317 != null)
            {
                this.var_3317.release(new IIDHabboToolbar());
                this.var_3317 = null;
            };
            if (this._config != null)
            {
                this._config.release(new IIDHabboConfigurationManager());
                this._config = null;
            };
            if (this._soundManager != null)
            {
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            };
            if (this.var_4906 != null)
            {
                this.var_4906.release(new IIDHabboAdManager());
                this.var_4906 = null;
            };
            if (this.var_2860 != null)
            {
                this.var_2860.release(new IIDAvatarRenderManager());
                this.var_2860 = null;
            };
            if (this._catalog != null)
            {
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this._friendList != null)
            {
                this._friendList.release(new IIDHabboFriendList());
                this._friendList = null;
            };
            if (this.var_4439 != null)
            {
                this.var_4439.release(new IIDHabboHelp());
                this.var_4439 = null;
            };
            if (this._localization != null)
            {
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this.var_5471 != null)
            {
                this.var_5471.release(new IIDHabboModeration());
                this.var_5471 = null;
            };
            if (this._navigator != null)
            {
                this._navigator.release(new IIDHabboNavigator());
                this._navigator = null;
            };
            if (this.var_1354 != null)
            {
                this.var_1354.release(new IIDSessionDataManager());
                this.var_1354 = null;
            };
            if (this._habboTracking != null)
            {
                this._habboTracking.release(new IIDHabboTracking());
                this._habboTracking = null;
            };
            if (this.var_5472)
            {
                this.var_5472.release(new IIDHabboUserDefinedRoomEvents());
                this.var_5472 = null;
            };
            this.var_2937 = null;
            this._connection = null;
            if (this.var_5485)
            {
                while (this.var_5485.length > 0)
                {
                    _loc1_ = (this.var_5485.getKey(0) as String);
                    _loc2_ = (this.var_5485.remove(_loc1_) as RoomDesktop);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                };
                this.var_5485.dispose();
                this.var_5485 = null;
            };
            removeUpdateReceiver(this);
            super.dispose();
        }

        private function onWindowManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._windowManager = (param2 as IHabboWindowManager);
        }

        private function onRoomSessionManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_3318 = (param2 as IRoomSessionManager);
            this.registerSessionEvents();
            if ((((!(this.var_3318 == null)) && (!(this._roomEngine == null))) && (this._roomEngine.isInitialized)))
            {
                this.var_3318.roomEngineReady = true;
            };
        }

        private function onSessionDataManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_1354 = (param2 as ISessionDataManager);
        }

        private function onFriendListReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._friendList = (param2 as IHabboFriendList);
        }

        private function onAvatarRenderManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_2860 = (param2 as IAvatarRenderManager);
        }

        private function onInventoryReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_3071 = (param2 as IHabboInventory);
        }

        private function onToolbarReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_3317 = (param2 as IHabboToolbar);
        }

        private function onNavigatorReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._navigator = (param2 as IHabboNavigator);
        }

        private function onAvatarEditorReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_2937 = (param2 as IHabboAvatarEditor);
        }

        private function onCatalogReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._catalog = (param2 as IHabboCatalog);
        }

        private function onAdManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_4906 = (param2 as IAdManager);
            if (((!(this.var_4906 == null)) && (!(this.var_4906.events == null))))
            {
                this.var_4906.events.addEventListener(InterstitialEvent.var_338, this.interstitialCompleteEventHandler);
                this.var_4906.events.addEventListener(InterstitialEvent.var_339, this.adEventHandler);
                this.var_4906.events.addEventListener(AdEvent.var_69, this.adEventHandler);
            };
        }

        private function onLocalizationManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._localization = (param2 as IHabboLocalizationManager);
        }

        private function onHabboHelpReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_4439 = (param2 as IHabboHelp);
        }

        private function onHabboModerationReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_5471 = (param2 as IHabboModeration);
            Logger.log(("XXXX GOT HABBO MODERATION: " + this.var_5471));
        }

        private function onConfigurationManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._config = (param2 as IHabboConfigurationManager);
        }

        private function onSoundManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._soundManager = (param2 as IHabboSoundManager);
        }

        private function registerSessionEvents():void
        {
            if (this.var_3318)
            {
                this.var_3318.events.addEventListener(RoomSessionEvent.var_93, this.roomSessionStateEventHandler);
                this.var_3318.events.addEventListener(RoomSessionEvent.var_94, this.roomSessionStateEventHandler);
                this.var_3318.events.addEventListener(RoomSessionEvent.var_98, this.roomSessionStateEventHandler);
                this.var_3318.events.addEventListener(RoomSessionChatEvent.var_340, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionChatEvent.var_341, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionUserBadgesEvent.var_342, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionDoorbellEvent.var_343, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionDoorbellEvent.var_344, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionDoorbellEvent.var_345, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionPresentEvent.var_346, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionPetPackageEvent.var_347, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionPetPackageEvent.var_348, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionViralFurniStatusEvent.var_349, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionViralFurniStatusEvent.var_350, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_351, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_352, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_353, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_354, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_355, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_356, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_357, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_358, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_359, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_360, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_361, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_362, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_363, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_364, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_365, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_366, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionErrorMessageEvent.var_367, this.roomSessionDialogEventHandler);
                this.var_3318.events.addEventListener(RoomSessionQueueEvent.var_368, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionVoteEvent.var_369, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionVoteEvent.var_370, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionPollEvent.var_371, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionPollEvent.var_60, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionPollEvent.var_372, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionDimmerPresetsEvent.var_373, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionFriendRequestEvent.var_374, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionUserNotificationEvent.var_375, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionUserDataUpdateEvent.var_376, this.roomSessionEventHandler);
                this.var_3318.events.addEventListener(RoomSessionDanceEvent.var_377, this.roomSessionEventHandler);
            };
        }

        private function roomSessionStateEventHandler(param1:RoomSessionEvent):void
        {
            if (this._roomEngine == null)
            {
                return;
            };
            switch (param1.type)
            {
                case RoomSessionEvent.var_93:
                    this.createDesktop(param1.session);
                    return;
                case RoomSessionEvent.var_94:
                    this.var_3317.setToolbarState(HabboToolbarEnum.var_378);
                    return;
                case RoomSessionEvent.var_98:
                    if (param1.session != null)
                    {
                        this.disposeDesktop(this.getRoomIdentifier(param1.session.roomId, param1.session.roomCategory));
                        this.var_3317.setToolbarState(HabboToolbarEnum.var_379);
                    };
                    return;
            };
        }

        private function roomSessionEventHandler(param1:RoomSessionEvent):void
        {
            var _loc2_:String;
            var _loc3_:IRoomDesktop;
            if (this._roomEngine == null)
            {
                return;
            };
            if (param1.session != null)
            {
                _loc2_ = this.getRoomIdentifier(param1.session.roomId, param1.session.roomCategory);
                _loc3_ = this.getDesktop(_loc2_);
                if (_loc3_ != null)
                {
                    _loc3_.processEvent(param1);
                };
            };
        }

        private function roomSessionDialogEventHandler(event:RoomSessionEvent):void
        {
            var errorMessage:String;
            var errorTitle:String = "${error.title}";
            switch (event.type)
            {
                case RoomSessionErrorMessageEvent.var_351:
                    errorMessage = "${room.error.cant_trade_stuff}";
                    break;
                case RoomSessionErrorMessageEvent.var_352:
                    errorMessage = "${room.error.cant_set_item}";
                    break;
                case RoomSessionErrorMessageEvent.var_353:
                    errorMessage = "${room.error.cant_set_not_owner}";
                    break;
                case RoomSessionErrorMessageEvent.var_356:
                    errorMessage = "${room.error.max_furniture}";
                    break;
                case RoomSessionErrorMessageEvent.var_365:
                    errorMessage = "${room.error.max_pets}";
                    break;
                case RoomSessionErrorMessageEvent.var_357:
                    errorMessage = "${room.error.max_queuetiles}";
                    break;
                case RoomSessionErrorMessageEvent.var_358:
                    errorMessage = "${room.error.max_soundfurni}";
                    break;
                case RoomSessionErrorMessageEvent.var_359:
                    errorMessage = "${room.error.max_stickies}";
                    break;
                case RoomSessionErrorMessageEvent.var_360:
                    errorMessage = "${room.error.kicked}";
                    errorTitle = "${generic.alert.title}";
                    break;
                case RoomSessionErrorMessageEvent.var_362:
                    errorMessage = "${room.error.guide.not.available}";
                    break;
                case RoomSessionErrorMessageEvent.var_361:
                    errorMessage = "${room.error.guide.already.exists}";
                    break;
                case RoomSessionErrorMessageEvent.var_363:
                    errorMessage = "${room.error.pets.forbidden_in_hotel}";
                    break;
                case RoomSessionErrorMessageEvent.var_364:
                    errorMessage = "${room.error.pets.forbidden_in_flat}";
                    break;
                case RoomSessionErrorMessageEvent.var_366:
                    errorMessage = "${room.error.pets.no_free_tiles}";
                    break;
                case RoomSessionErrorMessageEvent.var_367:
                    errorMessage = "${room.error.pets.selected_tile_not_free}";
                    break;
                default:
                    return;
            };
            this._windowManager.alert(errorTitle, errorMessage, 0, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            });
        }

        private function interstitialCompleteEventHandler(param1:InterstitialEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:String = this.getRoomIdentifier(this._interstitialRoomId, this.var_5488);
            var _loc3_:RoomDesktop = (this.getDesktop(_loc2_) as RoomDesktop);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.processEvent(param1);
            this.var_5487 = false;
        }

        private function adEventHandler(param1:AdEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:String = this.getRoomIdentifier(param1.roomId, param1.roomCategory);
            var _loc3_:RoomDesktop = (this.getDesktop(_loc2_) as RoomDesktop);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.processEvent(param1);
        }

        private function onRoomEngineReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._roomEngine = (param2 as IRoomEngine);
            this.initializeRoomEngineEvents();
            if ((((!(this.var_3318 == null)) && (!(this._roomEngine == null))) && (this._roomEngine.isInitialized)))
            {
                this.var_3318.roomEngineReady = true;
            };
        }

        private function onCommunicationReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            var _loc3_:IHabboCommunicationManager = (param2 as IHabboCommunicationManager);
            if (_loc3_ != null)
            {
                this._connection = _loc3_.getHabboMainConnection(this.onConnectionReady);
                if (this._connection != null)
                {
                    this.onConnectionReady(this._connection);
                };
            };
        }

        private function onUserDefinedRoomEventsReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_5472 = (param2 as IHabboUserDefinedRoomEvents);
        }

        private function onHabboTrackingReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._habboTracking = (param2 as IHabboTracking);
        }

        private function onConnectionReady(param1:IConnection):void
        {
            if (disposed)
            {
                return;
            };
            if (param1 != null)
            {
                this._connection = param1;
            };
        }

        private function initializeRoomEngineEvents():void
        {
            if (((!(this._roomEngine == null)) && (!(this._roomEngine.events == null))))
            {
                this._roomEngine.events.addEventListener(RoomEngineEvent.var_329, this.roomEngineEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.var_50, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.var_51, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.var_331, this.roomEngineEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.var_330, this.roomEngineEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineDimmerStateEvent.var_380, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineRoomColorEvent.var_381, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_382, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_383, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_384, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_385, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_133, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_386, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_387, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_388, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_389, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_390, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_391, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_392, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_393, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_394, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_395, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_396, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_397, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_398, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_399, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_400, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_401, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_402, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineSoundMachineEvent.var_403, this.roomObjectEventHandler);
            };
        }

        private function roomEngineEventHandler(param1:RoomEngineEvent):void
        {
            var _loc2_:String;
            var _loc3_:RoomDesktop;
            if (param1 == null)
            {
                return;
            };
            if (param1.type == RoomEngineEvent.var_329)
            {
                if (this.var_3318 != null)
                {
                    this.var_3318.roomEngineReady = true;
                };
            }
            else
            {
                if (((param1.type == RoomEngineEvent.var_330) || (param1.type == RoomEngineEvent.var_331)))
                {
                    _loc2_ = this.getRoomIdentifier(param1.roomId, param1.roomCategory);
                    _loc3_ = (this.getDesktop(_loc2_) as RoomDesktop);
                    if (_loc3_ == null)
                    {
                        return;
                    };
                    _loc3_.roomEngineEventHandler(param1);
                };
            };
        }

        private function roomEventHandler(param1:RoomEngineEvent):void
        {
            var _loc4_:IRoomSession;
            var _loc5_:Boolean;
            var _loc6_:RoomEngineRoomColorEvent;
            if (param1 == null)
            {
                return;
            };
            if (this._roomEngine == null)
            {
                return;
            };
            var _loc2_:String = this.getRoomIdentifier(param1.roomId, param1.roomCategory);
            var _loc3_:RoomDesktop = (this.getDesktop(_loc2_) as RoomDesktop);
            if (_loc3_ == null)
            {
                if (this.var_3318 == null)
                {
                    return;
                };
                _loc4_ = this.var_3318.getSession(param1.roomId, param1.roomCategory);
                if (_loc4_ != null)
                {
                    _loc3_ = (this.createDesktop(_loc4_) as RoomDesktop);
                };
            };
            if (_loc3_ == null)
            {
                return;
            };
            switch (param1.type)
            {
                case RoomEngineEvent.var_50:
                    _loc5_ = false;
                    _loc3_.createRoomView(this.getActiveCanvasId(param1.roomId, param1.roomCategory));
                    if (this._roomEngine != null)
                    {
                        this._roomEngine.setActiveRoom(param1.roomId, param1.roomCategory);
                        if (this._roomEngine.isPublicRoomWorldType(this._roomEngine.getWorldType(param1.roomId, param1.roomCategory)))
                        {
                            _loc5_ = true;
                        };
                    };
                    _loc3_.disposeWidget(RoomWidgetEnum.var_404);
                    _loc3_.createWidget(RoomWidgetEnum.var_405);
                    _loc3_.createWidget(RoomWidgetEnum.var_406);
                    if (!_loc3_.session.isSpectatorMode)
                    {
                        _loc3_.createWidget(RoomWidgetEnum.var_407);
                        _loc3_.createWidget(RoomWidgetEnum.var_408);
                        _loc3_.createWidget(RoomWidgetEnum.var_374);
                        if (this._config.getKey("avatar.widget.enabled", "0") == "1")
                        {
                            _loc3_.createWidget(RoomWidgetEnum.var_409);
                        };
                    };
                    _loc3_.createWidget(RoomWidgetEnum.var_410);
                    _loc3_.createWidget(RoomWidgetEnum.var_411);
                    _loc3_.createWidget(RoomWidgetEnum.var_412);
                    _loc3_.createWidget(RoomWidgetEnum.var_413);
                    _loc3_.createWidget(RoomWidgetEnum.var_414);
                    _loc3_.createWidget(RoomWidgetEnum.var_415);
                    _loc3_.createWidget(RoomWidgetEnum.var_416);
                    _loc3_.createWidget(RoomWidgetEnum.var_417);
                    _loc3_.createWidget(RoomWidgetEnum.var_343);
                    _loc3_.createWidget(RoomWidgetEnum.var_418);
                    _loc3_.createWidget(RoomWidgetEnum.var_419);
                    _loc3_.createWidget(RoomWidgetEnum.var_420);
                    _loc3_.createWidget(RoomWidgetEnum.var_421);
                    _loc3_.createWidget(RoomWidgetEnum.var_422);
                    _loc3_.createWidget(RoomWidgetEnum.var_375);
                    _loc3_.createWidget(RoomWidgetEnum.var_423);
                    _loc3_.createWidget(RoomWidgetEnum.var_252);
                    if (!_loc5_)
                    {
                        _loc3_.createWidget(RoomWidgetEnum.var_424);
                    };
                    _loc3_.createWidget(RoomWidgetEnum.var_425);
                    if (this.var_5486 != RoomDesktop.var_337)
                    {
                        _loc3_.initializeWidget(RoomWidgetEnum.var_425, this.var_5486);
                    };
                    if (this.var_4906 != null)
                    {
                        this.var_4906.showRoomAd(param1.roomId, param1.roomCategory);
                    };
                    _loc3_.createWidget(RoomWidgetEnum.var_426);
                    _loc3_.createWidget(RoomWidgetEnum.var_427);
                    return;
                case RoomEngineEvent.var_51:
                    this.disposeDesktop(_loc2_);
                    return;
                case RoomEngineRoomColorEvent.var_381:
                    _loc6_ = (param1 as RoomEngineRoomColorEvent);
                    if (_loc6_ == null) break;
                    if (_loc6_.bgOnly)
                    {
                        _loc3_.setRoomViewColor(0xFFFFFF, 0xFF);
                    }
                    else
                    {
                        _loc3_.setRoomViewColor(_loc6_.color, _loc6_.brightness);
                    };
                    return;
                case RoomEngineDimmerStateEvent.var_380:
                    _loc3_.processEvent(param1);
                    return;
            };
        }

        private function roomObjectEventHandler(param1:RoomEngineObjectEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            if (this._roomEngine == null)
            {
                return;
            };
            var _loc2_:String = this.getRoomIdentifier(param1.roomId, param1.roomCategory);
            var _loc3_:RoomDesktop = (this.getDesktop(_loc2_) as RoomDesktop);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.roomObjectEventHandler(param1);
        }

        public function processWidgetMessage(param1:int, param2:int, param3:RoomWidgetMessage):void
        {
            if (param3 == null)
            {
                return;
            };
            if (this._roomEngine == null)
            {
                return;
            };
            var _loc4_:String = this.getRoomIdentifier(param1, param2);
            var _loc5_:RoomDesktop = (this.getDesktop(_loc4_) as RoomDesktop);
            if (_loc5_ == null)
            {
                return;
            };
            _loc5_.processWidgetMessage(param3);
        }

        public function createDesktop(param1:IRoomSession):IRoomDesktop
        {
            if (param1 == null)
            {
                return (null);
            };
            if (this._roomEngine == null)
            {
                return (null);
            };
            var _loc2_:String = this.getRoomIdentifier(param1.roomId, param1.roomCategory);
            var _loc3_:RoomDesktop = (this.getDesktop(_loc2_) as RoomDesktop);
            if (_loc3_ != null)
            {
                return (_loc3_);
            };
            _loc3_ = new RoomDesktop(param1, assets, this._connection);
            _loc3_.roomEngine = this._roomEngine;
            _loc3_.windowManager = this._windowManager;
            _loc3_.roomWidgetFactory = this.var_5470;
            _loc3_.sessionDataManager = this.var_1354;
            _loc3_.roomSessionManager = this.var_3318;
            _loc3_.friendList = this._friendList;
            _loc3_.avatarRenderManager = this.var_2860;
            _loc3_.inventory = this.var_3071;
            _loc3_.toolbar = this.var_3317;
            _loc3_.navigator = this._navigator;
            _loc3_.avatarEditor = this.var_2937;
            _loc3_.catalog = this._catalog;
            _loc3_.adManager = this.var_4906;
            _loc3_.localization = this._localization;
            _loc3_.habboHelp = this.var_4439;
            _loc3_.moderation = this.var_5471;
            _loc3_.config = this._config;
            _loc3_.soundManager = this._soundManager;
            _loc3_.habboTracking = this._habboTracking;
            _loc3_.userDefinedRoomEvents = this.var_5472;
            var _loc4_:XmlAsset = (assets.getAssetByName("room_desktop_layout_xml") as XmlAsset);
            if (_loc4_ != null)
            {
                _loc3_.layout = (_loc4_.content as XML);
            };
            _loc3_.createWidget(RoomWidgetEnum.var_428);
            _loc3_.createWidget(RoomWidgetEnum.var_404);
            _loc3_.init();
            if (_loc3_.showInterstitial())
            {
                this.var_5487 = true;
                this._interstitialRoomId = param1.roomId;
                this.var_5488 = param1.roomCategory;
            }
            else
            {
                this.var_5487 = false;
            };
            this.var_5485.add(_loc2_, _loc3_);
            return (_loc3_);
        }

        public function disposeDesktop(param1:String):void
        {
            var _loc3_:int;
            var _loc2_:RoomDesktop = (this.var_5485.remove(param1) as RoomDesktop);
            if (_loc2_ != null)
            {
                _loc3_ = _loc2_.getWidgetState(RoomWidgetEnum.var_425);
                if (_loc3_ != RoomDesktop.var_337)
                {
                    this.var_5486 = _loc3_;
                };
                _loc2_.dispose();
                this.var_5487 = false;
            };
        }

        public function getDesktop(param1:String):IRoomDesktop
        {
            return (this.var_5485.getValue(param1) as RoomDesktop);
        }

        public function getActiveCanvasId(param1:int, param2:int):int
        {
            return (1);
        }

        public function update(param1:uint):void
        {
            var _loc3_:RoomDesktop;
            var _loc2_:int;
            while (_loc2_ < this.var_5485.length)
            {
                _loc3_ = (this.var_5485.getWithIndex(_loc2_) as RoomDesktop);
                if (_loc3_ != null)
                {
                    _loc3_.update();
                };
                _loc2_++;
            };
        }

        private function getRoomIdentifier(param1:int, param2:int):String
        {
            return ("hard_coded_room_id");
        }


    }
}