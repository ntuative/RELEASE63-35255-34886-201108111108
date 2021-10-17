package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarInfoEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserDataUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectNameEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetUserLocationMessage;
    import com.sulake.habbo.avatar.enum.AvatarEditorInstanceId;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;

    public class AvatarInfoWidget extends RoomWidgetBase implements IUpdateReceiver 
    {

        private static const var_1713:String = "use_minimized_own_avatar_menu";

        private var var_4007:Component;
        private var _configuration:IHabboConfigurationManager;
        private var _view:AvatarInfoView;
        private var _isInitialized:Boolean = false;
        private var var_5195:Boolean = false;
        private var var_5196:AvatarInfoData;
        private var var_5197:Boolean;
        private var var_5198:Boolean;
        private var var_5199:int = -1;
        private var var_5200:Boolean;
        private var var_5201:AvatarInfoView;
        private var var_5202:OwnAvatarMenuView;
        private var var_5203:AvatarMenuView;
        private var var_5204:Map;
        private var var_5205:Boolean = false;
        private var var_5206:Boolean = true;

        public function AvatarInfoWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboConfigurationManager, param5:IHabboLocalizationManager, param6:Component)
        {
            super(param1, param2, param3, param5);
            this.var_4007 = param6;
            this._configuration = param4;
            this.var_5196 = new AvatarInfoData();
            this.var_5197 = ((this._configuration.getBoolean("menu.avatar.enabled", false)) || (false));
            this.var_5198 = this._configuration.getBoolean("menu.own_avatar.enabled", false);
            this.var_5204 = new Map();
            this.handler.roomEngine.events.addEventListener(RoomEngineObjectEvent.var_384, this.onRoomObjectAdded);
            this.handler.roomEngine.events.addEventListener(RoomEngineObjectEvent.var_385, this.onRoomObjectRemoved);
            this.handler.container.inventory.events.addEventListener(HabboInventoryEffectsEvent.var_257, this.onEffectsChanged);
            this.handler.widget = this;
        }

        public function get handler():AvatarInfoWidgetHandler
        {
            return (var_1604 as AvatarInfoWidgetHandler);
        }

        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }

        public function set handlePetInfo(param1:Boolean):void
        {
            this.var_5206 = param1;
        }

        private function onRoomObjectAdded(param1:RoomEngineObjectEvent):void
        {
            var _loc2_:IUserData;
            if (param1.category == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)
            {
                _loc2_ = this.handler.roomSession.userDataManager.getUserDataByIndex(param1.objectId);
                if (_loc2_)
                {
                    if (this.handler.friendList.getFriendNames().indexOf(_loc2_.name) > -1)
                    {
                        this.showFriendName(_loc2_, param1.objectId);
                    };
                };
            };
        }

        private function onRoomObjectRemoved(param1:RoomEngineObjectEvent):void
        {
            var _loc2_:FriendNameView;
            if (param1.category == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)
            {
                for each (_loc2_ in this.var_5204)
                {
                    if (_loc2_.objectId == param1.objectId)
                    {
                        this.removeView(_loc2_, false);
                    };
                };
            };
        }

        private function onEffectsChanged(param1:HabboInventoryEffectsEvent):void
        {
            if ((this._view is OwnAvatarMenuView))
            {
                (this._view as OwnAvatarMenuView).updateButtons();
            };
        }

        private function getOwnCharacterInfo():void
        {
            messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.var_1709, 0, 0));
        }

        override public function dispose():void
        {
            var _loc1_:FriendNameView;
            if (disposed)
            {
                return;
            };
            for each (_loc1_ in this.var_5204)
            {
                _loc1_.dispose();
            };
            this.var_5204 = null;
            if (this.var_4007)
            {
                this.var_4007.removeUpdateReceiver(this);
                this.var_4007 = null;
            };
            if (this.var_5201)
            {
                this.var_5201.dispose();
                this.var_5201 = null;
            };
            if (this.var_5203)
            {
                this.var_5203.dispose();
                this.var_5203 = null;
            };
            if (this.var_5202)
            {
                this.var_5202.dispose();
                this.var_5202 = null;
            };
            if (this._view)
            {
                if (!this._view.disposed)
                {
                    this._view.dispose();
                    this._view = null;
                };
            };
            this.handler.roomEngine.events.removeEventListener(RoomEngineObjectEvent.var_384, this.onRoomObjectAdded);
            this.handler.roomEngine.events.removeEventListener(RoomEngineObjectEvent.var_385, this.onRoomObjectRemoved);
            this.handler.container.inventory.events.removeEventListener(HabboInventoryEffectsEvent.var_257, this.onEffectsChanged);
            this._view = null;
            this._configuration = null;
            super.dispose();
        }

        public function close():void
        {
            this.removeView(this._view, false);
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (!param1)
            {
                return;
            };
            param1.addEventListener(RoomWidgetAvatarInfoEvent.var_409, this.updateEventHandler);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1697, this.updateEventHandler);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1641, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1539, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1544, this.updateEventHandler);
            param1.addEventListener(RoomWidgetFurniInfoUpdateEvent.var_1702, this.updateEventHandler);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.updateEventHandler);
            param1.addEventListener(RoomWidgetPetInfoUpdateEvent.PET_INFO, this.updateEventHandler);
            param1.addEventListener(RoomWidgetUserDataUpdateEvent.var_376, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1543, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomEngineUpdateEvent.var_450, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomEngineUpdateEvent.var_1556, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomObjectNameEvent.var_1710, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1545, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1546, this.updateEventHandler);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetAvatarInfoEvent.var_409, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1697, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1641, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1539, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1544, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetFurniInfoUpdateEvent.var_1702, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetPetInfoUpdateEvent.PET_INFO, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetUserDataUpdateEvent.var_376, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1543, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.var_450, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.var_1556, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomObjectNameEvent.var_1710, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1546, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1546, this.updateEventHandler);
        }

        private function updateEventHandler(param1:RoomWidgetUpdateEvent):void
        {
            var _loc2_:RoomWidgetAvatarInfoEvent;
            var _loc3_:RoomWidgetUserInfoUpdateEvent;
            var _loc4_:RoomWidgetUserInfoUpdateEvent;
            var _loc5_:RoomWidgetRoomObjectUpdateEvent;
            var _loc6_:RoomWidgetPetInfoUpdateEvent;
            var _loc7_:FriendNameView;
            switch (param1.type)
            {
                case RoomWidgetAvatarInfoEvent.var_409:
                    _loc2_ = (param1 as RoomWidgetAvatarInfoEvent);
                    if (((this.var_5198) && (_loc2_.allowNameChange)))
                    {
                        this.useMinimizedOwnAvatarMenu = true;
                        this.selectOwnAvatar();
                    }
                    else
                    {
                        this.updateView(_loc2_.userId, _loc2_.userName, _loc2_.roomIndex, RoomObjectTypeEnum.var_1406, _loc2_.allowNameChange, null);
                    };
                    this._isInitialized = true;
                    break;
                case RoomWidgetRoomObjectNameEvent.var_1710:
                    if (RoomWidgetRoomObjectNameEvent(param1).category == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)
                    {
                        this.updateView(RoomWidgetRoomObjectNameEvent(param1).userId, RoomWidgetRoomObjectNameEvent(param1).userName, RoomWidgetRoomObjectNameEvent(param1).roomIndex, RoomObjectTypeEnum.var_1406, false, null);
                    };
                    break;
                case RoomWidgetRoomObjectUpdateEvent.var_1539:
                    this.var_5206 = true;
                    break;
                case RoomWidgetRoomObjectUpdateEvent.var_1544:
                case RoomWidgetFurniInfoUpdateEvent.var_1702:
                    if (this._view)
                    {
                        this.removeView(this._view, false);
                    };
                    break;
                case RoomWidgetRoomObjectUpdateEvent.var_1545:
                    if (!((this._view is AvatarMenuView) || (this._view is OwnAvatarMenuView)))
                    {
                        this.var_5199 = RoomWidgetRoomObjectUpdateEvent(param1).id;
                        messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.var_1711, RoomWidgetRoomObjectUpdateEvent(param1).id, RoomWidgetRoomObjectUpdateEvent(param1).category));
                    };
                    break;
                case RoomWidgetRoomObjectUpdateEvent.var_1546:
                    if (!((this._view is AvatarMenuView) || (this._view is OwnAvatarMenuView)))
                    {
                        if (RoomWidgetRoomObjectUpdateEvent(param1).id == this.var_5199)
                        {
                            if (((this._view) && (!(this._view.allowNameChange))))
                            {
                                this.removeView(this._view, false);
                                this.var_5199 = -1;
                            };
                        };
                    };
                    break;
                case RoomWidgetUserInfoUpdateEvent.var_1697:
                case RoomWidgetUserInfoUpdateEvent.var_1641:
                    _loc3_ = (param1 as RoomWidgetUserInfoUpdateEvent);
                    this.storeUserInfo(_loc3_);
                    this.updateView(_loc3_.webID, _loc3_.name, _loc3_.userRoomId, RoomObjectTypeEnum.var_1406, false, ((_loc3_.isSpectatorMode) ? null : this.var_5196));
                    break;
                case RoomWidgetUserInfoUpdateEvent.BOT:
                    _loc4_ = (param1 as RoomWidgetUserInfoUpdateEvent);
                    this.updateView(_loc4_.webID, _loc4_.name, _loc4_.userRoomId, RoomObjectTypeEnum.var_1712, false, null);
                    break;
                case RoomWidgetPetInfoUpdateEvent.PET_INFO:
                    if (this.var_5206)
                    {
                        _loc6_ = (param1 as RoomWidgetPetInfoUpdateEvent);
                        this.updateView(_loc6_.id, _loc6_.name, _loc6_.roomIndex, RoomObjectTypeEnum.var_1300, false, null);
                    };
                    break;
                case RoomWidgetUserDataUpdateEvent.var_376:
                    if (!this._isInitialized)
                    {
                        this.getOwnCharacterInfo();
                    };
                    break;
                case RoomWidgetRoomObjectUpdateEvent.var_1543:
                    _loc5_ = (param1 as RoomWidgetRoomObjectUpdateEvent);
                    if (((this._view) && (this._view.roomIndex == _loc5_.id)))
                    {
                        this.removeView(this._view, false);
                    };
                    for each (_loc7_ in this.var_5204)
                    {
                        if (_loc7_.objectId == _loc5_.id)
                        {
                            this.removeView(_loc7_, false);
                            break;
                        };
                    };
                    break;
                case RoomWidgetRoomEngineUpdateEvent.var_450:
                    this.var_5195 = false;
                    break;
                case RoomWidgetRoomEngineUpdateEvent.var_1556:
                    this.var_5195 = true;
                    break;
            };
            this.checkUpdateNeed();
        }

        public function selectOwnAvatar():void
        {
            var _loc3_:RoomWidgetRoomObjectMessage;
            if ((((!(this.handler)) || (!(this.handler.container))) || (!(this.handler.roomSession))))
            {
                return;
            };
            var _loc1_:int = this.handler.container.sessionDataManager.userId;
            var _loc2_:IUserData = this.handler.roomSession.userDataManager.getUserData(_loc1_);
            if (!_loc2_)
            {
                return;
            };
            _loc3_ = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.var_1571, _loc2_.id, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
            this.handler.container.processWidgetMessage(_loc3_);
        }

        private function storeUserInfo(param1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.var_5196.amIAnyRoomController = param1.amIAnyRoomController;
            this.var_5196.amIController = param1.amIController;
            this.var_5196.amIOwner = param1.amIOwner;
            this.var_5196.canBeAskedAsFriend = param1.canBeAskedAsFriend;
            this.var_5196.canBeKicked = param1.canBeKicked;
            this.var_5196.canTrade = param1.canTrade;
            this.var_5196.canTradeReason = param1.canTradeReason;
            this.var_5196.hasFlatControl = param1.hasFlatControl;
            this.var_5196.isIgnored = param1.isIgnored;
            this.var_5196.respectLeft = param1.respectLeft;
            this.var_5196.isOwnUser = (param1.type == RoomWidgetUserInfoUpdateEvent.var_1697);
            this.var_5196.allowNameChange = param1.allowNameChange;
        }

        private function updateView(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:AvatarInfoData):void
        {
            var _loc8_:FriendNameView;
            var _loc7_:Boolean;
            if (param6)
            {
                _loc7_ = ((param6.isOwnUser) ? this.var_5198 : this.var_5197);
            };
            if ((((_loc7_) && (this._view)) && (!((this._view is AvatarMenuView) || (this._view is OwnAvatarMenuView)))))
            {
                this.removeView(this._view, false);
            };
            if (((((((this._view == null) || (!(this._view.userId == param1))) || (!(this._view.userName == param2))) || (!(this._view.roomIndex == param3))) || (!(this._view.userType == param4))) || (param5)))
            {
                if (this._view)
                {
                    this.removeView(this._view, false);
                };
                if (!this.var_5195)
                {
                    if (_loc7_)
                    {
                        if (param6.isOwnUser)
                        {
                            if (!this.var_5202)
                            {
                                this.var_5202 = new OwnAvatarMenuView(this);
                            };
                            this._view = this.var_5202;
                            OwnAvatarMenuView.setup((this._view as OwnAvatarMenuView), param1, param2, param3, param4, param6);
                        }
                        else
                        {
                            if (!this.var_5203)
                            {
                                this.var_5203 = new AvatarMenuView(this);
                            };
                            this._view = this.var_5203;
                            AvatarMenuView.setup((this._view as AvatarMenuView), param1, param2, param3, param4, param6);
                            for each (_loc8_ in this.var_5204)
                            {
                                if (_loc8_.userId == param1)
                                {
                                    this.removeView(_loc8_, false);
                                    break;
                                };
                            };
                        };
                    }
                    else
                    {
                        if (!this.var_5201)
                        {
                            this.var_5201 = new AvatarInfoView(this);
                        };
                        this._view = this.var_5201;
                        AvatarInfoView.setup(this._view, param1, param2, param3, param4, param5);
                    };
                };
            }
            else
            {
                if (((this._view is AvatarMenuView) || (this._view is OwnAvatarMenuView)))
                {
                    if (this._view.userName == param2)
                    {
                        this.removeView(this._view, false);
                    };
                };
            };
        }

        public function removeView(param1:AvatarInfoView, param2:Boolean):void
        {
            if (param1)
            {
                if (this.var_5200)
                {
                    param1.hide(param2);
                }
                else
                {
                    param1.dispose();
                    this.var_5201 = null;
                    this.var_5203 = null;
                    this.var_5202 = null;
                };
                if (param1 == this._view)
                {
                    this._view = null;
                };
                if ((param1 is FriendNameView))
                {
                    this.var_5204.remove(param1.userName);
                    param1.dispose();
                    this.checkUpdateNeed();
                };
            };
        }

        private function showFriendName(param1:IUserData, param2:int):void
        {
            var _loc3_:FriendNameView;
            if (this.var_5204[param1.name] == null)
            {
                _loc3_ = new FriendNameView(this);
                FriendNameView.setup(_loc3_, param1.webID, param1.name, -1, RoomObjectTypeEnum.var_1406, param2);
                this.var_5204[param1.name] = _loc3_;
                this.checkUpdateNeed();
            };
        }

        public function checkUpdateNeed():void
        {
            if (!this.var_4007)
            {
                return;
            };
            if (((this._view) || (this.var_5204.length > 0)))
            {
                this.var_4007.registerUpdateReceiver(this, 10);
            }
            else
            {
                this.var_4007.removeUpdateReceiver(this);
            };
        }

        public function update(param1:uint):void
        {
            var _loc2_:RoomWidgetUserLocationUpdateEvent;
            var _loc3_:FriendNameView;
            if (this._view)
            {
                _loc2_ = (messageListener.processWidgetMessage(new RoomWidgetGetUserLocationMessage(this._view.userId, this._view.userType)) as RoomWidgetUserLocationUpdateEvent);
                if (!_loc2_)
                {
                    return;
                };
                this._view.update(_loc2_.rectangle, _loc2_.screenLocation, param1);
            };
            for each (_loc3_ in this.var_5204)
            {
                _loc2_ = (messageListener.processWidgetMessage(new RoomWidgetGetUserLocationMessage(_loc3_.userId, _loc3_.userType)) as RoomWidgetUserLocationUpdateEvent);
                if (_loc2_)
                {
                    _loc3_.update(_loc2_.rectangle, _loc2_.screenLocation, param1);
                };
            };
        }

        public function openAvatarEditor():void
        {
            this.handler.container.avatarEditor.openEditor(AvatarEditorInstanceId.var_540, null, null, true);
            this.handler.container.avatarEditor.loadOwnAvatarInEditor(AvatarEditorInstanceId.var_540);
        }

        public function get hasClub():Boolean
        {
            return (this.handler.container.sessionDataManager.hasUserRight(null, HabboClubLevelEnum.var_256));
        }

        public function get hasEffectOn():Boolean
        {
            var _loc2_:IWidgetAvatarEffect;
            var _loc1_:Array = this.handler.container.inventory.getActivatedAvatarEffects();
            for each (_loc2_ in _loc1_)
            {
                if (_loc2_.isInUse)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function set isDancing(param1:Boolean):void
        {
            this.var_5205 = param1;
        }

        public function get isDancing():Boolean
        {
            return (this.var_5205);
        }

        public function get useMinimizedOwnAvatarMenu():Boolean
        {
            return (this.handler.container.config.getBoolean(var_1713, true));
        }

        public function set useMinimizedOwnAvatarMenu(param1:Boolean):void
        {
            this.handler.container.config.setKey(var_1713, ((param1) ? "1" : "0"));
        }


    }
}