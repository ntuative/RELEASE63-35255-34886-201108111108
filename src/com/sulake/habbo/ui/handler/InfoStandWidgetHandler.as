package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.habbo.ui.widget.infostand.InfostandWidget;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.session.events.UserTagsReceivedEvent;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.habbo.session.events.RoomSessionUserFigureUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetInfoUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetCommandsUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionFavouriteGroupUpdateEvent;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomTagSearchMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeImageMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPetCommandMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeMottoMessage;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatInputContentUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectOperationEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetBadgeImageUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectNameEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.friendlist.IFriend;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import flash.utils.getTimer;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserBadgesUpdateEvent;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserTagsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserFigureUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.session.IPetInfo;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetCommandsUpdateEvent;

    public class InfoStandWidgetHandler implements IRoomWidgetHandler 
    {

        private var var_1023:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var var_5174:Map = new Map();
        private var var_5038:IHabboMusicController;
        private var _widget:InfostandWidget;

        public function InfoStandWidgetHandler(param1:IHabboMusicController)
        {
            this.var_5038 = param1;
            if (this.var_5038 != null)
            {
                this.var_5038.events.addEventListener(NowPlayingEvent.var_1582, this.onNowPlayingChanged);
                this.var_5038.events.addEventListener(SongInfoReceivedEvent.var_982, this.onSongInfoReceivedEvent);
            };
        }

        public function set widget(param1:InfostandWidget):void
        {
            this._widget = param1;
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (this._container);
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_406);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            if (this._container != null)
            {
                if (this._container.sessionDataManager != null)
                {
                    this._container.sessionDataManager.events.removeEventListener(UserTagsReceivedEvent.var_1703, this.onUserTags);
                    this._container.sessionDataManager.events.removeEventListener(BadgeImageReadyEvent.var_100, this.onBadgeImage);
                };
                if (this._container.roomSessionManager != null)
                {
                    this._container.roomSessionManager.events.removeEventListener(RoomSessionUserFigureUpdateEvent.var_1704, this.onFigureUpdate);
                    this._container.roomSessionManager.events.removeEventListener(RoomSessionPetInfoUpdateEvent.PET_INFO, this.onPetInfo);
                    this._container.roomSessionManager.events.removeEventListener(RoomSessionPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
                    this._container.roomSessionManager.events.removeEventListener(RoomSessionFavouriteGroupUpdateEvent.var_1855, this.onFavouriteGroupUpdated);
                };
            };
            this._container = param1;
            if (param1 == null)
            {
                return;
            };
            if (this._container.sessionDataManager != null)
            {
                this._container.sessionDataManager.events.addEventListener(UserTagsReceivedEvent.var_1703, this.onUserTags);
                this._container.sessionDataManager.events.addEventListener(BadgeImageReadyEvent.var_100, this.onBadgeImage);
            };
            if (this._container.roomSessionManager != null)
            {
                this._container.roomSessionManager.events.addEventListener(RoomSessionUserFigureUpdateEvent.var_1704, this.onFigureUpdate);
                this._container.roomSessionManager.events.addEventListener(RoomSessionPetInfoUpdateEvent.PET_INFO, this.onPetInfo);
                this._container.roomSessionManager.events.addEventListener(RoomSessionPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
                this._container.roomSessionManager.events.addEventListener(RoomSessionFavouriteGroupUpdateEvent.var_1855, this.onFavouriteGroupUpdated);
            };
        }

        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:BitmapData;
            if (this.var_5174 != null)
            {
                _loc1_ = (this.var_5174.length - 1);
                while (_loc1_ >= 0)
                {
                    _loc2_ = this.var_5174.getWithIndex(_loc1_);
                    if (_loc2_)
                    {
                        _loc2_.dispose();
                    };
                    _loc2_ = null;
                    _loc1_--;
                };
                this.var_5174.dispose();
                this.var_5174 = null;
            };
            if (this.var_5038 != null)
            {
                this.var_5038.events.removeEventListener(NowPlayingEvent.var_1582, this.onNowPlayingChanged);
                this.var_5038.events.removeEventListener(SongInfoReceivedEvent.var_982, this.onSongInfoReceivedEvent);
                this.var_5038 = null;
            };
            this.var_1023 = true;
            this.container = null;
        }

        public function getWidgetMessages():Array
        {
            var _loc1_:Array = [];
            _loc1_.push(RoomWidgetRoomObjectMessage.var_1661);
            _loc1_.push(RoomWidgetRoomObjectMessage.var_1711);
            _loc1_.push(RoomWidgetUserActionMessage.var_2286);
            _loc1_.push(RoomWidgetUserActionMessage.var_2287);
            _loc1_.push(RoomWidgetUserActionMessage.var_2288);
            _loc1_.push(RoomWidgetUserActionMessage.var_2289);
            _loc1_.push(RoomWidgetUserActionMessage.var_2290);
            _loc1_.push(RoomWidgetUserActionMessage.var_2291);
            _loc1_.push(RoomWidgetUserActionMessage.var_2292);
            _loc1_.push(RoomWidgetUserActionMessage.var_2293);
            _loc1_.push(RoomWidgetUserActionMessage.var_2294);
            _loc1_.push(RoomWidgetUserActionMessage.var_2295);
            _loc1_.push(RoomWidgetUserActionMessage.var_2296);
            _loc1_.push(RoomWidgetFurniActionMessage.var_1174);
            _loc1_.push(RoomWidgetFurniActionMessage.var_2297);
            _loc1_.push(RoomWidgetFurniActionMessage.var_2298);
            _loc1_.push(RoomWidgetFurniActionMessage.var_2299);
            _loc1_.push(RoomWidgetFurniActionMessage.var_2300);
            _loc1_.push(RoomWidgetRoomTagSearchMessage.var_2301);
            _loc1_.push(RoomWidgetGetBadgeDetailsMessage.var_2302);
            _loc1_.push(RoomWidgetGetBadgeImageMessage.var_2303);
            _loc1_.push(RoomWidgetUserActionMessage.var_2304);
            _loc1_.push(RoomWidgetUserActionMessage.var_2305);
            _loc1_.push(RoomWidgetUserActionMessage.var_2306);
            _loc1_.push(RoomWidgetUserActionMessage.var_2307);
            _loc1_.push(RoomWidgetPetCommandMessage.var_2308);
            _loc1_.push(RoomWidgetPetCommandMessage.var_2309);
            _loc1_.push(RoomWidgetUserActionMessage.var_2310);
            _loc1_.push(RoomWidgetUserActionMessage.var_1708);
            _loc1_.push(RoomWidgetChangeMottoMessage.var_2311);
            return (_loc1_);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc3_:IUserData;
            var _loc4_:RoomWidgetUserActionMessage;
            var _loc7_:RoomWidgetFurniActionMessage;
            var _loc8_:RoomWidgetChatInputContentUpdateEvent;
            var _loc9_:IUserData;
            var _loc10_:String;
            var _loc11_:RoomWidgetRoomTagSearchMessage;
            var _loc12_:RoomWidgetGetBadgeDetailsMessage;
            var _loc13_:RoomWidgetGetBadgeImageMessage;
            var _loc14_:BitmapData;
            var _loc15_:RoomWidgetPetCommandMessage;
            var _loc16_:RoomWidgetPetCommandMessage;
            var _loc17_:RoomWidgetChangeMottoMessage;
            var _loc18_:Map;
            var _loc19_:Array;
            var _loc20_:String;
            var _loc21_:Array;
            var _loc22_:String;
            var _loc23_:String;
            if (param1 == null)
            {
                return (null);
            };
            if (this._container == null)
            {
                return (null);
            };
            var _loc2_:int;
            _loc4_ = (param1 as RoomWidgetUserActionMessage);
            if (_loc4_ != null)
            {
                _loc2_ = _loc4_.userId;
                if (_loc4_.type == RoomWidgetUserActionMessage.var_2304)
                {
                    _loc3_ = this._container.roomSession.userDataManager.getUserDataByIndex(_loc2_);
                }
                else
                {
                    if ((((param1.type == RoomWidgetUserActionMessage.var_1708) || (param1.type == RoomWidgetUserActionMessage.var_2310)) || (param1.type == RoomWidgetUserActionMessage.var_2306)))
                    {
                        _loc3_ = this._container.roomSession.userDataManager.getPetUserData(_loc2_);
                    }
                    else
                    {
                        _loc3_ = this._container.roomSession.userDataManager.getUserData(_loc2_);
                    };
                };
                if (_loc3_ == null)
                {
                    return (null);
                };
            };
            var _loc5_:int;
            var _loc6_:int;
            _loc7_ = (param1 as RoomWidgetFurniActionMessage);
            if (_loc7_ != null)
            {
                _loc5_ = _loc7_.furniId;
                _loc6_ = _loc7_.furniCategory;
            };
            switch (param1.type)
            {
                case RoomWidgetRoomObjectMessage.var_1661:
                    return (this.handleGetObjectInfoMessage((param1 as RoomWidgetRoomObjectMessage)));
                case RoomWidgetRoomObjectMessage.var_1711:
                    return (this.handleGetObjectNameMessage((param1 as RoomWidgetRoomObjectMessage)));
                case RoomWidgetUserActionMessage.var_2286:
                    this._container.friendList.askForAFriend(_loc2_, _loc3_.name);
                    break;
                case RoomWidgetUserActionMessage.var_2287:
                    this._container.sessionDataManager.giveRespect(_loc2_);
                    break;
                case RoomWidgetUserActionMessage.var_2310:
                    this._container.sessionDataManager.givePetRespect(_loc2_);
                    break;
                case RoomWidgetUserActionMessage.var_2288:
                    _loc8_ = new RoomWidgetChatInputContentUpdateEvent(RoomWidgetChatInputContentUpdateEvent.var_1643, _loc3_.name);
                    this._container.events.dispatchEvent(_loc8_);
                    break;
                case RoomWidgetUserActionMessage.var_2289:
                    this._container.sessionDataManager.ignoreUser(_loc3_.name);
                    break;
                case RoomWidgetUserActionMessage.var_2290:
                    this._container.sessionDataManager.unignoreUser(_loc3_.name);
                    break;
                case RoomWidgetUserActionMessage.var_2291:
                    this._container.roomSession.kickUser(_loc3_.webID);
                    break;
                case RoomWidgetUserActionMessage.var_2292:
                    this._container.roomSession.banUser(_loc3_.webID);
                    break;
                case RoomWidgetUserActionMessage.var_2293:
                    this._container.roomSession.assignRights(_loc3_.webID);
                    break;
                case RoomWidgetUserActionMessage.var_2294:
                    this._container.roomSession.removeRights(_loc3_.webID);
                    break;
                case RoomWidgetUserActionMessage.var_2295:
                    _loc9_ = this._container.roomSession.userDataManager.getUserData(_loc4_.userId);
                    this._container.inventory.setupTrading(_loc9_.id, _loc9_.name);
                    break;
                case RoomWidgetUserActionMessage.var_2296:
                    this._container.sessionDataManager.openHabboHomePage(_loc3_.webID);
                    break;
                case RoomWidgetUserActionMessage.var_2306:
                    this._container.roomSession.pickUpPet(_loc2_);
                    break;
                case RoomWidgetFurniActionMessage.var_2297:
                    this._container.roomEngine.modifyRoomObject(_loc5_, _loc6_, RoomObjectOperationEnum.OBJECT_ROTATE_POSITIVE);
                    break;
                case RoomWidgetFurniActionMessage.var_1174:
                    this._container.roomEngine.modifyRoomObject(_loc5_, _loc6_, RoomObjectOperationEnum.OBJECT_MOVE);
                    break;
                case RoomWidgetFurniActionMessage.var_2298:
                    this._container.roomEngine.modifyRoomObject(_loc5_, _loc6_, RoomObjectOperationEnum.OBJECT_PICKUP);
                    break;
                case RoomWidgetFurniActionMessage.var_2299:
                    this._container.roomEngine.useRoomObjectInActiveRoom(_loc5_, _loc6_);
                    break;
                case RoomWidgetFurniActionMessage.var_2300:
                    _loc10_ = _loc7_.objectData;
                    if (_loc10_ != null)
                    {
                        _loc18_ = new Map();
                        _loc19_ = _loc10_.split("\t");
                        if (_loc19_ != null)
                        {
                            for each (_loc20_ in _loc19_)
                            {
                                _loc21_ = _loc20_.split("=", 2);
                                if (((!(_loc21_ == null)) && (_loc21_.length == 2)))
                                {
                                    _loc22_ = _loc21_[0];
                                    _loc23_ = _loc21_[1];
                                    _loc18_.add(_loc22_, _loc23_);
                                };
                            };
                        };
                        this._container.roomEngine.modifyRoomObjectDataWithMap(_loc5_, _loc6_, RoomObjectOperationEnum.OBJECT_SAVE_STUFF_DATA, _loc18_);
                        if (!_loc18_.disposed)
                        {
                            _loc18_.dispose();
                        };
                    };
                    break;
                case RoomWidgetUserActionMessage.var_1708:
                    if (((!(this._container.roomSession == null)) && (!(this._container.roomSession.userDataManager == null))))
                    {
                        this._container.roomSession.userDataManager.requestPetInfo(_loc2_);
                    };
                    break;
                case RoomWidgetRoomTagSearchMessage.var_2301:
                    _loc11_ = (param1 as RoomWidgetRoomTagSearchMessage);
                    if (_loc11_ == null)
                    {
                        return (null);
                    };
                    this._container.navigator.performTagSearch(_loc11_.tag);
                    break;
                case RoomWidgetGetBadgeDetailsMessage.var_2302:
                    _loc12_ = (param1 as RoomWidgetGetBadgeDetailsMessage);
                    if (_loc12_ == null)
                    {
                        return (null);
                    };
                    this._container.sessionDataManager.showGroupBadgeInfo(_loc12_.groupId);
                    break;
                case RoomWidgetGetBadgeImageMessage.var_2303:
                    _loc13_ = (param1 as RoomWidgetGetBadgeImageMessage);
                    if (_loc13_ == null)
                    {
                        return (null);
                    };
                    _loc14_ = this._container.sessionDataManager.getBadgeImage(_loc13_.badgeId);
                    if (_loc14_ != null)
                    {
                        this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_loc13_.badgeId, _loc14_));
                    };
                    break;
                case RoomWidgetUserActionMessage.var_2304:
                    this._container.roomSession.kickBot(_loc2_);
                    break;
                case RoomWidgetUserActionMessage.var_2305:
                    if (((this._container == null) || (this._container.habboHelp == null))) break;
                    if (_loc3_ == null) break;
                    this._container.habboHelp.reportUser(_loc2_, _loc3_.name);
                    break;
                case RoomWidgetPetCommandMessage.var_2309:
                    _loc15_ = (param1 as RoomWidgetPetCommandMessage);
                    this._container.roomSession.requestPetCommands(_loc15_.petId);
                    break;
                case RoomWidgetPetCommandMessage.var_2308:
                    _loc16_ = (param1 as RoomWidgetPetCommandMessage);
                    this._container.roomSession.sendChatMessage(_loc16_.value);
                    break;
                case RoomWidgetChangeMottoMessage.var_2311:
                    _loc17_ = (param1 as RoomWidgetChangeMottoMessage);
                    this._container.roomSession.sendChangeMottoMessage(_loc17_.motto);
                    break;
            };
            return (null);
        }

        private function handleGetObjectNameMessage(param1:RoomWidgetRoomObjectMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:int;
            var _loc3_:int;
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:IRoomObject;
            var _loc8_:String;
            var _loc9_:IUserData;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:IFurnitureData;
            _loc2_ = this._container.roomSession.roomId;
            _loc3_ = this._container.roomSession.roomCategory;
            var _loc4_:String;
            switch (param1.category)
            {
                case RoomObjectCategoryEnum.var_70:
                case RoomObjectCategoryEnum.var_71:
                    if (((this._container.events == null) || (this._container.roomEngine == null)))
                    {
                        return (null);
                    };
                    _loc7_ = this._container.roomEngine.getRoomObject(_loc2_, _loc3_, param1.id, param1.category);
                    _loc8_ = _loc7_.getType();
                    if (_loc8_.indexOf("poster") == 0)
                    {
                        _loc10_ = int(_loc8_.replace("poster", ""));
                        _loc4_ = (("${poster_" + _loc10_) + "_name}");
                        _loc5_ = _loc7_.getId();
                        _loc6_ = -1;
                    }
                    else
                    {
                        _loc11_ = _loc7_.getModel().getNumber(RoomObjectVariableEnum.var_500);
                        if (param1.category == RoomObjectCategoryEnum.var_70)
                        {
                            _loc12_ = this._container.sessionDataManager.getFloorItemData(_loc11_);
                        }
                        else
                        {
                            if (param1.category == RoomObjectCategoryEnum.var_71)
                            {
                                _loc12_ = this._container.sessionDataManager.getWallItemData(_loc11_);
                            };
                        };
                        if (_loc12_ == null)
                        {
                            return (null);
                        };
                        _loc4_ = _loc12_.title;
                        _loc5_ = _loc7_.getId();
                        _loc6_ = _loc12_.id;
                    };
                    break;
                case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                    if ((((((this._container.roomSession == null) || (this._container.sessionDataManager == null)) || (this._container.events == null)) || (this._container.roomEngine == null)) || (this._container.friendList == null)))
                    {
                        return (null);
                    };
                    _loc9_ = this._container.roomSession.userDataManager.getUserDataByIndex(param1.id);
                    if (_loc9_ == null)
                    {
                        return (null);
                    };
                    _loc4_ = _loc9_.name;
                    _loc5_ = _loc9_.id;
                    _loc6_ = _loc9_.webID;
                    break;
            };
            if (_loc4_ != null)
            {
                this._container.events.dispatchEvent(new RoomWidgetRoomObjectNameEvent(_loc6_, param1.category, _loc4_, _loc5_));
            };
            return (null);
        }

        private function handleGetObjectInfoMessage(param1:RoomWidgetRoomObjectMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:uint;
            var _loc5_:ImageResult;
            var _loc6_:RoomWidgetFurniInfoUpdateEvent;
            var _loc7_:IRoomObject;
            var _loc8_:IRoomObjectModel;
            var _loc9_:String;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:IUserData;
            var _loc13_:String;
            var _loc14_:RoomWidgetUserInfoUpdateEvent;
            var _loc15_:Array;
            var _loc16_:String;
            var _loc17_:IRoomObject;
            var _loc18_:String;
            var _loc19_:String;
            var _loc20_:IAvatarImage;
            var _loc21_:BitmapData;
            var _loc22_:String;
            var _loc23_:int;
            var _loc24_:int;
            var _loc25_:IFurnitureData;
            var _loc26_:int;
            var _loc27_:String;
            var _loc28_:String;
            var _loc29_:String;
            var _loc30_:IPlayListController;
            var _loc31_:String;
            var _loc32_:ISongInfo;
            var _loc33_:IFriend;
            var _loc34_:Boolean;
            var _loc35_:Boolean;
            var _loc36_:int;
            var _loc37_:Array;
            var _loc38_:String;
            var _loc39_:Array;
            var _loc40_:int;
            var _loc41_:BitmapData;
            _loc2_ = this._container.roomSession.roomId;
            _loc3_ = this._container.roomSession.roomCategory;
            switch (param1.category)
            {
                case RoomObjectCategoryEnum.var_70:
                case RoomObjectCategoryEnum.var_71:
                    if (((this._container.events == null) || (this._container.roomEngine == null)))
                    {
                        return (null);
                    };
                    if (param1.id < 0)
                    {
                        return (null);
                    };
                    _loc4_ = 4282203453;
                    _loc5_ = this._container.roomEngine.getRoomObjectImage(_loc2_, _loc3_, param1.id, param1.category, new Vector3d(180), 32, null, _loc4_);
                    _loc6_ = new RoomWidgetFurniInfoUpdateEvent(RoomWidgetFurniInfoUpdateEvent.var_1702);
                    _loc6_.id = param1.id;
                    _loc6_.category = param1.category;
                    _loc7_ = this._container.roomEngine.getRoomObject(_loc2_, _loc3_, param1.id, param1.category);
                    _loc8_ = _loc7_.getModel();
                    if (_loc8_.getString(RoomWidgetInfostandExtraParamEnum.var_1062) != null)
                    {
                        _loc6_.extraParam = _loc8_.getString(RoomWidgetInfostandExtraParamEnum.var_1062);
                    }
                    else
                    {
                        if (_loc8_.getNumber(RoomObjectVariableEnum.var_505) == 1)
                        {
                            _loc6_.extraParam = RoomWidgetInfostandExtraParamEnum.var_1942;
                        };
                    };
                    _loc9_ = _loc7_.getType();
                    if (_loc9_.indexOf("poster") == 0)
                    {
                        _loc23_ = int(_loc9_.replace("poster", ""));
                        _loc6_.name = (("${poster_" + _loc23_) + "_name}");
                        _loc6_.description = (("${poster_" + _loc23_) + "_desc}");
                    }
                    else
                    {
                        _loc24_ = _loc8_.getNumber(RoomObjectVariableEnum.var_500);
                        if (param1.category == RoomObjectCategoryEnum.var_70)
                        {
                            _loc25_ = this._container.sessionDataManager.getFloorItemData(_loc24_);
                        }
                        else
                        {
                            if (param1.category == RoomObjectCategoryEnum.var_71)
                            {
                                _loc25_ = this._container.sessionDataManager.getWallItemData(_loc24_);
                            };
                        };
                        if (_loc25_ != null)
                        {
                            _loc6_.name = _loc25_.title;
                            _loc6_.description = _loc25_.description;
                            _loc6_.catalogPageId = _loc25_.catalogPageId;
                            _loc6_.offerId = _loc25_.offerId;
                            if (((!(this._container.userDefinedRoomEvents == null)) && (param1.category == RoomObjectCategoryEnum.var_70)))
                            {
                                this._container.userDefinedRoomEvents.stuffSelected(_loc7_.getId(), _loc25_.title);
                            };
                        };
                    };
                    if (_loc9_.indexOf("post_it") > -1)
                    {
                        _loc6_.isStickie = true;
                    };
                    _loc6_.image = _loc5_.data;
                    _loc10_ = _loc8_.getNumber(RoomObjectVariableEnum.var_503);
                    _loc11_ = _loc8_.getNumber(RoomObjectVariableEnum.var_504);
                    _loc6_.expiration = (_loc10_ - ((getTimer() - _loc11_) / 60000));
                    _loc6_.isWallItem = (param1.category == RoomObjectCategoryEnum.var_71);
                    _loc6_.isRoomOwner = this._container.roomSession.isRoomOwner;
                    _loc6_.isRoomController = this._container.roomSession.isRoomController;
                    _loc6_.isAnyRoomController = this._container.sessionDataManager.isAnyRoomController;
                    this._container.events.dispatchEvent(_loc6_);
                    if (((!(_loc6_.extraParam == null)) && (_loc6_.extraParam.length > 0)))
                    {
                        _loc26_ = -1;
                        _loc27_ = "";
                        _loc28_ = "";
                        _loc29_ = "";
                        if (_loc6_.extraParam == RoomWidgetInfostandExtraParamEnum.var_1083)
                        {
                            _loc30_ = this.var_5038.getRoomItemPlaylist();
                            if (_loc30_ != null)
                            {
                                _loc26_ = _loc30_.nowPlayingSongId;
                                _loc29_ = RoomWidgetSongUpdateEvent.var_1706;
                            };
                        }
                        else
                        {
                            if (_loc6_.extraParam.indexOf(RoomWidgetInfostandExtraParamEnum.var_1092) == 0)
                            {
                                _loc31_ = _loc6_.extraParam.substr(RoomWidgetInfostandExtraParamEnum.var_1092.length);
                                _loc26_ = parseInt(_loc31_);
                                _loc29_ = RoomWidgetSongUpdateEvent.var_1707;
                            };
                        };
                        if (_loc26_ != -1)
                        {
                            _loc32_ = this.var_5038.getSongInfo(_loc26_);
                            if (_loc32_ != null)
                            {
                                _loc27_ = _loc32_.name;
                                _loc28_ = _loc32_.creator;
                            };
                            this._container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(_loc29_, _loc26_, _loc27_, _loc28_));
                        };
                    };
                    break;
                case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                    if ((((((this._container.roomSession == null) || (this._container.sessionDataManager == null)) || (this._container.events == null)) || (this._container.roomEngine == null)) || (this._container.friendList == null)))
                    {
                        return (null);
                    };
                    _loc12_ = this._container.roomSession.userDataManager.getUserDataByIndex(param1.id);
                    if (_loc12_ == null)
                    {
                        return (null);
                    };
                    if (_loc12_.type == RoomObjectTypeEnum.var_1300)
                    {
                        this._container.roomSession.userDataManager.requestPetInfo(_loc12_.webID);
                        return (null);
                    };
                    if (_loc12_.type == RoomObjectTypeEnum.var_1406)
                    {
                        _loc13_ = RoomWidgetUserInfoUpdateEvent.var_1697;
                        if (_loc12_.webID != this._container.sessionDataManager.userId)
                        {
                            _loc13_ = RoomWidgetUserInfoUpdateEvent.var_1641;
                        };
                    }
                    else
                    {
                        if (_loc12_.type == RoomObjectTypeEnum.var_1712)
                        {
                            _loc13_ = RoomWidgetUserInfoUpdateEvent.BOT;
                        }
                        else
                        {
                            return (null);
                        };
                    };
                    _loc14_ = new RoomWidgetUserInfoUpdateEvent(_loc13_);
                    _loc14_.isSpectatorMode = this._container.roomSession.isSpectatorMode;
                    _loc14_.name = _loc12_.name;
                    _loc14_.motto = _loc12_.custom;
                    _loc14_.achievementScore = _loc12_.achievementScore;
                    _loc14_.webID = _loc12_.webID;
                    _loc14_.userRoomId = param1.id;
                    _loc15_ = new Array();
                    _loc17_ = this._container.roomEngine.getRoomObject(_loc2_, _loc3_, param1.id, param1.category);
                    if (_loc17_ != null)
                    {
                        _loc14_.carryItem = _loc17_.getModel().getNumber(RoomObjectVariableEnum.var_515);
                    };
                    if (_loc13_ == RoomWidgetUserInfoUpdateEvent.var_1697)
                    {
                        _loc14_.realName = this._container.sessionDataManager.realName;
                        _loc14_.allowNameChange = (!(this._container.habboHelp.hasChangedName()));
                    };
                    if (_loc13_ == RoomWidgetUserInfoUpdateEvent.var_1641)
                    {
                        _loc14_.canBeAskedAsFriend = this._container.friendList.canBeAskedForAFriend(_loc12_.webID);
                        _loc33_ = this._container.friendList.getFriend(_loc12_.webID);
                        if (_loc33_ != null)
                        {
                            _loc14_.realName = _loc33_.realName;
                        };
                        if (_loc17_ != null)
                        {
                            _loc38_ = _loc17_.getModel().getString(RoomObjectVariableEnum.var_754);
                            _loc14_.hasFlatControl = (((_loc38_ == "onlyfurniture") || (_loc38_ == "useradmin")) || (_loc38_ == ""));
                            _loc14_.canBeKicked = this._container.roomSession.isPrivateRoom;
                        };
                        _loc14_.isIgnored = this._container.sessionDataManager.isIgnored(_loc12_.name);
                        _loc14_.amIOwner = this._container.roomSession.isRoomOwner;
                        _loc14_.amIController = this._container.roomSession.isRoomController;
                        _loc14_.amIAnyRoomController = this._container.sessionDataManager.isAnyRoomController;
                        _loc14_.respectLeft = this._container.sessionDataManager.respectLeft;
                        _loc34_ = (!(this._container.sessionDataManager.systemShutDown));
                        _loc35_ = this._container.roomSession.isTradingRoom;
                        _loc14_.canTrade = ((_loc34_) && (_loc35_));
                        _loc14_.canTradeReason = RoomWidgetUserInfoUpdateEvent.TRADE_REASON_OK;
                        if (!_loc34_)
                        {
                            _loc14_.canTradeReason = RoomWidgetUserInfoUpdateEvent.var_2312;
                        };
                        if (!_loc35_)
                        {
                            _loc14_.canTradeReason = RoomWidgetUserInfoUpdateEvent.var_2313;
                        };
                        _loc36_ = this._container.sessionDataManager.userId;
                        _loc37_ = this._container.sessionDataManager.getUserTags(_loc36_);
                        this.dispatchUserTags(_loc36_, _loc37_);
                    };
                    if (_loc13_ == RoomWidgetUserInfoUpdateEvent.BOT)
                    {
                        _loc14_.canBeKicked = this._container.roomSession.isRoomOwner;
                        _loc15_.push(RoomWidgetUserInfoUpdateEvent.var_2314);
                    }
                    else
                    {
                        _loc15_ = this._container.roomSession.userDataManager.getUserBadges(_loc12_.webID);
                        _loc16_ = this._container.sessionDataManager.getGroupBadgeId(int(_loc12_.groupID));
                        _loc14_.groupId = int(_loc12_.groupID);
                        _loc14_.groupBadgeId = _loc16_;
                    };
                    _loc14_.badges = _loc15_;
                    _loc18_ = _loc12_.figure;
                    _loc19_ = _loc12_.sex;
                    _loc20_ = this._container.avatarRenderManager.createAvatarImage(_loc18_, AvatarScaleType.var_128, _loc19_);
                    if (_loc20_ != null)
                    {
                        _loc20_.setDirection(AvatarSetType.var_129, 4);
                        _loc14_.image = _loc20_.getImage(AvatarSetType.var_129, true);
                        _loc20_.dispose();
                    };
                    this._container.events.dispatchEvent(_loc14_);
                    if (_loc12_.type == RoomObjectTypeEnum.var_1406)
                    {
                        _loc39_ = this._container.sessionDataManager.getUserTags(_loc12_.webID);
                        this.dispatchUserTags(_loc12_.webID, _loc39_);
                    };
                    _loc40_ = 0;
                    while (_loc40_ < _loc15_.length)
                    {
                        _loc22_ = _loc15_[_loc40_];
                        _loc21_ = this._container.sessionDataManager.getBadgeImage(_loc22_);
                        if (_loc21_ != null)
                        {
                            this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_loc22_, _loc21_));
                        };
                        _loc40_++;
                    };
                    if (_loc16_ != null)
                    {
                        _loc41_ = this._container.sessionDataManager.getGroupBadgeImage(_loc16_);
                        if (_loc41_ != null)
                        {
                            this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_loc16_, _loc41_));
                        };
                    };
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([RoomSessionUserBadgesEvent.var_342]);
        }

        public function processEvent(param1:Event):void
        {
            var _loc2_:RoomSessionUserBadgesEvent;
            var _loc3_:int;
            var _loc4_:String;
            var _loc5_:BitmapData;
            switch (param1.type)
            {
                case RoomSessionUserBadgesEvent.var_342:
                    _loc2_ = (param1 as RoomSessionUserBadgesEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    };
                    this._container.events.dispatchEvent(new RoomWidgetUserBadgesUpdateEvent(_loc2_.userId, _loc2_.badges));
                    _loc3_ = 0;
                    while (_loc3_ < _loc2_.badges.length)
                    {
                        _loc4_ = _loc2_.badges[_loc3_];
                        _loc5_ = this._container.sessionDataManager.getBadgeImage(_loc4_);
                        if (_loc5_ != null)
                        {
                            this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_loc4_, _loc5_));
                        };
                        _loc3_++;
                    };
                    return;
            };
        }

        private function onUserTags(param1:UserTagsReceivedEvent):void
        {
            this.dispatchUserTags(param1.userId, param1.tags);
        }

        private function dispatchUserTags(param1:int, param2:Array):void
        {
            if (param2 == null)
            {
                return;
            };
            var _loc3_:Boolean;
            if (this._container.sessionDataManager != null)
            {
                _loc3_ = (param1 == this._container.sessionDataManager.userId);
            };
            if (((!(this._container == null)) && (!(this._container.events == null))))
            {
                this._container.events.dispatchEvent(new RoomWidgetUserTagsUpdateEvent(param1, param2, _loc3_));
            };
        }

        private function onBadgeImage(param1:BadgeImageReadyEvent):void
        {
            if (((!(this._container == null)) && (!(this._container.events == null))))
            {
                this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(param1.badgeId, param1.badgeImage));
            };
        }

        private function onFigureUpdate(param1:RoomSessionUserFigureUpdateEvent):void
        {
            var _loc5_:IAvatarImage;
            var _loc6_:Boolean;
            if (this._container == null)
            {
                return;
            };
            if (param1 == null)
            {
                return;
            };
            if (param1.userId < 0)
            {
                return;
            };
            var _loc2_:IUserData = this._container.roomSession.userDataManager.getUserDataByIndex(param1.userId);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:int = _loc2_.webID;
            var _loc4_:BitmapData;
            if (this._container.avatarRenderManager != null)
            {
                _loc5_ = this._container.avatarRenderManager.createAvatarImage(param1.figure, AvatarScaleType.var_128, param1.gender);
                if (_loc5_ != null)
                {
                    _loc5_.setDirection(AvatarSetType.var_129, 4);
                    _loc4_ = _loc5_.getImage(AvatarSetType.var_129, true);
                    _loc5_.dispose();
                };
                _loc6_ = (_loc3_ == this._container.sessionDataManager.userId);
                if (((!(this._container == null)) && (!(this._container.events == null))))
                {
                    this._container.events.dispatchEvent(new RoomWidgetUserFigureUpdateEvent(_loc3_, _loc4_, _loc6_, param1.customInfo, param1.achievementScore));
                };
            };
        }

        private function onPetInfo(param1:RoomSessionPetInfoUpdateEvent):void
        {
            var _loc8_:Boolean;
            var _loc9_:RoomWidgetPetInfoUpdateEvent;
            var _loc10_:Boolean;
            var _loc11_:int;
            var _loc12_:int;
            var _loc13_:IUserData;
            var _loc14_:IRoomObject;
            var _loc15_:String;
            var _loc2_:IPetInfo = param1.petInfo;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IUserData = this._container.roomSession.userDataManager.getPetUserData(_loc2_.petId);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:String = _loc3_.figure;
            var _loc5_:int = this.getPetType(_loc4_);
            var _loc6_:int = this.getPetRace(_loc4_);
            var _loc7_:BitmapData = (this.var_5174.getValue(_loc4_) as BitmapData);
            if (_loc7_ == null)
            {
                _loc7_ = this.getPetImage(_loc4_);
                this.var_5174.add(_loc4_, _loc7_);
            };
            if (((!(this._container == null)) && (!(this._container.events == null))))
            {
                _loc8_ = (_loc2_.ownerId == this._container.sessionDataManager.userId);
                _loc9_ = new RoomWidgetPetInfoUpdateEvent(_loc5_, _loc6_, _loc3_.name, _loc2_.petId, _loc7_, _loc8_, _loc2_.ownerId, _loc2_.ownerName, _loc3_.id);
                _loc9_.level = _loc2_.level;
                _loc9_.levelMax = _loc2_.levelMax;
                _loc9_.experience = _loc2_.experience;
                _loc9_.experienceMax = _loc2_.experienceMax;
                _loc9_.energy = _loc2_.energy;
                _loc9_.energyMax = _loc2_.energyMax;
                _loc9_.nutrition = _loc2_.nutrition;
                _loc9_.nutritionMax = _loc2_.nutritionMax;
                _loc9_.petRespect = _loc2_.respect;
                _loc9_.petRespectLeft = this._container.sessionDataManager.petRespectLeft;
                _loc9_.age = _loc2_.age;
                _loc10_ = false;
                _loc11_ = this._container.roomSession.roomId;
                _loc12_ = this._container.roomSession.roomCategory;
                _loc13_ = this._container.roomSession.userDataManager.getUserData(_loc2_.ownerId);
                if (_loc13_ != null)
                {
                    _loc14_ = this._container.roomEngine.getRoomObject(_loc11_, _loc12_, _loc13_.id, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
                    if (_loc14_ != null)
                    {
                        _loc15_ = _loc14_.getModel().getString(RoomObjectVariableEnum.var_754);
                        _loc10_ = ((((((this._container.roomSession.isRoomOwner) || (this._container.roomSession.isRoomController)) || (this._container.sessionDataManager.isAnyRoomController)) && (!(_loc15_ == "useradmin"))) && (this._container.roomSession.isPrivateRoom)) && (!(_loc8_)));
                    };
                };
                _loc9_.canOwnerBeKicked = _loc10_;
                this._container.events.dispatchEvent(_loc9_);
            };
        }

        private function onPetCommands(param1:RoomSessionPetCommandsUpdateEvent):void
        {
            var _loc2_:RoomWidgetPetCommandsUpdateEvent;
            if (((!(this._container == null)) && (!(this._container.events == null))))
            {
                _loc2_ = new RoomWidgetPetCommandsUpdateEvent(param1.petId, param1.allCommands, param1.enabledCommands);
                this._container.events.dispatchEvent(_loc2_);
            };
        }

        private function onFavouriteGroupUpdated(param1:RoomSessionFavouriteGroupUpdateEvent):void
        {
            if (this._widget)
            {
                this._widget.favouriteGroupUpdated(param1.roomIndex, param1.habboGroupId, param1.status);
            };
        }

        public function update():void
        {
        }

        private function getPetImage(param1:String):BitmapData
        {
            var _loc4_:IAvatarImage;
            var _loc5_:int;
            var _loc6_:uint;
            var _loc7_:ImageResult;
            var _loc2_:BitmapData;
            var _loc3_:int = this.getPetType(param1);
            if (_loc3_ < 8)
            {
                _loc4_ = this._container.avatarRenderManager.createPetImageFromFigure(param1, AvatarScaleType.var_128, null);
                if (_loc4_ != null)
                {
                    _loc2_ = _loc4_.getCroppedImage(AvatarSetType.var_129);
                    _loc4_.dispose();
                };
            }
            else
            {
                _loc5_ = this.getPetRace(param1);
                _loc6_ = 0;
                _loc7_ = this._container.roomEngine.getPetImage(_loc3_, _loc5_, new Vector3d(90), 64, null, _loc6_);
                if (_loc7_ != null)
                {
                    _loc2_ = _loc7_.data;
                };
            };
            if (_loc2_ == null)
            {
                _loc2_ = new BitmapData(30, 30, false, 4289374890);
            };
            return (_loc2_);
        }

        private function getPetType(param1:String):int
        {
            return (this.getSpaceSeparatedInteger(param1, 0));
        }

        private function getPetRace(param1:String):int
        {
            return (this.getSpaceSeparatedInteger(param1, 1));
        }

        private function getSpaceSeparatedInteger(param1:String, param2:int):int
        {
            var _loc3_:Array;
            if (param1 != null)
            {
                _loc3_ = param1.split(" ");
                if (_loc3_.length > param2)
                {
                    return (int(_loc3_[param2]));
                };
            };
            return (-1);
        }

        private function onNowPlayingChanged(param1:NowPlayingEvent):void
        {
            var _loc2_:int;
            var _loc3_:String;
            var _loc4_:String;
            var _loc5_:ISongInfo;
            if (this.var_5038 != null)
            {
                _loc2_ = param1.id;
                _loc3_ = "";
                _loc4_ = "";
                if (_loc2_ != -1)
                {
                    _loc5_ = this.var_5038.getSongInfo(_loc2_);
                    if (_loc5_ != null)
                    {
                        _loc3_ = _loc5_.name;
                        _loc4_ = _loc5_.creator;
                    };
                };
                this._container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(RoomWidgetSongUpdateEvent.var_1706, _loc2_, _loc3_, _loc4_));
            };
        }

        private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent):void
        {
            var _loc2_:ISongInfo;
            if (this.var_5038 != null)
            {
                _loc2_ = this.var_5038.getSongInfo(param1.id);
                if (_loc2_ != null)
                {
                    this._container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(RoomWidgetSongUpdateEvent.var_1707, param1.id, _loc2_.name, _loc2_.creator));
                };
            };
        }


    }
}