package com.sulake.habbo.tracking
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.communication.connection.IConnection;
    import flash.utils.Timer;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.external.ExternalInterface;
    import flash.system.Capabilities;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboAdManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.navigator.events.HabboNavigatorTrackingEvent;
    import com.sulake.habbo.navigator.events.HabboRoomSettingsTrackingEvent;
    import com.sulake.habbo.navigator.events.HabboNavigatorEvent;
    import com.sulake.habbo.catalog.enum.HabboCatalogTrackingEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
    import com.sulake.habbo.help.enum.HabboHelpTrackingEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import flash.events.TimerEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
    import com.sulake.habbo.communication.enum.HabboCommunicationEvent;
    import com.sulake.habbo.communication.enum.HabboHotelViewEvent;
    import flash.events.Event;
    import com.sulake.habbo.window.enum.HabboWindowTrackingEvent;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.system.System;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;
    import com.sulake.core.runtime.events.ErrorEvent;
    import com.sulake.habbo.catalog.navigation.events.CatalogPageOpenedEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import flash.utils.getTimer;
    import com.sulake.iid.*;

    public class HabboTracking extends Component implements IHabboTracking, IUpdateReceiver 
    {

        private static const var_40:uint = 11;
        private static var _instance:HabboTracking;

        private var _configuration:IHabboConfigurationManager;
        private var _localization:IHabboLocalizationManager;
        private var _communication:IHabboCommunicationManager;
        private var var_4906:IAdManager;
        private var _catalog:IHabboCatalog;
        private var _navigator:IHabboNavigator;
        private var var_3071:IHabboInventory;
        private var var_5132:IHabboFriendList;
        private var var_5133:IHabboWindowManager;
        private var var_3317:IHabboToolbar;
        private var var_4024:IHabboHelp;
        private var var_5131:Array;
        private var _crashed:Boolean = false;
        private var var_5134:PerformanceTracker = null;
        private var var_5135:FramerateTracker = null;
        private var var_5136:LatencyTracker = null;
        private var var_5137:LagWarningLogger = null;
        private var var_5138:ToolbarClickTracker = null;
        private var _roomEngine:IRoomEngine = null;
        private var _connection:IConnection = null;
        private var var_5139:Boolean = false;
        private var var_5140:int = -1;
        private var var_5141:int = 0;
        private var var_5142:int = 0;
        private var var_5143:Timer;
        private var var_5144:int = 0;

        public function HabboTracking(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            if (_instance == null)
            {
                _instance = this;
            };
            super(param1, param2, param3);
            this.var_5134 = new PerformanceTracker();
            this.var_5135 = new FramerateTracker();
            this.var_5136 = new LatencyTracker();
            this.var_5137 = new LagWarningLogger();
            this.var_5138 = new ToolbarClickTracker(this);
            this.var_5131 = new Array(var_40);
            var _loc4_:uint;
            while (_loc4_ < var_40)
            {
                this.var_5131[_loc4_] = 0;
                _loc4_++;
            };
            var _loc5_:IContext = param1.root;
            if (_loc5_ != null)
            {
                _loc5_.events.addEventListener(Component.COMPONENT_EVENT_ERROR, this.onError);
                _loc5_.events.addEventListener(Component.COMPONENT_EVENT_RUNNING, this.onCoreRunning);
                ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_41, new Date().getTime().toString());
                ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_42, ((ExternalInterface.available) ? ExternalInterface.call("window.navigator.userAgent.toString") : "unknown"));
                ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_43, Capabilities.serverString);
                ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_44, String(false));
                ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_45, String(0));
            };
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboNavigator(), this.onNavigatorReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDHabboFriendList(), this.onFriendlistReady);
            queueInterface(new IIDHabboHelp(), this.onHelpReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDHabboAdManager(), this.onAdManagerReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            registerUpdateReceiver(this, 1);
        }

        public static function getInstance():HabboTracking
        {
            return (_instance);
        }


        override public function dispose():void
        {
            if (!disposed)
            {
                if (_instance == this)
                {
                    _instance = null;
                };
                if (this._communication)
                {
                    this._communication.release(new IIDHabboCommunicationManager());
                    this._communication = null;
                };
                if (this._configuration)
                {
                    this._configuration.release(new IIDHabboConfigurationManager());
                    this._configuration = null;
                };
                if (this._localization)
                {
                    this._localization.release(new IIDHabboLocalizationManager());
                    this._localization = null;
                };
                if (this.var_5133)
                {
                    this.var_5133.release(new IIDHabboWindowManager());
                    this.var_5133 = null;
                };
                if (this.var_4906)
                {
                    this.var_4906.release(new IIDHabboAdManager());
                    this.var_4906 = null;
                };
                if (this._navigator)
                {
                    if (!this._navigator.disposed)
                    {
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH, this.onNavigatorTrackingEvent);
                        this._navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED, this.onRoomSettingsTrackingEvent);
                        this._navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT, this.onRoomSettingsTrackingEvent);
                        this._navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED, this.onRoomSettingsTrackingEvent);
                        this._navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS, this.onRoomSettingsTrackingEvent);
                        this._navigator.events.removeEventListener(HabboNavigatorEvent.var_46, this.onZoomToggle);
                    };
                    this._navigator.release(new IIDHabboNavigator());
                    this._navigator = null;
                };
                if (this._catalog)
                {
                    if (!this._catalog.disposed)
                    {
                        this._catalog.events.removeEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_CLOSE, this.onCatalogTrackingEvent);
                        this._catalog.events.removeEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_OPEN, this.onCatalogTrackingEvent);
                    };
                    this._catalog.release(new IIDHabboCatalog());
                    this._catalog = null;
                };
                if (this.var_3071)
                {
                    if (!this.var_3071.disposed)
                    {
                        Component(this.var_3071).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED, this.onInvetoryTrackingEvent);
                        Component(this.var_3071).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI, this.onInvetoryTrackingEvent);
                        Component(this.var_3071).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS, this.onInvetoryTrackingEvent);
                        Component(this.var_3071).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_BADGES, this.onInvetoryTrackingEvent);
                        Component(this.var_3071).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS, this.onInvetoryTrackingEvent);
                        Component(this.var_3071).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING, this.onInvetoryTrackingEvent);
                    };
                    this.var_3071.release(new IIDHabboInventory());
                    this.var_3071 = null;
                };
                if (this.var_5132)
                {
                    if (!this.var_5132.disposed)
                    {
                        Component(this.var_5132).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED, this.onFriendlistTrackingEvent);
                        Component(this.var_5132).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS, this.onFriendlistTrackingEvent);
                        Component(this.var_5132).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH, this.onFriendlistTrackingEvent);
                        Component(this.var_5132).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST, this.onFriendlistTrackingEvent);
                        Component(this.var_5132).events.removeEventListener(HabboFriendListTrackingEvent.var_47, this.onFriendlistTrackingEvent);
                    };
                    this.var_5132.release(new IIDHabboFriendList());
                    this.var_5132 = null;
                };
                if (this.var_4024)
                {
                    if (!this.var_4024.disposed)
                    {
                        this.var_4024.events.removeEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED, this.onHelpTrackingEvent);
                        this.var_4024.events.removeEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT, this.onHelpTrackingEvent);
                    };
                    this.var_4024.release(new IIDHabboHelp());
                    this.var_4024 = null;
                };
                if (this.var_3317)
                {
                    if (!this.var_3317.disposed)
                    {
                        this.var_3317.events.removeEventListener(HabboToolbarEvent.var_48, this.onToolbarClick);
                    };
                    this.var_3317.release(new IIDHabboToolbar());
                    this.var_3317 = null;
                };
                if (this._roomEngine)
                {
                    if (!this._roomEngine.disposed)
                    {
                        this._roomEngine.events.removeEventListener(RoomObjectRoomAdEvent.var_49, this.onRoomAdClick);
                        this._roomEngine.events.removeEventListener(RoomEngineEvent.var_50, this.onRoomAction);
                        this._roomEngine.events.removeEventListener(RoomEngineEvent.var_51, this.onRoomAction);
                    };
                    this._roomEngine.release(new IIDRoomEngine());
                    this._roomEngine = null;
                };
                removeUpdateReceiver(this);
                if (this.var_5134 != null)
                {
                    this.var_5134.dispose();
                    this.var_5134 = null;
                };
                if (this.var_5135 != null)
                {
                    this.var_5135.dispose();
                    this.var_5135 = null;
                };
                if (this.var_5136 != null)
                {
                    this.var_5136.dispose();
                    this.var_5136 = null;
                };
                if (this.var_5138)
                {
                    this.var_5138.dispose();
                    this.var_5138 = null;
                };
                if (this.var_5143)
                {
                    this.var_5143.stop();
                    this.var_5143.removeEventListener(TimerEvent.TIMER, this.onRoomActionTimerEvent);
                    this.var_5143 = null;
                };
                this._connection = null;
                super.dispose();
            };
        }

        private function setErrorContextFlag(param1:uint, param2:uint):void
        {
            this.var_5131[param2] = param1;
        }

        private function onConfigurationReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._configuration = IHabboConfigurationManager(param2);
            if (this._configuration)
            {
                if (this.var_5136 != null)
                {
                    this.var_5136.configuration = this._configuration;
                };
                if (this.var_5134 != null)
                {
                    this.var_5134.configuration = this._configuration;
                };
                this.setErrorContextFlag(1, 0);
                this.trackLoginStep(HabboLoginTrackingStep.var_52);
                if (this._configuration)
                {
                    if (this.var_5137 != null)
                    {
                        this.var_5137.configure(this._configuration);
                    };
                    if (this.var_5135 != null)
                    {
                        this.var_5135.configure(this._configuration);
                    };
                    if (this.var_5138 != null)
                    {
                        this.var_5138.configure(this._configuration);
                    };
                };
            };
        }

        private function onLocalizationReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._localization = IHabboLocalizationManager(param2);
            this.setErrorContextFlag(1, 1);
            this.trackLoginStep(HabboLoginTrackingStep.var_53);
        }

        private function onCommunicationReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._communication = IHabboCommunicationManager(param2);
            if (this._communication != null)
            {
                this._communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthOK));
                this._communication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEnter));
                this._communication.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(this.onAchievementNotification));
                this._connection = this._communication.getHabboMainConnection(this.onConnectionReady);
                if (this._connection != null)
                {
                    this.onConnectionReady(this._connection);
                };
            };
            Component(context).events.addEventListener(HabboCommunicationEvent.INIT, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboCommunicationEvent.var_54, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboCommunicationEvent.var_55, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboCommunicationEvent.var_56, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboCommunicationEvent.var_57, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboCommunicationEvent.var_58, this.onConnectionEvent);
            Component(context).events.addEventListener(HabboHotelViewEvent.var_59, this.onHotelViewEvent);
            Component(context).events.addEventListener(HabboHotelViewEvent.var_60, this.onHotelViewEvent);
            Component(context).events.addEventListener(HabboHotelViewEvent.var_61, this.onHotelViewEvent);
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
                if (this.var_5134 != null)
                {
                    this.var_5134.connection = param1;
                };
                if (this.var_5136 != null)
                {
                    this.var_5136.communication = this._communication;
                    this.var_5136.connection = param1;
                };
                if (this.var_5137 != null)
                {
                    this.var_5137.connection = param1;
                };
            };
        }

        private function onHotelViewEvent(param1:Event):void
        {
            if (param1.type == HabboHotelViewEvent.var_59)
            {
                this.trackLoginStep(HabboLoginTrackingStep.var_62);
            }
            else
            {
                if (param1.type == HabboHotelViewEvent.var_61)
                {
                    this.trackLoginStep(HabboLoginTrackingStep.var_63);
                }
                else
                {
                    if (param1.type == HabboHotelViewEvent.var_60)
                    {
                        this.trackLoginStep(HabboLoginTrackingStep.var_64);
                    };
                };
            };
        }

        private function onConnectionEvent(param1:Event):void
        {
            switch (param1.type)
            {
                case HabboCommunicationEvent.INIT:
                    this.trackLoginStep(HabboLoginTrackingStep.var_65);
                    break;
                case HabboCommunicationEvent.var_54:
                    this.trackLoginStep(HabboLoginTrackingStep.var_66, String(this._communication.port));
                    break;
                case HabboCommunicationEvent.var_55:
                    this.trackLoginStep(HabboLoginTrackingStep.var_55);
                    break;
                case HabboCommunicationEvent.var_57:
                    this.trackLoginStep(HabboLoginTrackingStep.var_57);
                    break;
                case HabboCommunicationEvent.var_56:
                    this.setErrorContextFlag(2, 0);
                    this.trackLoginStep(HabboLoginTrackingStep.var_56);
                    break;
                case HabboCommunicationEvent.var_58:
                    this.setErrorContextFlag(3, 0);
                    this.trackLoginStep(HabboLoginTrackingStep.var_58);
                    if (this.var_5136 != null)
                    {
                        this.var_5136.init();
                    };
                    break;
            };
            if (this._communication)
            {
                Component(context).events.removeEventListener(param1.type, this.onConnectionEvent);
            };
        }

        private function onWindowManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_5133 = IHabboWindowManager(param2);
            if (this.var_5133)
            {
                Component(context).events.addEventListener(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_INPUT, this.onWindowEvent);
                Component(context).events.addEventListener(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_RENDER, this.onWindowEvent);
                Component(context).events.addEventListener(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_SLEEP, this.onWindowEvent);
            };
        }

        private function onWindowEvent(param1:Event):void
        {
            if (param1.type == HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_SLEEP)
            {
                this.setErrorContextFlag(0, 3);
            }
            else
            {
                if (param1.type == HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_RENDER)
                {
                    this.setErrorContextFlag(1, 3);
                }
                else
                {
                    if (param1.type == HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_INPUT)
                    {
                        this.setErrorContextFlag(2, 3);
                    };
                };
            };
        }

        private function onError(param1:ErrorEvent):void
        {
            var _loc2_:String;
            var _loc3_:URLRequest;
            var _loc4_:URLVariables;
            var _loc5_:Array;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:String;
            var _loc9_:uint;
            if (((param1.critical) && (!(this._crashed))))
            {
                this._crashed = true;
                ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_7, new Date().getTime().toString());
                if (this._configuration)
                {
                    if (this._configuration.keyExists("client.fatal.error.url"))
                    {
                        _loc2_ = this._configuration.getKey("client.fatal.error.url");
                        _loc3_ = new URLRequest(_loc2_);
                        _loc4_ = new URLVariables();
                        _loc5_ = ErrorReportStorage.getParameterNames();
                        _loc6_ = _loc5_.length;
                        _loc7_ = 0;
                        while (_loc7_ < _loc6_)
                        {
                            _loc4_[_loc5_[_loc7_]] = ErrorReportStorage.getParameter(_loc5_[_loc7_]);
                            _loc7_++;
                        };
                        _loc8_ = "";
                        for each (_loc9_ in this.var_5131)
                        {
                            _loc8_ = (_loc8_ + String(_loc9_));
                        };
                        _loc4_[HabboErrorVariableEnum.var_8] = _loc8_;
                        if (this.var_5134 != null)
                        {
                            _loc4_[HabboErrorVariableEnum.var_9] = this.var_5134.flashVersion;
                            _loc4_[HabboErrorVariableEnum.var_10] = this.var_5134.averageUpdateInterval;
                        };
                        ErrorReportStorage.addDebugData("Flash memory usage", (("Memory usage: " + Math.round((System.totalMemory / (0x0400 * 0x0400)))) + " MB"));
                        _loc4_[HabboErrorVariableEnum.var_11] = ErrorReportStorage.getDebugData();
                        _loc3_.data = _loc4_;
                        _loc3_.method = URLRequestMethod.POST;
                        navigateToURL(_loc3_, "_self");
                    };
                };
            };
            this.logError(context.root.getLastErrorMessage());
        }

        private function onCoreRunning(param1:Event):void
        {
            this.trackLoginStep(HabboLoginTrackingStep.var_67);
            if (((context) && (context.root)))
            {
                context.root.events.removeEventListener(HabboLoginTrackingStep.var_67, this.onCoreRunning);
            };
        }

        private function onNavigatorReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._navigator = (IHabboNavigator(param2) as IHabboNavigator);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH, this.onNavigatorTrackingEvent);
            this._navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED, this.onRoomSettingsTrackingEvent);
            this._navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT, this.onRoomSettingsTrackingEvent);
            this._navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED, this.onRoomSettingsTrackingEvent);
            this._navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS, this.onRoomSettingsTrackingEvent);
            this._navigator.events.addEventListener(HabboNavigatorEvent.var_46, this.onZoomToggle);
        }

        private function onNavigatorTrackingEvent(param1:Event):void
        {
            switch (param1.type)
            {
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED:
                    this.setErrorContextFlag(0, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS:
                    this.setErrorContextFlag(1, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS:
                    this.setErrorContextFlag(2, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME:
                    this.setErrorContextFlag(3, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL:
                    this.setErrorContextFlag(4, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH:
                    this.setErrorContextFlag(5, 4);
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS:
                    this.legacyTrackGoogle("navigator", "latest_events");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES:
                    this.legacyTrackGoogle("navigator", "my_favorites");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS:
                    this.legacyTrackGoogle("navigator", "my_friends_rooms");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY:
                    this.legacyTrackGoogle("navigator", "my_history");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS:
                    this.legacyTrackGoogle("navigator", "my_rooms");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS:
                    this.legacyTrackGoogle("navigator", "official_rooms");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS:
                    this.legacyTrackGoogle("navigator", "popular_rooms");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE:
                    this.legacyTrackGoogle("navigator", "rooms_where_my_friends_are");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE:
                    this.legacyTrackGoogle("navigator", "highest_score");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH:
                    this.legacyTrackGoogle("navigator", "tag_search");
                    return;
                case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH:
                    this.legacyTrackGoogle("navigator", "text_search");
                    return;
            };
        }

        private function onRoomSettingsTrackingEvent(param1:Event):void
        {
            switch (param1.type)
            {
                case HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED:
                    this.setErrorContextFlag(0, 7);
                    return;
                case HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT:
                    this.setErrorContextFlag(1, 7);
                    return;
                case HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED:
                    this.setErrorContextFlag(2, 7);
                    return;
            };
        }

        private function onInventoryReady(param1:IID, param2:IUnknown):void
        {
            this.var_3071 = (param2 as IHabboInventory);
            Component(this.var_3071).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED, this.onInvetoryTrackingEvent);
            Component(this.var_3071).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI, this.onInvetoryTrackingEvent);
            Component(this.var_3071).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS, this.onInvetoryTrackingEvent);
            Component(this.var_3071).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_BADGES, this.onInvetoryTrackingEvent);
            Component(this.var_3071).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS, this.onInvetoryTrackingEvent);
            Component(this.var_3071).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING, this.onInvetoryTrackingEvent);
        }

        private function onInvetoryTrackingEvent(param1:Event):void
        {
            switch (param1.type)
            {
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED:
                    this.setErrorContextFlag(0, 5);
                    return;
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI:
                    this.setErrorContextFlag(1, 5);
                    return;
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS:
                    this.setErrorContextFlag(2, 5);
                    return;
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_BADGES:
                    this.setErrorContextFlag(3, 5);
                    return;
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS:
                    this.setErrorContextFlag(4, 5);
                    return;
                case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING:
                    this.setErrorContextFlag(5, 5);
                    return;
            };
        }

        private function onCatalogReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._catalog = (IHabboCatalog(param2) as IHabboCatalog);
            this._catalog.events.addEventListener(CatalogPageOpenedEvent.CATALOG_PAGE_OPENED, this.onCatalogPageOpened);
            this._catalog.events.addEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_OPEN, this.onCatalogTrackingEvent);
            this._catalog.events.addEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_CLOSE, this.onCatalogTrackingEvent);
        }

        private function onAchievementNotification(param1:HabboAchievementNotificationMessageEvent):void
        {
            var _loc2_:HabboAchievementNotificationMessageParser = param1.getParser();
            this.legacyTrackGoogle("achievement", "achievement", [_loc2_.data.badgeCode]);
        }

        private function onCatalogPageOpened(param1:CatalogPageOpenedEvent):void
        {
            this.legacyTrackGoogle("catalogue", "page", [param1.pageLocalization]);
        }

        private function onCatalogTrackingEvent(param1:Event):void
        {
            switch (param1.type)
            {
                case HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_OPEN:
                    this.setErrorContextFlag(1, 9);
                    return;
                case HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_CLOSE:
                    this.setErrorContextFlag(0, 9);
                    return;
            };
        }

        private function onFriendlistReady(param1:IID, param2:IUnknown):void
        {
            this.var_5132 = (param2 as IHabboFriendList);
            Component(this.var_5132).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED, this.onFriendlistTrackingEvent);
            Component(this.var_5132).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS, this.onFriendlistTrackingEvent);
            Component(this.var_5132).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH, this.onFriendlistTrackingEvent);
            Component(this.var_5132).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST, this.onFriendlistTrackingEvent);
            Component(this.var_5132).events.addEventListener(HabboFriendListTrackingEvent.var_47, this.onFriendlistTrackingEvent);
        }

        private function onFriendlistTrackingEvent(param1:Event):void
        {
            switch (param1.type)
            {
                case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED:
                    this.setErrorContextFlag(0, 6);
                    return;
                case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS:
                    this.setErrorContextFlag(1, 6);
                    return;
                case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH:
                    this.setErrorContextFlag(2, 6);
                    return;
                case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST:
                    this.setErrorContextFlag(3, 6);
                    return;
                case HabboFriendListTrackingEvent.var_47:
                    this.setErrorContextFlag(4, 6);
                    return;
            };
        }

        private function onHelpReady(param1:IID, param2:IUnknown):void
        {
            this.var_4024 = (param2 as IHabboHelp);
            this.var_4024.events.addEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED, this.onHelpTrackingEvent);
            this.var_4024.events.addEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT, this.onHelpTrackingEvent);
        }

        private function onHelpTrackingEvent(param1:Event):void
        {
            switch (param1.type)
            {
                case HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED:
                    this.setErrorContextFlag(0, 10);
                    return;
                case HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT:
                    this.setErrorContextFlag(1, 10);
                    return;
            };
        }

        private function onAuthOK(param1:IMessageEvent):void
        {
            this.legacyTrackGoogle("authentication", "authok");
        }

        private function onRoomEnter(param1:IMessageEvent):void
        {
            if (!this.var_5139)
            {
                this.trackLoginStep(HabboLoginTrackingStep.var_68);
                this.var_5139 = true;
            };
            var _loc2_:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(param1).getParser();
            if (_loc2_.privateRoom)
            {
                ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_45, String(_loc2_.guestRoomId));
                ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_44, String(true));
                this.legacyTrackGoogle("navigator", "private", [_loc2_.guestRoomId]);
            }
            else
            {
                if (_loc2_.publicSpace != null)
                {
                    if (_loc2_.publicSpace.worldId == 0)
                    {
                        this.legacyTrackGoogle("navigator", "public", [_loc2_.publicSpace.unitPropertySet]);
                    }
                    else
                    {
                        this.legacyTrackGoogle("navigator", "public", [((_loc2_.publicSpace.unitPropertySet + "/") + _loc2_.publicSpace.worldId)]);
                    };
                };
            };
        }

        private function onRoomLeave(param1:CloseConnectionMessageEvent):void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_44, String(false));
        }

        private function onRoomEngineReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._roomEngine = (param2 as IRoomEngine);
            if (this._roomEngine == null)
            {
                return;
            };
            Component(this._roomEngine).events.addEventListener(RoomObjectRoomAdEvent.var_49, this.onRoomAdClick);
            Component(this._roomEngine).events.addEventListener(RoomEngineEvent.var_50, this.onRoomAction);
            Component(this._roomEngine).events.addEventListener(RoomEngineEvent.var_51, this.onRoomAction);
        }

        private function onAdManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_4906 = (param2 as IAdManager);
            this.var_4906.events.addEventListener(AdEvent.var_69, this.onRoomAdLoad);
        }

        private function onToolbarReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_3317 = (param2 as IHabboToolbar);
            this.var_3317.events.addEventListener(HabboToolbarEvent.var_48, this.onToolbarClick);
        }

        private function onRoomAdLoad(param1:AdEvent):void
        {
            this.legacyTrackGoogle("room_ad", "show", [this.getAliasFromAdTechUrl(param1.clickUrl)]);
        }

        private function onRoomAdClick(param1:RoomObjectRoomAdEvent):void
        {
            this.legacyTrackGoogle("room_ad", "click", [this.getAliasFromAdTechUrl(param1.clickUrl)]);
        }

        private function getAliasFromAdTechUrl(param1:String):String
        {
            var _loc2_:Array = param1.match(/;alias=([^;]+)/);
            if (((!(_loc2_ == null)) && (_loc2_.length > 1)))
            {
                return (_loc2_[1]);
            };
            return ("unknown");
        }

        private function onRoomAction(param1:RoomEngineEvent):void
        {
            if (param1.type == RoomEngineEvent.var_50)
            {
                if (this.var_5144 < 1)
                {
                    if (!this.var_5143)
                    {
                        this.var_5143 = new Timer((60 * 1000), 1);
                        this.var_5143.addEventListener(TimerEvent.TIMER, this.onRoomActionTimerEvent);
                        this.var_5143.start();
                    };
                };
            }
            else
            {
                if (param1.type == RoomEngineEvent.var_51)
                {
                    if (this.var_5143)
                    {
                        this.var_5143.removeEventListener(TimerEvent.TIMER, this.onRoomActionTimerEvent);
                        this.var_5143.stop();
                        this.var_5143 = null;
                    };
                };
            };
        }

        private function onRoomActionTimerEvent(param1:TimerEvent):void
        {
            var _loc2_:String;
            var _loc3_:int;
            var _loc4_:int;
            if (!disposed)
            {
                if (this._connection)
                {
                    if (this.var_5135)
                    {
                        _loc2_ = null;
                        if (this._roomEngine)
                        {
                            _loc3_ = this._roomEngine.getRoomObjectCount(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
                            _loc4_ = (this._roomEngine.getRoomObjectCount(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectCategoryEnum.var_70) + this._roomEngine.getRoomObjectCount(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectCategoryEnum.var_71));
                            _loc2_ = ((("Avatars: " + _loc3_) + ", Objects: ") + _loc4_);
                        };
                        this.trackEventLog("Performance", "fps", String(this.var_5135.frameRate), _loc2_);
                        this.var_5144++;
                    };
                };
            };
        }

        private function onToolbarClick(param1:HabboToolbarEvent):void
        {
            if (this.var_5138)
            {
                this.var_5138.track(param1.iconName);
            };
        }

        private function onZoomToggle(param1:HabboNavigatorEvent):void
        {
            if (this.var_5138)
            {
                this.var_5138.track(param1.type);
            };
        }

        public function legacyTrackGoogle(param1:String, param2:String, param3:Array=null):void
        {
            Logger.log((((((("legacyTrackGoogle(" + param1) + ", ") + param2) + ", ") + param3) + ")"));
            if (ExternalInterface.available)
            {
                ExternalInterface.call("FlashExternalInterface.legacyTrack", param1, param2, ((param3 == null) ? [] : param3));
            }
            else
            {
                Logger.log("com.sulake.habbo.tracking: ExternalInterface is not available, tracking is disabled");
            };
        }

        public function trackGoogle(param1:String, param2:String, param3:int=-1):void
        {
            Logger.log((((((("trackGoogle(" + param1) + ", ") + param2) + ", ") + param3) + ")"));
            if (ExternalInterface.available)
            {
                ExternalInterface.call("FlashExternalInterface.track", param1, param2, param3);
            }
            else
            {
                Logger.log("com.sulake.habbo.tracking: ExternalInterface is not available, tracking is disabled");
            };
        }

        public function trackLoginStep(param1:String, param2:String=null):void
        {
            if (((!(this._configuration == null)) && (!(Boolean(this._configuration.getKey("processlog.enabled"))))))
            {
                return;
            };
            Logger.log(("* Track Login Step: " + param1));
            if (ExternalInterface.available)
            {
                if (param2 != null)
                {
                    ExternalInterface.call("FlashExternalInterface.logLoginStep", param1, param2);
                }
                else
                {
                    ExternalInterface.call("FlashExternalInterface.logLoginStep", param1);
                };
            }
            else
            {
                Logger.log("HabboMain: ExternalInterface is not available, tracking is disabled");
            };
        }

        public function trackEventLog(param1:String, param2:String, param3:String, param4:String="", param5:int=0):void
        {
            if (((this._connection) && (this._connection.connected)))
            {
                this._connection.send(new EventLogMessageComposer(param1, param2, param3, param4, param5));
            };
        }

        public function logError(param1:String):void
        {
            Logger.log((("logError(" + param1) + ")"));
            if (ExternalInterface.available)
            {
                ExternalInterface.call("FlashExternalInterface.logError", param1);
            }
            else
            {
                Logger.log("com.sulake.habbo.tracking: ExternalInterface is not available, tracking is disabled");
            };
        }

        public function chatLagDetected(param1:int):void
        {
            this.var_5137.chatLagDetected(param1);
        }

        public function update(param1:uint):void
        {
            var _loc2_:int = getTimer();
            if (((this.var_5140 > -1) && (_loc2_ < this.var_5140)))
            {
                this.var_5141++;
                ErrorReportStorage.addDebugData("Invalid time counter", ("Invalid times: " + this.var_5141));
            };
            if (((this.var_5140 > -1) && ((_loc2_ - this.var_5140) > (15 * 1000))))
            {
                this.var_5142++;
                ErrorReportStorage.addDebugData("Time leap counter", ("Time leaps: " + this.var_5142));
            };
            this.var_5140 = _loc2_;
            if (this.var_5134 != null)
            {
                this.var_5134.update(param1, this.var_5140);
            };
            if (this.var_5136 != null)
            {
                this.var_5136.update(param1, this.var_5140);
            };
            if (this.var_5135 != null)
            {
                this.var_5135.trackUpdate(param1, this, this.var_5140);
            };
            if (this.var_5137 != null)
            {
                this.var_5137.update(this.var_5140);
            };
        }


    }
}