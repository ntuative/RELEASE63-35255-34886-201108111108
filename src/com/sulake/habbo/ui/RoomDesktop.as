package com.sulake.habbo.ui
{
    import com.sulake.habbo.ui.widget.IRoomWidgetMessageListener;
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.moderation.IHabboModeration;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IToolTipWindow;
    import flash.utils.Timer;
    import flash.geom.Rectangle;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.friendlist.events.FriendRequestEvent;
    import com.sulake.habbo.navigator.events.HabboNavigatorEvent;
    import com.sulake.room.events.RoomContentLoadedEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.ui.widget.IRoomWidget;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetLoadingBarUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.ui.handler.ChatWidgetHandler;
    import com.sulake.habbo.ui.handler.PlayListEditorWidgetHandler;
    import com.sulake.habbo.ui.handler.SpamWallPostItWidgetHandler;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.handler.InfoStandWidgetHandler;
    import com.sulake.habbo.ui.handler.ChatInputWidgetHandler;
    import com.sulake.habbo.ui.handler.MeMenuWidgetHandler;
    import com.sulake.habbo.ui.handler.PlaceholderWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureCreditWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureStickieWidgetHandler;
    import com.sulake.habbo.ui.handler.FurniturePresentWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureTrophyWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureTeaserWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureEcotronBoxWidgetHandler;
    import com.sulake.habbo.ui.handler.PetPackageFurniWidgetHandler;
    import com.sulake.habbo.ui.handler.DoorbellWidgetHandler;
    import com.sulake.habbo.ui.handler.RoomQueueWidgetHandler;
    import com.sulake.habbo.ui.handler.LoadingBarWidgetHandler;
    import com.sulake.habbo.ui.handler.VoteWidgetHandler;
    import com.sulake.habbo.ui.handler.PollWidgetHandler;
    import com.sulake.habbo.ui.handler.FurniChooserWidgetHandler;
    import com.sulake.habbo.ui.handler.UserChooserWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureDimmerWidgetHandler;
    import com.sulake.habbo.ui.handler.FriendRequestWidgetHandler;
    import com.sulake.habbo.ui.handler.FurnitureClothingChangeWidgetHandler;
    import com.sulake.habbo.ui.handler.ConversionPointWidgetHandler;
    import com.sulake.habbo.ui.handler.UserNotificationWidgetHandler;
    import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
    import com.sulake.habbo.ui.handler.WelcomeGiftWidgetHandler;
    import com.sulake.habbo.ui.handler.EffectsWidgetHandler;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import flash.events.Event;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.room.object.RoomObjectOperationEnum;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.room.utils.RoomGeometry;
    import flash.display.DisplayObject;
    import com.sulake.habbo.room.RoomVariableEnum;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.display.Sprite;
    import flash.display.BlendMode;
    import flash.utils.getTimer;
    import com.sulake.room.utils.ColorConverter;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.filters.BlurFilter;
    import flash.display.BitmapData;
    import flash.display.BitmapDataChannel;
    import flash.filters.DisplacementMapFilterMode;
    import flash.filters.DisplacementMapFilter;
    import flash.filters.BitmapFilter;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.ui.handler.*;

    public class RoomDesktop implements IRoomDesktop, IRoomWidgetMessageListener, IRoomWidgetHandlerContainer 
    {

        public static const var_337:int = -1;
        private static const var_1558:int = 1000;

        private var _events:EventDispatcher;
        private var _windowManager:IHabboWindowManager = null;
        private var _roomEngine:IRoomEngine = null;
        private var var_5470:IRoomWidgetFactory = null;
        private var var_1354:ISessionDataManager = null;
        private var var_3318:IRoomSessionManager = null;
        private var var_2860:IAvatarRenderManager = null;
        private var _friendList:IHabboFriendList = null;
        private var var_3071:IHabboInventory = null;
        private var var_3317:IHabboToolbar = null;
        private var _navigator:IHabboNavigator = null;
        private var var_2937:IHabboAvatarEditor = null;
        private var _catalog:IHabboCatalog = null;
        private var var_4906:IAdManager = null;
        private var _localization:IHabboLocalizationManager = null;
        private var var_4439:IHabboHelp = null;
        private var _connection:IConnection = null;
        private var var_5471:IHabboModeration;
        private var _config:IHabboConfigurationManager;
        private var _soundManager:IHabboSoundManager;
        private var _habboTracking:IHabboTracking;
        private var var_5472:IHabboUserDefinedRoomEvents;
        private var _assets:IAssetLibrary = null;
        private var var_2487:IRoomSession = null;
        private var var_5473:Array = [];
        private var var_3288:Map;
        private var var_5474:Map;
        private var var_5475:Map;
        private var _updateListeners:Array;
        private var var_5476:DesktopLayoutManager;
        private var var_5477:Boolean = true;
        private var var_5478:Boolean = true;
        private var var_5479:Array;
        private var var_5480:IToolTipWindow;
        private var var_5481:uint = 0xFFFFFF;
        private var var_5482:Boolean = false;
        private var var_5483:int = 0;
        private var var_4148:Timer;
        private var var_5484:Rectangle;

        public function RoomDesktop(param1:IRoomSession, param2:IAssetLibrary, param3:IConnection)
        {
            this._events = new EventDispatcher();
            this.var_2487 = param1;
            this._assets = param2;
            this._connection = param3;
            this.var_3288 = new Map();
            this.var_5474 = new Map();
            this.var_5475 = new Map();
            this.var_5476 = new DesktopLayoutManager();
        }

        public function get roomSession():IRoomSession
        {
            return (this.var_2487);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (this.var_1354);
        }

        public function get events():IEventDispatcher
        {
            return (this._events);
        }

        public function get roomEngine():IRoomEngine
        {
            return (this._roomEngine);
        }

        public function get roomSessionManager():IRoomSessionManager
        {
            return (this.var_3318);
        }

        public function get friendList():IHabboFriendList
        {
            return (this._friendList);
        }

        public function get avatarRenderManager():IAvatarRenderManager
        {
            return (this.var_2860);
        }

        public function get inventory():IHabboInventory
        {
            return (this.var_3071);
        }

        public function get toolbar():IHabboToolbar
        {
            return (this.var_3317);
        }

        public function get roomWidgetFactory():IRoomWidgetFactory
        {
            return (this.var_5470);
        }

        public function get navigator():IHabboNavigator
        {
            return (this._navigator);
        }

        public function get avatarEditor():IHabboAvatarEditor
        {
            return (this.var_2937);
        }

        public function get catalog():IHabboCatalog
        {
            return (this._catalog);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }

        public function get habboHelp():IHabboHelp
        {
            return (this.var_4439);
        }

        public function get config():IHabboConfigurationManager
        {
            return (this._config);
        }

        public function get soundManager():IHabboSoundManager
        {
            return (this._soundManager);
        }

        public function get moderation():IHabboModeration
        {
            return (this.var_5471);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get habboTracking():IHabboTracking
        {
            return (this._habboTracking);
        }

        public function get session():IRoomSession
        {
            return (this.var_2487);
        }

        public function set catalog(param1:IHabboCatalog):void
        {
            this._catalog = param1;
        }

        public function set avatarEditor(param1:IHabboAvatarEditor):void
        {
            this.var_2937 = param1;
        }

        public function set roomWidgetFactory(param1:IRoomWidgetFactory):void
        {
            this.var_5470 = param1;
        }

        public function set sessionDataManager(param1:ISessionDataManager):void
        {
            this.var_1354 = param1;
        }

        public function set roomSessionManager(param1:IRoomSessionManager):void
        {
            this.var_3318 = param1;
        }

        public function get userDefinedRoomEvents():IHabboUserDefinedRoomEvents
        {
            return (this.var_5472);
        }

        public function get connection():IConnection
        {
            return (this._connection);
        }

        public function set friendList(param1:IHabboFriendList):void
        {
            this._friendList = param1;
            if (this._friendList)
            {
                this._friendList.events.addEventListener(FriendRequestEvent.var_345, this.processEvent);
                this._friendList.events.addEventListener(FriendRequestEvent.var_1373, this.processEvent);
            };
        }

        public function set avatarRenderManager(param1:IAvatarRenderManager):void
        {
            this.var_2860 = param1;
        }

        public function set windowManager(param1:IHabboWindowManager):void
        {
            this._windowManager = param1;
        }

        public function set inventory(param1:IHabboInventory):void
        {
            this.var_3071 = param1;
        }

        public function set navigator(param1:IHabboNavigator):void
        {
            this._navigator = param1;
            this._navigator.events.addEventListener(HabboNavigatorEvent.var_46, this.onNavigatorEvent);
        }

        public function set adManager(param1:IAdManager):void
        {
            this.var_4906 = param1;
        }

        public function set localization(param1:IHabboLocalizationManager):void
        {
            this._localization = param1;
        }

        public function set habboHelp(param1:IHabboHelp):void
        {
            this.var_4439 = param1;
        }

        public function set moderation(param1:IHabboModeration):void
        {
            this.var_5471 = param1;
        }

        public function set config(param1:IHabboConfigurationManager):void
        {
            this._config = param1;
        }

        public function set soundManager(param1:IHabboSoundManager):void
        {
            this._soundManager = param1;
        }

        public function set habboTracking(param1:IHabboTracking):void
        {
            this._habboTracking = param1;
        }

        public function set userDefinedRoomEvents(param1:IHabboUserDefinedRoomEvents):void
        {
            this.var_5472 = param1;
        }

        public function set roomEngine(param1:IRoomEngine):void
        {
            this._roomEngine = param1;
            if (((!(this._roomEngine == null)) && (!(this._roomEngine.events == null))))
            {
                this._roomEngine.events.addEventListener(RoomContentLoadedEvent.var_265, this.onRoomContentLoaded);
                this._roomEngine.events.addEventListener(RoomContentLoadedEvent.var_266, this.onRoomContentLoaded);
                this._roomEngine.events.addEventListener(RoomContentLoadedEvent.var_267, this.onRoomContentLoaded);
            };
        }

        public function set toolbar(param1:IHabboToolbar):void
        {
            this.var_3317 = param1;
        }

        public function set layout(param1:XML):void
        {
            this.var_5476.setLayout(param1, this._windowManager, this._config);
        }

        public function dispose():void
        {
            var _loc2_:IRoomGeometry;
            var _loc3_:int;
            var _loc4_:String;
            var _loc5_:IRoomWidget;
            if (((!(this._roomEngine == null)) && (!(this.var_2487 == null))))
            {
                _loc2_ = this._roomEngine.getRoomCanvasGeometry(this.var_2487.roomId, this.var_2487.roomCategory, this.getFirstCanvasId());
                if (_loc2_ != null)
                {
                    this.trackZoomTime(_loc2_.isZoomedIn());
                };
            };
            var _loc1_:int;
            if (this.var_5473 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_5473.length)
                {
                    _loc3_ = this.var_5473[_loc1_];
                    _loc4_ = this.getWindowName(_loc3_);
                    if (this._windowManager)
                    {
                        this._windowManager.removeWindow(_loc4_);
                    };
                    _loc1_++;
                };
            };
            this._updateListeners = null;
            if (this.var_3288 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_3288.length)
                {
                    _loc5_ = (this.var_3288.getWithIndex(_loc1_) as IRoomWidget);
                    if (_loc5_ != null)
                    {
                        _loc5_.dispose();
                    };
                    _loc1_++;
                };
                this.var_3288.dispose();
                this.var_3288 = null;
            };
            if (this.var_5474 != null)
            {
                this.var_5474.dispose();
                this.var_5474 = null;
            };
            if (this.var_5475 != null)
            {
                this.var_5475.dispose();
                this.var_5475 = null;
            };
            this._assets = null;
            this.var_2860 = null;
            this.var_5473 = null;
            this._events = null;
            if (((this._friendList) && (this._friendList.events)))
            {
                this._friendList.events.removeEventListener(FriendRequestEvent.var_345, this.processEvent);
                this._friendList.events.removeEventListener(FriendRequestEvent.var_1373, this.processEvent);
            };
            this._friendList = null;
            this.var_5476.dispose();
            this.var_5476 = null;
            if (((!(this._roomEngine == null)) && (!(this._roomEngine.events == null))))
            {
                this._roomEngine.events.removeEventListener(RoomContentLoadedEvent.var_265, this.onRoomContentLoaded);
                this._roomEngine.events.removeEventListener(RoomContentLoadedEvent.var_266, this.onRoomContentLoaded);
                this._roomEngine.events.removeEventListener(RoomContentLoadedEvent.var_267, this.onRoomContentLoaded);
            };
            this._roomEngine = null;
            this.var_3318 = null;
            this.var_5470 = null;
            this.var_2487 = null;
            this.var_1354 = null;
            this._windowManager = null;
            this.var_3071 = null;
            this._localization = null;
            this._config = null;
            this._soundManager = null;
            if (((this._navigator) && (this._navigator.events)))
            {
                this._navigator.events.removeEventListener(HabboNavigatorEvent.var_46, this.onNavigatorEvent);
                this._navigator = null;
            };
            if (this.var_5480 != null)
            {
                this.var_5480.dispose();
                this.var_5480 = null;
            };
            if (this.var_4148 != null)
            {
                this.var_4148.reset();
                this.var_4148.removeEventListener(TimerEvent.TIMER, this.onResizeTimerEvent);
                this.var_4148 = null;
            };
            this.var_5484 = null;
        }

        public function init():void
        {
            if (((!(this._roomEngine == null)) && (!(this.var_2487 == null))))
            {
                this.var_5479 = this._roomEngine.loadRoomResources(this.var_2487.roomResources);
                if (this.var_5479.length > 0)
                {
                    this.var_5478 = false;
                    this.processEvent(new RoomWidgetLoadingBarUpdateEvent(RoomWidgetLoadingBarUpdateEvent.var_1537));
                };
            };
        }

        public function showInterstitial():Boolean
        {
            if (((!(this.var_4906 == null)) && (this.var_2487.state == RoomSessionEvent.var_93)))
            {
                this.var_5477 = (!(this.var_4906.showInterstitial()));
            };
            return (this.checkInterrupts());
        }

        private function onRoomContentLoaded(param1:RoomContentLoadedEvent):void
        {
            if (((this.var_5479 == null) || (this.var_5479.length == 0)))
            {
                return;
            };
            var _loc2_:int = this.var_5479.indexOf(param1.contentType);
            if (_loc2_ != -1)
            {
                this.var_5479.splice(_loc2_, 1);
            };
            if (this.var_5479.length == 0)
            {
                this.var_5478 = true;
                this.checkInterrupts();
            };
        }

        public function createWidget(param1:String):void
        {
            var _loc3_:Boolean;
            var _loc4_:IRoomWidgetHandler;
            var _loc5_:ChatWidgetHandler;
            var _loc6_:PlayListEditorWidgetHandler;
            var _loc7_:SpamWallPostItWidgetHandler;
            var _loc8_:Array;
            var _loc9_:Array;
            var _loc10_:Array;
            var _loc11_:String;
            var _loc12_:String;
            var _loc13_:RoomWidgetRoomViewUpdateEvent;
            if (this.var_5470 == null)
            {
                return;
            };
            var _loc2_:IRoomWidget = (this.var_3288.getValue(param1) as IRoomWidget);
            if (_loc2_ != null)
            {
                return;
            };
            switch (param1)
            {
                case RoomWidgetEnum.var_405:
                    _loc5_ = new ChatWidgetHandler();
                    _loc5_.connection = this._connection;
                    _loc4_ = _loc5_;
                    _loc3_ = true;
                    break;
                case RoomWidgetEnum.var_406:
                    _loc4_ = new InfoStandWidgetHandler(this._soundManager.musicController);
                    break;
                case RoomWidgetEnum.var_408:
                    _loc3_ = true;
                    _loc4_ = new ChatInputWidgetHandler();
                    break;
                case RoomWidgetEnum.var_407:
                    _loc4_ = new MeMenuWidgetHandler();
                    break;
                case RoomWidgetEnum.var_410:
                    _loc4_ = new PlaceholderWidgetHandler();
                    break;
                case RoomWidgetEnum.var_411:
                    _loc4_ = new FurnitureCreditWidgetHandler();
                    break;
                case RoomWidgetEnum.var_412:
                    _loc4_ = new FurnitureStickieWidgetHandler();
                    break;
                case RoomWidgetEnum.var_413:
                    _loc4_ = new FurniturePresentWidgetHandler();
                    break;
                case RoomWidgetEnum.var_414:
                    _loc4_ = new FurnitureTrophyWidgetHandler();
                    break;
                case RoomWidgetEnum.var_415:
                    _loc4_ = new FurnitureTeaserWidgetHandler();
                    break;
                case RoomWidgetEnum.var_416:
                    _loc4_ = new FurnitureEcotronBoxWidgetHandler();
                    break;
                case RoomWidgetEnum.var_417:
                    _loc4_ = new PetPackageFurniWidgetHandler();
                    break;
                case RoomWidgetEnum.var_343:
                    _loc4_ = new DoorbellWidgetHandler();
                    break;
                case RoomWidgetEnum.var_404:
                    _loc4_ = new RoomQueueWidgetHandler();
                    break;
                case RoomWidgetEnum.var_428:
                    _loc4_ = new LoadingBarWidgetHandler();
                    break;
                case RoomWidgetEnum.var_419:
                    _loc4_ = new VoteWidgetHandler();
                    break;
                case RoomWidgetEnum.var_418:
                    _loc4_ = new PollWidgetHandler();
                    break;
                case RoomWidgetEnum.var_424:
                    _loc4_ = new FurniChooserWidgetHandler();
                    break;
                case RoomWidgetEnum.var_425:
                    _loc4_ = new UserChooserWidgetHandler();
                    break;
                case RoomWidgetEnum.var_420:
                    _loc4_ = new FurnitureDimmerWidgetHandler();
                    break;
                case RoomWidgetEnum.var_374:
                    _loc4_ = new FriendRequestWidgetHandler();
                    break;
                case RoomWidgetEnum.var_421:
                    _loc4_ = new FurnitureClothingChangeWidgetHandler();
                    break;
                case RoomWidgetEnum.var_422:
                    _loc4_ = new ConversionPointWidgetHandler();
                    break;
                case RoomWidgetEnum.var_375:
                    _loc4_ = new UserNotificationWidgetHandler();
                    break;
                case RoomWidgetEnum.var_409:
                    _loc4_ = new AvatarInfoWidgetHandler();
                    break;
                case RoomWidgetEnum.var_423:
                    _loc4_ = new WelcomeGiftWidgetHandler();
                    break;
                case RoomWidgetEnum.var_426:
                    _loc6_ = new PlayListEditorWidgetHandler();
                    _loc6_.connection = this._connection;
                    _loc4_ = (_loc6_ as IRoomWidgetHandler);
                    break;
                case RoomWidgetEnum.var_427:
                    _loc7_ = new SpamWallPostItWidgetHandler();
                    _loc7_.connection = this._connection;
                    _loc4_ = (_loc7_ as IRoomWidgetHandler);
                    break;
                case RoomWidgetEnum.var_252:
                    _loc4_ = new EffectsWidgetHandler();
                    break;
            };
            if (_loc4_ != null)
            {
                _loc4_.container = this;
                _loc8_ = null;
                _loc9_ = _loc4_.getWidgetMessages();
                if (_loc9_ != null)
                {
                    for each (_loc11_ in _loc9_)
                    {
                        _loc8_ = this.var_5474.getValue(_loc11_);
                        if (_loc8_ == null)
                        {
                            _loc8_ = [];
                            this.var_5474.add(_loc11_, _loc8_);
                        }
                        else
                        {
                            Logger.log((("Room widget message '" + _loc11_) + "' handled by more than one widget message handler, could cause problems. Be careful!"));
                        };
                        _loc8_.push(_loc4_);
                    };
                };
                _loc10_ = _loc4_.getProcessedEvents();
                if (_loc10_ != null)
                {
                    for each (_loc12_ in _loc10_)
                    {
                        _loc8_ = this.var_5475.getValue(_loc12_);
                        if (_loc8_ == null)
                        {
                            _loc8_ = [];
                            this.var_5475.add(_loc12_, _loc8_);
                        };
                        _loc8_.push(_loc4_);
                    };
                };
            };
            _loc2_ = this.var_5470.createWidget(param1, _loc4_);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.messageListener = this;
            _loc2_.registerUpdateEvents(this._events);
            if (!this.var_3288.add(param1, _loc2_))
            {
                _loc2_.dispose();
            }
            else
            {
                this.var_5476.addWidgetWindow(param1, _loc2_.mainWindow);
            };
            if (_loc3_)
            {
                param1 = RoomWidgetRoomViewUpdateEvent.var_1538;
                _loc13_ = new RoomWidgetRoomViewUpdateEvent(param1, this.var_5476.roomViewRect);
                this.events.dispatchEvent(_loc13_);
            };
        }

        public function disposeWidget(param1:String):void
        {
            var _loc2_:IRoomWidget;
            if (this.var_3288 != null)
            {
                _loc2_ = this.var_3288.remove(param1);
                if (_loc2_ != null)
                {
                    if (this.var_5476 != null)
                    {
                        this.var_5476.removeWidgetWindow(param1, _loc2_.mainWindow);
                    };
                    _loc2_.dispose();
                };
            };
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc3_:IRoomWidgetHandler;
            var _loc4_:RoomWidgetUpdateEvent;
            if (param1 == null)
            {
                return (null);
            };
            var _loc2_:Array = this.var_5474.getValue(param1.type);
            if (_loc2_ != null)
            {
                for each (_loc3_ in _loc2_)
                {
                    _loc4_ = _loc3_.processWidgetMessage(param1);
                    if (_loc4_ != null)
                    {
                        return (_loc4_);
                    };
                };
            };
            return (null);
        }

        public function processEvent(param1:Event):void
        {
            var _loc3_:IRoomWidgetHandler;
            if (!param1)
            {
                return;
            };
            var _loc2_:Array = this.var_5475.getValue(param1.type);
            if (_loc2_ != null)
            {
                for each (_loc3_ in _loc2_)
                {
                    _loc3_.processEvent(param1);
                };
            };
        }

        private function isFurnitureSelectionDisabled(param1:RoomEngineObjectEvent):Boolean
        {
            var _loc4_:IRoomObjectModel;
            var _loc2_:Boolean;
            var _loc3_:IRoomObject = this.roomEngine.getRoomObject(param1.roomId, param1.roomCategory, param1.objectId, param1.category);
            if (_loc3_ != null)
            {
                _loc4_ = _loc3_.getModel();
                if (_loc4_ != null)
                {
                    if (_loc4_.getNumber(RoomObjectVariableEnum.var_773) == 1)
                    {
                        _loc2_ = true;
                        if (this.var_1354.isAnyRoomController)
                        {
                            _loc2_ = false;
                        };
                    };
                };
            };
            return (_loc2_);
        }

        public function roomObjectEventHandler(param1:RoomEngineObjectEvent):void
        {
            var _loc6_:String;
            var _loc7_:IUserData;
            if (param1 == null)
            {
                return;
            };
            var _loc2_:int = int(param1.objectId);
            var _loc3_:int = int(param1.category);
            var _loc4_:RoomWidgetRoomObjectUpdateEvent;
            var _loc5_:RoomWidgetFurniToWidgetMessage;
            switch (param1.type)
            {
                case RoomEngineObjectEvent.var_382:
                    if (!this.isFurnitureSelectionDisabled(param1))
                    {
                        _loc4_ = new RoomWidgetRoomObjectUpdateEvent(RoomWidgetRoomObjectUpdateEvent.var_1539, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    };
                    if (((!(this.var_5471 == null)) && (_loc3_ == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)))
                    {
                        _loc7_ = this.var_2487.userDataManager.getUserDataByIndex(_loc2_);
                        if (((!(_loc7_ == null)) && (_loc7_.type == RoomObjectTypeEnum.var_1406)))
                        {
                            this.var_5471.userSelected(_loc7_.webID, _loc7_.name);
                        };
                    };
                    break;
                case RoomEngineObjectEvent.var_384:
                    switch (_loc3_)
                    {
                        case RoomObjectCategoryEnum.var_70:
                        case RoomObjectCategoryEnum.var_71:
                            _loc6_ = RoomWidgetRoomObjectUpdateEvent.var_1540;
                            break;
                        case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                            _loc6_ = RoomWidgetRoomObjectUpdateEvent.var_1541;
                            break;
                    };
                    if (_loc6_ != null)
                    {
                        _loc4_ = new RoomWidgetRoomObjectUpdateEvent(_loc6_, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    };
                    break;
                case RoomEngineObjectEvent.var_385:
                    switch (_loc3_)
                    {
                        case RoomObjectCategoryEnum.var_70:
                        case RoomObjectCategoryEnum.var_71:
                            _loc6_ = RoomWidgetRoomObjectUpdateEvent.var_1542;
                            break;
                        case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                            _loc6_ = RoomWidgetRoomObjectUpdateEvent.var_1543;
                            break;
                    };
                    if (_loc6_ != null)
                    {
                        _loc4_ = new RoomWidgetRoomObjectUpdateEvent(_loc6_, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    };
                    break;
                case RoomEngineObjectEvent.var_383:
                    _loc4_ = new RoomWidgetRoomObjectUpdateEvent(RoomWidgetRoomObjectUpdateEvent.var_1544, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    break;
                case RoomEngineObjectEvent.var_387:
                    _loc4_ = new RoomWidgetRoomObjectUpdateEvent(RoomWidgetRoomObjectUpdateEvent.var_1545, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    break;
                case RoomEngineObjectEvent.var_388:
                    _loc4_ = new RoomWidgetRoomObjectUpdateEvent(RoomWidgetRoomObjectUpdateEvent.var_1546, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    break;
                case RoomEngineObjectEvent.var_386:
                    if (((!(this.var_2487.isRoomController)) && (!(this.var_1354.isAnyRoomController))))
                    {
                        return;
                    };
                    this._roomEngine.modifyRoomObject(param1.objectId, param1.category, RoomObjectOperationEnum.OBJECT_MOVE);
                    break;
                case RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1547, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.var_389:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1548, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.var_390:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1549, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.var_391:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1550, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.var_392:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1551, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.var_393:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.WIDGET_MESSAGE_REQUEST_ECOTRONBOX_WIDGET, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.var_395:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1552, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.var_394:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1553, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.var_396:
                case RoomEngineObjectEvent.var_397:
                    this.handleRoomAdClick(param1);
                    break;
                case RoomEngineObjectEvent.var_398:
                case RoomEngineObjectEvent.var_399:
                    this.handleRoomAdTooltip(param1);
                    break;
                case RoomEngineObjectEvent.var_400:
                    this.processEvent(param1);
                    break;
                case RoomEngineObjectEvent.var_401:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1554, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.var_402:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1555, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineSoundMachineEvent.var_403:
                    this.processEvent(param1);
                    break;
            };
            if (_loc4_ != null)
            {
                this.events.dispatchEvent(_loc4_);
            };
        }

        public function roomEngineEventHandler(param1:RoomEngineEvent):void
        {
            var _loc2_:RoomWidgetUpdateEvent;
            switch (param1.type)
            {
                case RoomEngineEvent.var_331:
                    _loc2_ = new RoomWidgetRoomEngineUpdateEvent(RoomWidgetRoomEngineUpdateEvent.var_450, param1.roomId, param1.roomCategory);
                    break;
                case RoomEngineEvent.var_330:
                    _loc2_ = new RoomWidgetRoomEngineUpdateEvent(RoomWidgetRoomEngineUpdateEvent.var_1556, param1.roomId, param1.roomCategory);
                    break;
            };
            if (_loc2_ != null)
            {
                this.events.dispatchEvent(_loc2_);
            };
        }

        public function createRoomView(param1:int):void
        {
            var _loc13_:Number;
            var _loc14_:Number;
            var _loc15_:Number;
            var _loc16_:Number;
            var _loc17_:Number;
            var _loc18_:Number;
            var _loc19_:Number;
            var _loc20_:Number;
            var _loc21_:IWindow;
            var _loc2_:Rectangle = this.var_5476.roomViewRect;
            var _loc3_:int = _loc2_.width;
            var _loc4_:int = _loc2_.height;
            var _loc5_:int = RoomGeometry.var_1557;
            if (this.var_5473.indexOf(param1) >= 0)
            {
                return;
            };
            if ((((this.var_2487 == null) || (this._windowManager == null)) || (this._roomEngine == null)))
            {
                return;
            };
            var _loc6_:DisplayObject = this._roomEngine.createRoomCanvas(this.var_2487.roomId, this.var_2487.roomCategory, param1, _loc3_, _loc4_, _loc5_);
            if (_loc6_ == null)
            {
                return;
            };
            var _loc7_:RoomGeometry = (this._roomEngine.getRoomCanvasGeometry(this.var_2487.roomId, this.var_2487.roomCategory, param1) as RoomGeometry);
            if (_loc7_ != null)
            {
                _loc13_ = this._roomEngine.getRoomNumberValue(this.var_2487.roomId, this.var_2487.roomCategory, RoomVariableEnum.var_461);
                _loc14_ = this._roomEngine.getRoomNumberValue(this.var_2487.roomId, this.var_2487.roomCategory, RoomVariableEnum.var_463);
                _loc15_ = this._roomEngine.getRoomNumberValue(this.var_2487.roomId, this.var_2487.roomCategory, RoomVariableEnum.var_462);
                _loc16_ = this._roomEngine.getRoomNumberValue(this.var_2487.roomId, this.var_2487.roomCategory, RoomVariableEnum.var_464);
                _loc17_ = ((_loc13_ + _loc14_) / 2);
                _loc18_ = ((_loc15_ + _loc16_) / 2);
                _loc19_ = 20;
                _loc17_ = (_loc17_ + (_loc19_ - 1));
                _loc18_ = (_loc18_ + (_loc19_ - 1));
                _loc20_ = (Math.sqrt(((_loc19_ * _loc19_) + (_loc19_ * _loc19_))) * Math.tan(((30 / 180) * Math.PI)));
                _loc7_.location = new Vector3d(_loc17_, _loc18_, _loc20_);
            };
            var _loc8_:XmlAsset = (this._assets.getAssetByName("room_view_container_xml") as XmlAsset);
            if (_loc8_ == null)
            {
                return;
            };
            var _loc9_:IWindowContainer = (this._windowManager.buildFromXML((_loc8_.content as XML)) as IWindowContainer);
            if (_loc9_ == null)
            {
                return;
            };
            _loc9_.width = _loc3_;
            _loc9_.height = _loc4_;
            var _loc10_:IDisplayObjectWrapper = (_loc9_.findChildByName("room_canvas_wrapper") as IDisplayObjectWrapper);
            if (_loc10_ == null)
            {
                return;
            };
            _loc10_.setDisplayObject(_loc6_);
            _loc10_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowMouseEvent.var_649, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowMouseEvent.var_654, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowMouseEvent.var_650, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowMouseEvent.var_655, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowMouseEvent.var_656, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowEvent.var_589, this.onRoomViewResized);
            var _loc11_:Sprite = new Sprite();
            _loc11_.mouseEnabled = false;
            _loc11_.blendMode = BlendMode.MULTIPLY;
            _loc10_ = (_loc9_.findChildByName("colorizer_wrapper") as IDisplayObjectWrapper);
            if (_loc10_ == null)
            {
                return;
            };
            _loc10_.setDisplayObject(_loc11_);
            _loc10_.addEventListener(WindowEvent.var_589, this.resizeColorizer);
            if (this.var_2487.isSpectatorMode)
            {
                _loc21_ = this.getSpectatorModeVisualization();
                if (_loc21_ != null)
                {
                    _loc21_.width = _loc9_.width;
                    _loc21_.height = _loc9_.height;
                    _loc9_.addChild(_loc21_);
                };
            };
            this.var_5476.addRoomView(_loc9_);
            this.var_5473.push(param1);
            var _loc12_:String = this._roomEngine.getWorldType(this.var_2487.roomId, this.var_2487.roomCategory);
            if (!this._roomEngine.isPublicRoomWorldType(_loc12_))
            {
                this.var_5482 = true;
                this.var_5483 = getTimer();
            };
        }

        private function resizeColorizer(param1:WindowEvent):void
        {
            var _loc2_:IDisplayObjectWrapper = (param1.target as IDisplayObjectWrapper);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:Sprite = (_loc2_.getDisplayObject() as Sprite);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.graphics.clear();
            _loc3_.graphics.beginFill(this.var_5481);
            _loc3_.graphics.drawRect(0, 0, _loc2_.width, _loc2_.height);
            _loc3_.graphics.endFill();
        }

        public function setRoomViewColor(param1:uint, param2:int):void
        {
            var _loc3_:IWindowContainer = (this.var_5476.getRoomView() as IWindowContainer);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:IDisplayObjectWrapper = (_loc3_.getChildByName("colorizer_wrapper") as IDisplayObjectWrapper);
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:Sprite = (_loc4_.getDisplayObject() as Sprite);
            if (_loc5_ == null)
            {
                return;
            };
            var _loc6_:int = ColorConverter.rgbToHSL(param1);
            _loc6_ = ((_loc6_ & 0xFFFF00) + param2);
            param1 = ColorConverter.hslToRGB(_loc6_);
            this.var_5481 = param1;
            _loc5_.graphics.clear();
            _loc5_.graphics.beginFill(param1);
            _loc5_.graphics.drawRect(0, 0, _loc4_.width, _loc4_.height);
            _loc5_.graphics.endFill();
        }

        public function getFirstCanvasId():int
        {
            if (this.var_5473 != null)
            {
                if (this.var_5473.length > 0)
                {
                    return (this.var_5473[0]);
                };
            };
            return (0);
        }

        public function getRoomViewRect():Rectangle
        {
            if (!this.var_5476)
            {
                return (null);
            };
            return (this.var_5476.roomViewRect);
        }

        public function canvasMouseHandler(param1:WindowEvent):void
        {
            var _loc5_:Point;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:Point;
            if (((this._roomEngine == null) || (this.var_2487 == null)))
            {
                return;
            };
            var _loc2_:WindowMouseEvent = (param1 as WindowMouseEvent);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:String = "";
            switch (_loc2_.type)
            {
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    _loc3_ = MouseEvent.CLICK;
                    break;
                case WindowMouseEvent.var_649:
                    _loc3_ = MouseEvent.DOUBLE_CLICK;
                    break;
                case WindowMouseEvent.var_650:
                    _loc3_ = MouseEvent.MOUSE_DOWN;
                    break;
                case WindowMouseEvent.var_655:
                case WindowMouseEvent.var_656:
                    _loc3_ = MouseEvent.MOUSE_UP;
                    break;
                case WindowMouseEvent.var_654:
                    _loc3_ = MouseEvent.MOUSE_MOVE;
                    break;
                default:
                    return;
            };
            var _loc4_:IDisplayObjectWrapper = (_loc2_.target as IDisplayObjectWrapper);
            if (_loc4_ == _loc2_.target)
            {
                _loc5_ = new Point();
                _loc4_.getGlobalPosition(_loc5_);
                _loc6_ = (_loc2_.stageX - _loc5_.x);
                _loc7_ = (_loc2_.stageY - _loc5_.y);
                this._roomEngine.setActiveRoom(this.var_2487.roomId, this.var_2487.roomCategory);
                this._roomEngine.handleRoomCanvasMouseEvent(this.var_5473[0], _loc6_, _loc7_, _loc3_, _loc2_.altKey, _loc2_.ctrlKey, _loc2_.shiftKey, _loc2_.buttonDown);
            };
            if (((_loc3_ == MouseEvent.MOUSE_MOVE) && (!(this.var_5480 == null))))
            {
                _loc8_ = new Point(_loc2_.stageX, _loc2_.stageY);
                _loc8_.offset((-(this.var_5480.width) / 2), 15);
                this.var_5480.setGlobalPosition(_loc8_);
            };
        }

        private function onRoomViewResized(param1:WindowEvent):void
        {
            var _loc2_:IWindow = param1.window;
            this.var_5484 = _loc2_.rectangle;
            this._roomEngine.modifyRoomCanvas(this.var_2487.roomId, this.var_2487.roomCategory, this.var_5473[0], _loc2_.width, _loc2_.height);
            if (this.var_4148 == null)
            {
                this.var_4148 = new Timer(var_1558, 1);
                this.var_4148.addEventListener(TimerEvent.TIMER, this.onResizeTimerEvent);
            }
            else
            {
                this.var_4148.reset();
            };
            this.var_4148.start();
        }

        private function onResizeTimerEvent(param1:TimerEvent):void
        {
            var _loc2_:String = RoomWidgetRoomViewUpdateEvent.var_1538;
            this.events.dispatchEvent(new RoomWidgetRoomViewUpdateEvent(_loc2_, this.var_5484));
        }

        private function trackZoomTime(param1:Boolean):void
        {
            var _loc2_:int;
            var _loc3_:int;
            if (this.var_5482)
            {
                _loc2_ = getTimer();
                _loc3_ = int(Math.round(((_loc2_ - this.var_5483) / 1000)));
                if (this._habboTracking != null)
                {
                    if (param1)
                    {
                        this._habboTracking.trackGoogle("zoomEnded", "in", _loc3_);
                    }
                    else
                    {
                        this._habboTracking.trackGoogle("zoomEnded", "out", _loc3_);
                    };
                };
                this.var_5483 = _loc2_;
            };
        }

        private function onNavigatorEvent(param1:HabboNavigatorEvent):void
        {
            var _loc2_:IRoomGeometry;
            if (param1.type == HabboNavigatorEvent.var_46)
            {
                if (this.var_2487 != null)
                {
                    _loc2_ = this._roomEngine.getRoomCanvasGeometry(this.var_2487.roomId, this.var_2487.roomCategory, this.getFirstCanvasId());
                    if (_loc2_ != null)
                    {
                        this.trackZoomTime(_loc2_.isZoomedIn());
                        _loc2_.performZoom();
                    };
                };
            };
        }

        public function update():void
        {
            var _loc3_:IRoomWidgetHandler;
            if (this._updateListeners == null)
            {
                return;
            };
            var _loc1_:int = this._updateListeners.length;
            var _loc2_:int;
            while (_loc2_ < _loc1_)
            {
                _loc3_ = (this._updateListeners.getWithIndex(_loc2_) as IRoomWidgetHandler);
                if (_loc3_ != null)
                {
                    _loc3_.update();
                };
                _loc2_++;
            };
        }

        private function getWindowName(param1:int):String
        {
            return ("Room_Engine_Window_" + param1);
        }

        private function createFilter(param1:int, param2:int):Array
        {
            var _loc3_:BlurFilter = new BlurFilter(2, 2);
            return ([]);
        }

        private function getBitmapFilter(param1:int, param2:int):BitmapFilter
        {
            var _loc3_:BitmapData = new BitmapData(param1, param2);
            _loc3_.perlinNoise(param1, param2, 5, (Math.random() * 0x77359400), true, false);
            var _loc4_:Point = new Point(0, 0);
            var _loc5_:uint = BitmapDataChannel.RED;
            var _loc6_:uint = _loc5_;
            var _loc7_:uint = _loc5_;
            var _loc8_:Number = (param1 / 20);
            var _loc9_:Number = (-(param1) / 25);
            var _loc10_:String = DisplacementMapFilterMode.COLOR;
            var _loc11_:uint;
            var _loc12_:Number = 0;
            return (new DisplacementMapFilter(_loc3_, _loc4_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_));
        }

        private function checkInterrupts():Boolean
        {
            if (((((!(this.var_3318 == null)) && (!(this.var_2487 == null))) && (this.var_5477)) && (this.var_5478)))
            {
                this.var_3318.startSession(this.var_2487);
                this.processEvent(new RoomWidgetLoadingBarUpdateEvent(RoomWidgetLoadingBarUpdateEvent.var_1559));
                return (true);
            };
            return (false);
        }

        public function setInterstitialCompleted():void
        {
            this.var_5477 = true;
            this.checkInterrupts();
        }

        private function handleRoomAdClick(param1:RoomEngineObjectEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:IRoomObject = this._roomEngine.getRoomObject(param1.roomId, param1.roomCategory, param1.objectId, param1.category);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IRoomObjectModel = (_loc2_.getModel() as IRoomObjectModel);
            var _loc4_:String = _loc3_.getString(RoomObjectVariableEnum.var_501);
            if (((_loc4_ == null) || (!(_loc4_.indexOf("http") == 0))))
            {
                return;
            };
            switch (param1.type)
            {
                case RoomEngineObjectEvent.var_396:
                    if (((this.var_2487.isRoomController) || (this.var_1354.isAnyRoomController)))
                    {
                        return;
                    };
                    HabboWebTools.openWebPage(_loc4_);
                    return;
                case RoomEngineObjectEvent.var_397:
                    if (((!(this.var_2487.isRoomController)) && (!(this.var_1354.isAnyRoomController))))
                    {
                        return;
                    };
                    HabboWebTools.openWebPage(_loc4_);
                    return;
            };
        }

        private function handleRoomAdTooltip(param1:RoomEngineObjectEvent):void
        {
            var _loc2_:IRoomObject;
            var _loc3_:String;
            if (param1 == null)
            {
                return;
            };
            switch (param1.type)
            {
                case RoomEngineObjectEvent.var_398:
                    if (this.var_5480 != null)
                    {
                        return;
                    };
                    _loc2_ = this._roomEngine.getRoomObject(param1.roomId, param1.roomCategory, param1.objectId, param1.category);
                    if (_loc2_ == null)
                    {
                        return;
                    };
                    _loc3_ = this._localization.getKey((_loc2_.getType() + ".tooltip"), "${ads.roomad.tooltip}");
                    this.var_5480 = (this._windowManager.createWindow("room_ad_tooltip", _loc3_, WindowType.var_241, WindowStyle.var_1192, WindowParam.var_711) as IToolTipWindow);
                    this.var_5480.setParamFlag(WindowParam.var_609, false);
                    this.var_5480.visible = true;
                    this.var_5480.center();
                    return;
                case RoomEngineObjectEvent.var_399:
                    if (this.var_5480 == null)
                    {
                        return;
                    };
                    this.var_5480.dispose();
                    this.var_5480 = null;
                    return;
            };
        }

        private function getSpectatorModeVisualization():IWindow
        {
            var _loc1_:XmlAsset = (this._assets.getAssetByName("spectator_mode_xml") as XmlAsset);
            if (_loc1_ == null)
            {
                return (null);
            };
            var _loc2_:IWindowContainer = (this._windowManager.buildFromXML((_loc1_.content as XML)) as IWindowContainer);
            if (_loc2_ == null)
            {
                return (null);
            };
            this.setBitmap(_loc2_.findChildByName("top_left"), "spec_top_left_png");
            this.setBitmap(_loc2_.findChildByName("top_middle"), "spec_top_middle_png");
            this.setBitmap(_loc2_.findChildByName("top_right"), "spec_top_right_png");
            this.setBitmap(_loc2_.findChildByName("middle_left"), "spec_middle_left_png");
            this.setBitmap(_loc2_.findChildByName("middle_right"), "spec_middle_right_png");
            this.setBitmap(_loc2_.findChildByName("bottom_left"), "spec_bottom_left_png");
            this.setBitmap(_loc2_.findChildByName("bottom_middle"), "spec_bottom_middle_png");
            this.setBitmap(_loc2_.findChildByName("bottom_right"), "spec_bottom_right_png");
            return (_loc2_);
        }

        private function setBitmap(param1:IWindow, param2:String):void
        {
            var _loc3_:IBitmapWrapperWindow = (param1 as IBitmapWrapperWindow);
            if (((_loc3_ == null) || (this._assets == null)))
            {
                return;
            };
            var _loc4_:BitmapDataAsset = (this._assets.getAssetByName(param2) as BitmapDataAsset);
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:BitmapData = (_loc4_.content as BitmapData);
            if (_loc5_ == null)
            {
                return;
            };
            _loc3_.bitmap = _loc5_.clone();
        }

        public function initializeWidget(param1:String, param2:int=0):void
        {
            var _loc3_:IRoomWidget = this.var_3288[param1];
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.initialize(param2);
        }

        public function getWidgetState(param1:String):int
        {
            var _loc2_:IRoomWidget = this.var_3288[param1];
            if (_loc2_ == null)
            {
                return (var_337);
            };
            return (_loc2_.state);
        }

        public function addUpdateListener(param1:IRoomWidgetHandler):void
        {
            if (this._updateListeners == null)
            {
                this._updateListeners = new Array();
            };
            if (this._updateListeners.indexOf(param1) == -1)
            {
                this._updateListeners.push(param1);
            };
        }

        public function removeUpdateListener(param1:IRoomWidgetHandler):void
        {
            if (this._updateListeners == null)
            {
                return;
            };
            var _loc2_:int = this._updateListeners.indexOf(param1);
            if (_loc2_ != -1)
            {
                this._updateListeners.splice(_loc2_, 1);
            };
        }


    }
}