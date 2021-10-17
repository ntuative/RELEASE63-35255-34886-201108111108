package com.sulake.habbo.session
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import flash.utils.Dictionary;
    import com.sulake.habbo.session.product.ProductDataParser;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.session.furniture.FurnitureDataParser;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.session.facebook.FaceBookSession;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.AvailabilityStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.session.furniture.IFurniDataListener;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
    import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;
    import com.sulake.habbo.session.events.UserNameUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.availability.AvailabilityStatusMessageParser;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.RespectUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.pets.RespectPetMessageComposer;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IConfirmDialog;
    import com.sulake.habbo.session.product.IProductDataListener;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.ChatMessageComposer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.iid.*;

    public class SessionDataManager extends Component implements ISessionDataManager 
    {

        private var _communication:IHabboCommunicationManager;
        private var _windowManager:IHabboWindowManager;
        private var var_3318:IRoomSessionManager;
        private var _id:int;
        private var _name:String;
        private var var_2994:String;
        private var var_2938:String;
        private var _realName:String;
        private var var_3689:int = 0;
        private var var_3690:int = 0;
        private var var_3691:int = 0;
        private var var_5007:Array;
        private var var_5008:Boolean;
        private var var_5009:Boolean;
        private var var_3305:Dictionary;
        private var var_5010:ProductDataParser;
        private var var_4979:Map;
        private var _wallItems:Map;
        private var var_5011:Map;
        private var var_5012:FurnitureDataParser;
        private var var_5013:UserTagManager;
        private var var_5014:BadgeImageManager;
        private var var_5015:HabboGroupInfoManager;
        private var var_5016:IgnoredUsersManager;
        private var _configuration:IHabboConfigurationManager;
        private var _localization:IHabboLocalizationManager;
        private var var_5017:Boolean = false;
        private var var_5018:Array;
        private var var_5019:Array;
        private var _clubLevel:int;
        private var var_3693:int;
        private var var_5020:FaceBookSession;

        public function SessionDataManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this.var_5007 = [];
            this.var_5013 = new UserTagManager(events);
            this.var_5015 = new HabboGroupInfoManager(this, events);
            this.var_5016 = new IgnoredUsersManager(this);
            this.var_5020 = new FaceBookSession();
            this.var_3305 = new Dictionary();
            this.var_5018 = [];
            this.var_5019 = [];
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onHabboCommunicationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
        }

        override public function dispose():void
        {
            if (this.var_4979)
            {
                this.var_4979.dispose();
                this.var_4979 = null;
            };
            if (this.var_5011)
            {
                this.var_5011.dispose();
                this.var_5011 = null;
            };
            if (this._communication)
            {
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._windowManager)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this.var_3318)
            {
                this.var_3318.release(new IIDHabboRoomSessionManager());
                this.var_3318 = null;
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
            this.var_5019 = null;
            if (this.var_5012)
            {
                this.var_5012.removeEventListener(FurnitureDataParser.var_444, this.onFurnitureReady);
                this.var_5012.dispose();
                this.var_5012 = null;
            };
            if (this.var_5010)
            {
                this.var_5010.removeEventListener(ProductDataParser.var_444, this.onProductsReady);
                this.var_5010.dispose();
                this.var_5010 = null;
            };
            if (this.var_5020)
            {
                this.var_5020.dispose();
                this.var_5020 = null;
            };
            super.dispose();
        }

        private function initBadgeImageManager():void
        {
            if (this.var_5014 != null)
            {
                return;
            };
            if (((this._configuration == null) || (this._localization == null)))
            {
                return;
            };
            this.var_5014 = new BadgeImageManager(assets, events, this._configuration, this._localization);
        }

        private function onWindowManagerReady(param1:IID, param2:IUnknown):void
        {
            this._windowManager = (param2 as IHabboWindowManager);
        }

        private function onHabboCommunicationReady(param1:IID, param2:IUnknown):void
        {
            this._communication = (param2 as IHabboCommunicationManager);
            if (this._communication == null)
            {
                return;
            };
            this._communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(this.onUserRights));
            this._communication.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObject));
            this._communication.addHabboConnectionMessageEvent(new UserChangeMessageEvent(this.onUserChange));
            this._communication.addHabboConnectionMessageEvent(new UserNameChangedMessageEvent(this.onUserNameChange));
            this._communication.addHabboConnectionMessageEvent(new ChangeUserNameResultMessageEvent(this.onChangeUserNameResult));
            this._communication.addHabboConnectionMessageEvent(new AvailabilityStatusMessageEvent(this.onAvailabilityStatus));
            this._communication.addHabboConnectionMessageEvent(new PetRespectFailedEvent(this.onPetRespectFailed));
            this._communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
            this._communication.addHabboConnectionMessageEvent((new RoomReadyMessageEvent(this.onRoomReady) as IMessageEvent));
            this.var_5013.communication = this._communication;
            this.var_5015.communication = this._communication;
            this.var_5020.communication = this._communication;
            this.var_5016.registerMessageEvents();
        }

        private function onConfigurationReady(param1:IID, param2:IUnknown):void
        {
            var _loc3_:String;
            if (param2 == null)
            {
                return;
            };
            this._configuration = (param2 as IHabboConfigurationManager);
            this.initBadgeImageManager();
            if (!this.var_5012)
            {
                this.var_4979 = new Map();
                this._wallItems = new Map();
                this.var_5011 = new Map();
                this.var_5012 = new FurnitureDataParser(this.var_4979, this._wallItems, this.var_5011, this._localization);
                this.var_5012.addEventListener(FurnitureDataParser.var_444, this.onFurnitureReady);
                if (this._configuration.keyExists("furnidata.load.url"))
                {
                    _loc3_ = this._configuration.getKey("furnidata.load.url");
                    this.var_5012.loadData(_loc3_);
                };
            };
        }

        private function onLocalizationReady(param1:IID, param2:IUnknown):void
        {
            if (param2 == null)
            {
                return;
            };
            this._localization = (param2 as IHabboLocalizationManager);
            this.initBadgeImageManager();
            if (this.var_5012)
            {
                this.var_5012.localization = this._localization;
                this.var_5012.registerFurnitureLocalizations();
            };
        }

        private function onRoomSessionManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_3318 = (param2 as IRoomSessionManager);
        }

        private function onFurnitureReady(param1:Event=null):void
        {
            var _loc2_:IFurniDataListener;
            this.var_5012.removeEventListener(FurnitureDataParser.var_444, this.onFurnitureReady);
            for each (_loc2_ in this.var_5019)
            {
                _loc2_.furniDataReady();
            };
            this.var_5019 = [];
        }

        private function onUserRights(param1:IMessageEvent):void
        {
            var _loc2_:UserRightsMessageEvent = UserRightsMessageEvent(param1);
            this._clubLevel = _loc2_.clubLevel;
            this.var_3693 = _loc2_.securityLevel;
        }

        private function onUserObject(param1:IMessageEvent):void
        {
            var _loc2_:UserObjectEvent = (param1 as UserObjectEvent);
            var _loc3_:UserObjectMessageParser = _loc2_.getParser();
            this._id = _loc3_.id;
            this._name = _loc3_.name;
            this.var_3689 = _loc3_.respectTotal;
            this.var_3690 = _loc3_.respectLeft;
            this.var_3691 = _loc3_.petRespectLeft;
            this.var_2994 = _loc3_.figure;
            this.var_2938 = _loc3_.sex;
            this._realName = _loc3_.realName;
            this.var_5016.initIgnoreList();
        }

        private function onUserChange(param1:IMessageEvent):void
        {
            var _loc2_:UserChangeMessageEvent = (param1 as UserChangeMessageEvent);
            if (_loc2_ == null)
            {
                return;
            };
            if (_loc2_.id == -1)
            {
                this.var_2994 = _loc2_.figure;
                this.var_2938 = _loc2_.sex;
                events.dispatchEvent(new HabboSessionFigureUpdatedEvent(this._id, this.var_2994, this.var_2938));
            };
        }

        private function onUserNameChange(param1:IMessageEvent):void
        {
            var _loc2_:UserNameChangedMessageEvent = (param1 as UserNameChangedMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:UserNameChangedMessageParser = _loc2_.getParser();
            if (_loc3_.webId == this._id)
            {
                this._name = _loc3_.newName;
                events.dispatchEvent(new UserNameUpdateEvent(this._name));
            };
        }

        private function onChangeUserNameResult(param1:ChangeUserNameResultMessageEvent):void
        {
            var _loc2_:ChangeUserNameResultMessageParser = param1.getParser();
            if (_loc2_.resultCode == ChangeUserNameResultMessageEvent.var_445)
            {
                events.dispatchEvent(new UserNameUpdateEvent(_loc2_.name));
            };
        }

        private function onAvailabilityStatus(param1:IMessageEvent):void
        {
            var _loc2_:AvailabilityStatusMessageParser = (param1 as AvailabilityStatusMessageEvent).getParser();
            if (_loc2_ == null)
            {
                return;
            };
            this.var_5008 = _loc2_.isOpen;
            this.var_5009 = _loc2_.onShutDown;
        }

        private function onPetRespectFailed(param1:PetRespectFailedEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            this.var_3691++;
        }

        private function onAuthenticationOK(param1:IMessageEvent):void
        {
            this.loadProductData();
        }

        public function get systemOpen():Boolean
        {
            return (this.var_5008);
        }

        public function get systemShutDown():Boolean
        {
            return (this.var_5009);
        }

        public function hasSecurity(param1:int):Boolean
        {
            return (this.var_3693 >= param1);
        }

        public function hasUserRight(param1:String, param2:int):Boolean
        {
            return (this._clubLevel >= param2);
        }

        public function get clubLevel():int
        {
            return (this._clubLevel);
        }

        public function get userId():int
        {
            return (this._id);
        }

        public function get userName():String
        {
            return (this._name);
        }

        public function get realName():String
        {
            return (this._realName);
        }

        public function get figure():String
        {
            return (this.var_2994);
        }

        public function get isAnyRoomController():Boolean
        {
            return (this.var_3693 >= SecurityLevelEnum.var_446);
        }

        public function getUserTags(param1:int):Array
        {
            return (this.var_5013.getTags(param1));
        }

        public function getBadgeImage(param1:String):BitmapData
        {
            return (this.var_5014.getBadgeImage(param1));
        }

        public function requestBadgeImage(param1:String):BitmapData
        {
            return (this.var_5014.getBadgeImage(param1, BadgeImageManager.var_447, false));
        }

        public function getBadgeImageWithInfo(param1:String):BadgeInfo
        {
            return (this.var_5014.getBadgeImageWithInfo(param1));
        }

        public function showGroupBadgeInfo(param1:int):void
        {
            if (this._configuration.getKey("groupBadgeInfo.enabled") == "false")
            {
                this._windowManager.alert("${group.inconstruction.title}", "${group.inconstruction.desc}", 0, this.onAlertClose);
            }
            else
            {
                this.send(new GetHabboGroupDetailsMessageComposer(param1));
            };
            this.send(new EventLogMessageComposer(GroupDetailsView.var_448, ("" + param1), "badge clicked"));
        }

        private function onAlertClose(param1:IAlertDialog, param2:WindowEvent):void
        {
            param1.dispose();
        }

        public function getGroupBadgeId(param1:int):String
        {
            return (this.var_5015.getBadgeId(param1));
        }

        public function send(param1:IMessageComposer):void
        {
            this._communication.getHabboMainConnection(null).send(param1);
        }

        public function getGroupBadgeImage(param1:String):BitmapData
        {
            return (this.var_5014.getBadgeImage(param1, BadgeImageManager.var_449));
        }

        public function get communication():IHabboCommunicationManager
        {
            return (this._communication);
        }

        public function isIgnored(param1:String):Boolean
        {
            return (this.var_5016.isIgnored(param1));
        }

        public function ignoreUser(param1:String):void
        {
            this.var_5016.ignoreUser(param1);
        }

        public function unignoreUser(param1:String):void
        {
            this.var_5016.unignoreUser(param1);
        }

        public function get respectLeft():int
        {
            return (this.var_3690);
        }

        public function get petRespectLeft():int
        {
            return (this.var_3691);
        }

        public function giveRespect(param1:int):void
        {
            if (((param1 < 0) || (this.var_3690 < 1)))
            {
                throw (new Error(("Failed to give respect to user: " + param1)));
            };
            this.send(new RespectUserMessageComposer(param1));
            this.var_3690 = (this.var_3690 - 1);
        }

        public function givePetRespect(param1:int):void
        {
            if (((param1 < 0) || (this.var_3691 < 1)))
            {
                throw (new Error(("Failed to give respect to pet: " + param1)));
            };
            this.send(new RespectPetMessageComposer(param1));
            this.var_3691 = (this.var_3691 - 1);
        }

        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }

        public function getProductData(param1:String):IProductData
        {
            if (!this.var_5017)
            {
                this.loadProductData();
            };
            return (this.var_3305[param1]);
        }

        public function getFloorItemData(param1:int):IFurnitureData
        {
            if (this.var_4979 == null)
            {
                return (null);
            };
            return (this.var_4979.getValue(param1.toString()));
        }

        public function getWallItemData(param1:int):IFurnitureData
        {
            if (this._wallItems == null)
            {
                return (null);
            };
            return (this._wallItems.getValue(param1.toString()));
        }

        public function getFloorItemDataByName(param1:String, param2:int=0):IFurnitureData
        {
            var _loc4_:int;
            if (this.var_5011 == null)
            {
                return (null);
            };
            var _loc3_:Array = this.var_5011.getValue(param1);
            if (((!(_loc3_ == null)) && (param2 <= (_loc3_.length - 1))))
            {
                _loc4_ = _loc3_[param2];
                return (this.getFloorItemData(_loc4_));
            };
            return (null);
        }

        public function getWallItemDataByName(param1:String, param2:int=0):IFurnitureData
        {
            var _loc4_:int;
            if (this.var_5011 == null)
            {
                return (null);
            };
            var _loc3_:Array = this.var_5011.getValue(param1);
            if (((!(_loc3_ == null)) && (param2 <= (_loc3_.length - 1))))
            {
                _loc4_ = _loc3_[param2];
                return (this.getWallItemData(_loc4_));
            };
            return (null);
        }

        public function openHabboHomePage(userId:int):void
        {
            var urlString:String;
            if (this._configuration != null)
            {
                urlString = this._configuration.getKey("link.format.userpage");
                urlString = urlString.replace("%ID%", String(userId));
                try
                {
                    HabboWebTools.navigateToURL(urlString, "habboMain");
                }
                catch(e:Error)
                {
                    Logger.log("Error occurred!");
                };
            };
        }

        public function pickAllFurniture(roomId:int, roomCategory:int):void
        {
            if (((this.var_3318 == null) || (this._windowManager == null)))
            {
                return;
            };
            var session:IRoomSession = this.var_3318.getSession(roomId, roomCategory);
            if (session == null)
            {
                return;
            };
            if (((session.isRoomOwner) || (this.isAnyRoomController)))
            {
                this._windowManager.confirm("${generic.alert.title}", "${room.confirm.pick_all}", 0, function (param1:IConfirmDialog, param2:WindowEvent):void
                {
                    param1.dispose();
                    if (param2.type == WindowEvent.var_131)
                    {
                        sendPickAllFurnitureMessage();
                    };
                });
            };
        }

        public function loadProductData(param1:IProductDataListener=null):Boolean
        {
            var _loc2_:String;
            if (this.var_5017)
            {
                return (true);
            };
            if (((param1) && (this.var_5018.indexOf(param1) == -1)))
            {
                this.var_5018.push(param1);
            };
            if (!this._configuration)
            {
                return (false);
            };
            if (this.var_5010 == null)
            {
                _loc2_ = this._configuration.getKey("productdata.load.url");
                this.var_5010 = new ProductDataParser(_loc2_, this.var_3305);
                this.var_5010.addEventListener(ProductDataParser.var_444, this.onProductsReady);
            };
            return (false);
        }

        private function onProductsReady(param1:Event):void
        {
            var _loc2_:IProductDataListener;
            this.var_5010.removeEventListener(ProductDataParser.var_444, this.onProductsReady);
            this.var_5017 = true;
            for each (_loc2_ in this.var_5018)
            {
                if (((!(_loc2_ == null)) && (!(_loc2_.disposed))))
                {
                    _loc2_.productDataReady();
                };
            };
            this.var_5018 = [];
        }

        private function onRoomReady(param1:IMessageEvent):void
        {
            var _loc2_:RoomReadyMessageEvent = (param1 as RoomReadyMessageEvent);
            if ((((_loc2_ == null) || (_loc2_.getParser() == null)) || (param1.connection == null)))
            {
                return;
            };
            var _loc3_:RoomReadyMessageParser = _loc2_.getParser();
            HabboWebTools.roomVisited(_loc3_.roomId);
        }

        private function sendPickAllFurnitureMessage():void
        {
            this.send(new ChatMessageComposer(":pickall"));
        }

        public function get roomSessionManager():IRoomSessionManager
        {
            return (this.var_3318);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get gender():String
        {
            return (this.var_2938);
        }

        public function getFurniData(param1:IFurniDataListener):Array
        {
            if (this.var_4979.length == 0)
            {
                if (this.var_5019.indexOf(param1) == -1)
                {
                    this.var_5019.push(param1);
                };
                return (null);
            };
            var _loc2_:Array = this.var_4979.getValues();
            return (_loc2_.concat(this._wallItems.getValues()));
        }

        public function getXmlWindow(name:String):IWindow
        {
            var asset:IAsset;
            var xmlAsset:XmlAsset;
            var window:IWindow;
            try
            {
                asset = assets.getAssetByName(name);
                xmlAsset = XmlAsset(asset);
                window = this._windowManager.buildFromXML(XML(xmlAsset.content));
            }
            catch(e:Error)
            {
            };
            return (window);
        }

        public function getButtonImage(param1:String):BitmapData
        {
            var _loc2_:String = param1;
            var _loc3_:IAsset = assets.getAssetByName(_loc2_);
            var _loc4_:BitmapDataAsset = BitmapDataAsset(_loc3_);
            var _loc5_:BitmapData = BitmapData(_loc4_.content);
            var _loc6_:BitmapData = new BitmapData(_loc5_.width, _loc5_.height, true, 0);
            _loc6_.draw(_loc5_);
            return (_loc6_);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }


    }
}