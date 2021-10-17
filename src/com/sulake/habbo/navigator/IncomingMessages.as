package com.sulake.habbo.navigator
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEventEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicSpaceCastLibsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomForwardMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.NavigatorSettingsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.UserFlatCatsEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsDataEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSavedEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSaveErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomInfoUpdatedEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailUpdateResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FavouritesEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FavouriteChangedEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerAddedEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerRemovedEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.NoSuchFlatEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomRatingEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CantConnectMessageEvent;
    import com.sulake.habbo.navigator.domain.NavigatorData;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserFlatCatsMessageComposer;
    import com.sulake.habbo.session.SecurityLevelEnum;
    import com.sulake.habbo.communication.messages.parser.navigator.OfficialRoomsMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomEventMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.communication.messages.parser.navigator.PublicSpaceCastLibsMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedMessageParser;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomForwardMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.NavigatorSettingsMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.parser.navigator.UserFlatCatsMessageParser;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsDataMessageParser;
    import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSavedMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomInfoUpdatedMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomThumbnailUpdateResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouriteChangedMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomMessageParser;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerAddedMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerRemovedMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomRatingMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetPublicSpaceCastLibsMessageComposer;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageParser;

    public class IncomingMessages 
    {

        private var _navigator:HabboNavigator;

        public function IncomingMessages(param1:HabboNavigator)
        {
            this._navigator = param1;
            var _loc2_:IHabboCommunicationManager = this._navigator.communication;
            _loc2_.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthOK));
            _loc2_.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObject));
            _loc2_.addHabboConnectionMessageEvent(new UserRightsMessageEvent(this.onUserRights));
            _loc2_.addHabboConnectionMessageEvent(new OfficialRoomsEvent(this.onOfficialRooms));
            _loc2_.addHabboConnectionMessageEvent(new GuestRoomSearchResultEvent(this.onGuestRoomSearchResult));
            _loc2_.addHabboConnectionMessageEvent(new PopularRoomTagsResultEvent(this.onPopularRoomTagsResult));
            _loc2_.addHabboConnectionMessageEvent(new RoomEventEvent(this.onRoomEventEvent));
            _loc2_.addHabboConnectionMessageEvent(new CanCreateRoomEventEvent(this.onCanCreateRoomEventEvent));
            _loc2_.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEnter));
            _loc2_.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(this.onRoomExit));
            _loc2_.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(this.onRoomInfo));
            _loc2_.addHabboConnectionMessageEvent(new PublicSpaceCastLibsEvent(this.onPublicSpaceCastLibs));
            _loc2_.addHabboConnectionMessageEvent(new FlatCreatedEvent(this.onFlatCreated));
            _loc2_.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(this.onSubscriptionInfo));
            _loc2_.addHabboConnectionMessageEvent(new RoomForwardMessageEvent(this.onRoomForward));
            _loc2_.addHabboConnectionMessageEvent(new NavigatorSettingsEvent(this.onNavigatorSettings));
            _loc2_.addHabboConnectionMessageEvent(new UserFlatCatsEvent(this.onUserFlatCats));
            _loc2_.addHabboConnectionMessageEvent(new RoomSettingsDataEvent(this.onRoomSettingsData));
            _loc2_.addHabboConnectionMessageEvent(new RoomSettingsErrorEvent(this.onRoomSettingsError));
            _loc2_.addHabboConnectionMessageEvent(new RoomSettingsSavedEvent(this.onRoomSettingsSaved));
            _loc2_.addHabboConnectionMessageEvent(new RoomSettingsSaveErrorEvent(this.onRoomSettingsSaveError));
            _loc2_.addHabboConnectionMessageEvent(new RoomInfoUpdatedEvent(this.onRoomInfoUpdated));
            _loc2_.addHabboConnectionMessageEvent(new RoomThumbnailUpdateResultEvent(this.onThumbnailUpdated));
            _loc2_.addHabboConnectionMessageEvent(new FavouritesEvent(this.onFavourites));
            _loc2_.addHabboConnectionMessageEvent(new FavouriteChangedEvent(this.onFavouriteChanged));
            _loc2_.addHabboConnectionMessageEvent(new FlatControllerAddedEvent(this.onFlatControllerAdded));
            _loc2_.addHabboConnectionMessageEvent(new FlatControllerRemovedEvent(this.onFlatControllerRemoved));
            _loc2_.addHabboConnectionMessageEvent(new NoSuchFlatEvent(this.onNoSuchFlat));
            _loc2_.addHabboConnectionMessageEvent(new RoomRatingEvent(this.onRoomRating));
            _loc2_.addHabboConnectionMessageEvent(new CanCreateRoomEvent(this.onCanCreateRoom));
            _loc2_.addHabboConnectionMessageEvent(new GenericErrorEvent(this.onError));
            _loc2_.addHabboConnectionMessageEvent(new DoorbellMessageEvent(this.onDoorbell));
            _loc2_.addHabboConnectionMessageEvent(new FlatAccessibleMessageEvent(this.onDoorOpened));
            _loc2_.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(this.onFlatAccessDenied));
            _loc2_.addHabboConnectionMessageEvent(new CantConnectMessageEvent(this.onCantConnect));
        }

        public function get data():NavigatorData
        {
            return (this._navigator.data);
        }

        private function onNoSuchFlat(param1:IMessageEvent):void
        {
        }

        private function onAuthOK(param1:IMessageEvent):void
        {
            this._navigator.onAuthOk();
        }

        private function onUserObject(param1:IMessageEvent):void
        {
            var _loc2_:UserObjectMessageParser = UserObjectEvent(param1).getParser();
            this.data.avatarId = _loc2_.id;
            this._navigator.send(new GetUserFlatCatsMessageComposer());
        }

        private function onUserRights(param1:IMessageEvent):void
        {
            var _loc2_:UserRightsMessageEvent = UserRightsMessageEvent(param1);
            if (_loc2_.securityLevel >= SecurityLevelEnum.var_446)
            {
                this._navigator.data.eventMod = true;
            };
            if (_loc2_.securityLevel >= SecurityLevelEnum.var_938)
            {
                this._navigator.data.roomPicker = true;
            };
        }

        private function onOfficialRooms(param1:IMessageEvent):void
        {
            var _loc2_:OfficialRoomsMessageParser = OfficialRoomsEvent(param1).getParser();
            this.data.officialRooms = _loc2_.data;
            this.data.adRoom = _loc2_.adRoom;
            Logger.log(("Received Official rooms: " + this.data.officialRooms.entries.length));
        }

        private function onGuestRoomSearchResult(param1:IMessageEvent):void
        {
            var _loc2_:GuestRoomSearchResultData = GuestRoomSearchResultEvent(param1).getParser().data;
            this.data.guestRoomSearchResults = _loc2_;
            Logger.log(("Received GuestRoomSearch: " + this.data.guestRoomSearchResults.rooms.length));
        }

        private function onPopularRoomTagsResult(param1:IMessageEvent):void
        {
            var _loc2_:PopularRoomTagsData = PopularRoomTagsResultEvent(param1).getParser().data;
            this.data.popularTags = _loc2_;
            Logger.log(("Received popular room tags: " + this.data.popularTags.tags.length));
        }

        private function onRoomEventEvent(param1:IMessageEvent):void
        {
            var _loc2_:RoomEventMessageParser = RoomEventEvent(param1).getParser();
            Logger.log(((("Got room event: " + _loc2_.data.ownerAvatarId) + ", ") + _loc2_.data.eventName));
            this.data.roomEventData = ((_loc2_.data.ownerAvatarId > 0) ? _loc2_.data : null);
            this._navigator.roomInfoViewCtrl.reload();
        }

        private function onCanCreateRoomEventEvent(param1:IMessageEvent):void
        {
            var _loc3_:SimpleAlertView;
            var _loc2_:CanCreateRoomEventMessageParser = CanCreateRoomEventEvent(param1).getParser();
            Logger.log(("CAN CREATE EVENT: " + _loc2_.canCreateEvent));
            if (_loc2_.canCreateEvent)
            {
                this._navigator.roomInfoViewCtrl.startEventEdit();
            }
            else
            {
                _loc3_ = new SimpleAlertView(this._navigator, "${navigator.cannotcreateevent.title}", (("${navigator.cannotcreateevent.error." + _loc2_.errorCode) + "}"));
                _loc3_.show();
                Logger.log("Cannot create an event just now...");
            };
        }

        private function onRoomEnter(param1:IMessageEvent):void
        {
            var _loc2_:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(param1).getParser();
            Logger.log("Navigator: entering room");
            this.data.onRoomEnter(_loc2_);
            this.closeOpenCantConnectAlerts();
            this._navigator.roomInfoViewCtrl.close();
            if (_loc2_.privateRoom)
            {
                this._navigator.send(new GetGuestRoomMessageComposer(_loc2_.guestRoomId, true, false));
                Logger.log("Sent get guest room...");
            }
            else
            {
                this.requestRoomEnterAd();
            };
        }

        private function onRoomInfo(param1:IMessageEvent):void
        {
            var _loc3_:Boolean;
            var _loc2_:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(param1).getParser();
            Logger.log(((("Got room info: " + _loc2_.enterRoom) + ", ") + _loc2_.roomForward));
            if (_loc2_.enterRoom)
            {
                this.data.enteredRoom = _loc2_.data;
                this.data.currentRoomIsStaffPick = _loc2_.staffPick;
                _loc3_ = (this.data.createdFlatId == _loc2_.data.flatId);
                if (((!(_loc3_)) && (_loc2_.data.displayRoomEntryAd)))
                {
                    this.requestRoomEnterAd();
                };
                this.data.createdFlatId = 0;
            }
            else
            {
                if (_loc2_.roomForward)
                {
                    if (((_loc2_.data.doorMode == RoomSettingsData.var_939) && (!(this._navigator.sessionData.userName == _loc2_.data.ownerName))))
                    {
                        this._navigator.doorbell.show(_loc2_.data);
                    }
                    else
                    {
                        if (((_loc2_.data.doorMode == RoomSettingsData.var_940) && (!(this._navigator.sessionData.userName == _loc2_.data.ownerName))))
                        {
                            this._navigator.passwordInput.show(_loc2_.data);
                        }
                        else
                        {
                            this._navigator.goToRoom(_loc2_.data.flatId, false);
                        };
                    };
                }
                else
                {
                    this.data.enteredRoom = _loc2_.data;
                    this.data.currentRoomIsStaffPick = _loc2_.staffPick;
                    this._navigator.roomInfoViewCtrl.reload();
                };
            };
        }

        private function requestRoomEnterAd():void
        {
            if (((this._navigator.configuration.getKey("roomenterad.habblet.enabled") == "true") && (ExternalInterface.available)))
            {
                ExternalInterface.call("FlashExternalInterface.openHabblet", "roomenterad", "");
            };
        }

        private function onPublicSpaceCastLibs(param1:IMessageEvent):void
        {
            var _loc2_:PublicSpaceCastLibsMessageParser = PublicSpaceCastLibsEvent(param1).getParser();
            Logger.log(((((("Got public space cast libs: " + _loc2_.nodeId) + ", ") + _loc2_.unitPort) + ", ") + _loc2_.castLibs));
            this._navigator.data.publicSpaceNodeId = _loc2_.nodeId;
            this._navigator.goToPublicSpace(_loc2_.unitPort, _loc2_.castLibs);
        }

        private function onFlatCreated(param1:IMessageEvent):void
        {
            var _loc2_:FlatCreatedMessageParser = FlatCreatedEvent(param1).getParser();
            ErrorReportStorage.addDebugData("IncomingEvent", ((("Flat created: " + _loc2_.flatId) + ", ") + _loc2_.flatName));
            this.data.createdFlatId = _loc2_.flatId;
            this._navigator.goToRoom(_loc2_.flatId, true);
            this._navigator.mainViewCtrl.reloadRoomList(Tabs.var_162);
        }

        private function onSubscriptionInfo(param1:IMessageEvent):void
        {
            var _loc2_:ScrSendUserInfoMessageParser = ScrSendUserInfoEvent(param1).getParser();
            Logger.log(((((((((("Got subscription info: " + _loc2_.productName) + ", ") + _loc2_.daysToPeriodEnd) + ", ") + _loc2_.memberPeriods) + ", ") + _loc2_.periodsSubscribedAhead) + ", ") + _loc2_.responseType));
            this.data.hcMember = (_loc2_.daysToPeriodEnd > 0);
        }

        private function onRoomForward(param1:IMessageEvent):void
        {
            var _loc2_:RoomForwardMessageParser = RoomForwardMessageEvent(param1).getParser();
            Logger.log(((("Got room forward: " + _loc2_.publicRoom) + ", ") + _loc2_.roomId));
            this.forwardToRoom(_loc2_.publicRoom, _loc2_.roomId);
        }

        private function onNavigatorSettings(param1:IMessageEvent):void
        {
            var _loc6_:Boolean;
            var _loc7_:Boolean;
            var _loc2_:NavigatorSettingsMessageParser = NavigatorSettingsEvent(param1).getParser();
            Logger.log(("Got navigator settings: " + _loc2_.homeRoomId));
            var _loc3_:* = (!(this._navigator.data.settingsReceived));
            this._navigator.data.homeRoomId = _loc2_.homeRoomId;
            this._navigator.data.settingsReceived = true;
            this._navigator.mainViewCtrl.refresh();
            var _loc4_:int = -1;
            var _loc5_:int = -1;
            if (_loc3_)
            {
                _loc6_ = false;
                if (this._navigator.configuration != null)
                {
                    if (this._navigator.configuration.keyExists("friend.id"))
                    {
                        _loc4_ = 0;
                        this._navigator.send(new FollowFriendMessageComposer(int(this._navigator.configuration.getKey("friend.id"))));
                    };
                    if (((this._navigator.configuration.keyExists("forward.type")) && (this._navigator.configuration.keyExists("forward.id"))))
                    {
                        _loc4_ = int(this._navigator.configuration.getKey("forward.type"));
                        _loc5_ = int(this._navigator.configuration.getKey("forward.id"));
                    };
                    if (parseInt(this._navigator.configuration.getKey("navigator.always_open_after_login")) == 1)
                    {
                        _loc6_ = true;
                    };
                };
                if (_loc4_ == 2)
                {
                    Logger.log(("Guest room forward on enter: " + _loc5_));
                    this.forwardToRoom(false, _loc5_);
                }
                else
                {
                    if (_loc4_ == 1)
                    {
                        Logger.log(("Public room forward on enter: " + _loc5_));
                        this.forwardToRoom(true, _loc5_);
                    }
                    else
                    {
                        if (_loc4_ == -1)
                        {
                            _loc7_ = this._navigator.goToHomeRoom();
                            if (!_loc7_)
                            {
                                _loc6_ = true;
                            };
                        };
                    };
                };
                if (((_loc6_) && (!(this._navigator.mainViewCtrl.isOpen()))))
                {
                    this._navigator.mainViewCtrl.onNavigatorToolBarIconClick();
                };
            }
            else
            {
                this._navigator.roomInfoViewCtrl.reload();
            };
        }

        private function onRoomExit(param1:IMessageEvent):void
        {
            Logger.log("Navigator: exiting room");
            this.data.onRoomExit();
            this._navigator.roomInfoViewCtrl.close();
            if (!this._navigator.mainViewCtrl.isOpen())
            {
                this._navigator.mainViewCtrl.onNavigatorToolBarIconClick();
            };
            if (ExternalInterface.available)
            {
                ExternalInterface.call("FlashExternalInterface.openHabblet", "news");
            };
        }

        private function onUserFlatCats(param1:IMessageEvent):void
        {
            var _loc2_:UserFlatCatsMessageParser = (param1 as UserFlatCatsEvent).getParser();
            this._navigator.data.categories = _loc2_.nodes;
            var _loc3_:RoomsTabPageDecorator = RoomsTabPageDecorator(this._navigator.tabs.getTab(Tabs.var_153).tabPageDecorator);
            _loc3_.prepareRoomCategories();
        }

        private function onRoomSettingsData(event:IMessageEvent):void
        {
            var parser:RoomSettingsDataMessageParser;
            var ctrl:RoomSettingsCtrl;
            try
            {
                parser = (event as RoomSettingsDataEvent).getParser();
                for each (ctrl in this._navigator.roomSettingsCtrls)
                {
                    ctrl.onRoomSettings(parser.data);
                };
                Logger.log(((((("GOT ROOM SETTINGS DATA: " + parser.data.name) + ", ") + parser.data.maximumVisitors) + ", ") + parser.data.maximumVisitorsLimit));
            }
            catch(e:Error)
            {
                Logger.log("CRASHED WHILE PROCESSING ROOM SETTINGS DATA!");
            };
        }

        private function onRoomSettingsError(param1:IMessageEvent):void
        {
            var _loc2_:RoomSettingsErrorMessageParser = (param1 as RoomSettingsErrorEvent).getParser();
        }

        private function onRoomSettingsSaved(param1:IMessageEvent):void
        {
            var _loc3_:RoomSettingsCtrl;
            var _loc2_:RoomSettingsSavedMessageParser = (param1 as RoomSettingsSavedEvent).getParser();
            ErrorReportStorage.addDebugData("IncomingEvent", ("Room settings saved: " + _loc2_.roomId));
            for each (_loc3_ in this._navigator.roomSettingsCtrls)
            {
                _loc3_.onRoomSettingsSaved(_loc2_.roomId);
            };
            this._navigator.mainViewCtrl.reloadRoomList(Tabs.var_162);
        }

        private function onRoomSettingsSaveError(param1:IMessageEvent):void
        {
            var _loc3_:RoomSettingsCtrl;
            var _loc2_:RoomSettingsSaveErrorMessageParser = (param1 as RoomSettingsSaveErrorEvent).getParser();
            for each (_loc3_ in this._navigator.roomSettingsCtrls)
            {
                _loc3_.onRoomSettingsSaveError(_loc2_.roomId, _loc2_.errorCode, _loc2_.info);
            };
        }

        private function onRoomInfoUpdated(param1:IMessageEvent):void
        {
            var _loc2_:RoomInfoUpdatedMessageParser = (param1 as RoomInfoUpdatedEvent).getParser();
            Logger.log(("ROOM UPDATED: " + _loc2_.flatId));
            this._navigator.send(new GetGuestRoomMessageComposer(_loc2_.flatId, false, false));
        }

        private function onThumbnailUpdated(param1:IMessageEvent):void
        {
            var _loc2_:RoomThumbnailUpdateResultMessageParser = (param1 as RoomThumbnailUpdateResultEvent).getParser();
            Logger.log(("THUMBNAIL UPDATED: " + _loc2_.resultCode));
            this._navigator.roomInfoViewCtrl.backToRoomSettings();
            this._navigator.send(new GetGuestRoomMessageComposer(_loc2_.flatId, false, false));
        }

        private function onFavourites(param1:IMessageEvent):void
        {
            var _loc2_:FavouritesMessageParser = (param1 as FavouritesEvent).getParser();
            Logger.log(((("Received favourites: " + _loc2_.limit) + ", ") + _loc2_.favouriteRoomIds.length));
            this._navigator.data.onFavourites(_loc2_);
        }

        private function onFavouriteChanged(param1:IMessageEvent):void
        {
            var _loc2_:FavouriteChangedMessageParser = (param1 as FavouriteChangedEvent).getParser();
            Logger.log(((("Received favourite changed: " + _loc2_.flatId) + ", ") + _loc2_.added));
            this._navigator.data.favouriteChanged(_loc2_.flatId, _loc2_.added);
            this._navigator.roomInfoViewCtrl.reload();
            this._navigator.mainViewCtrl.refresh();
        }

        private function onCanCreateRoom(param1:IMessageEvent):void
        {
            var _loc3_:AlertView;
            var _loc2_:CanCreateRoomMessageParser = (param1 as CanCreateRoomEvent).getParser();
            Logger.log(((("Can create room: " + _loc2_.resultCode) + ", ") + _loc2_.roomLimit));
            if (_loc2_.resultCode == 0)
            {
                this._navigator.roomCreateViewCtrl.show();
            }
            else
            {
                this._navigator.registerParameter("navigator.createroom.limitreached", "limit", ("" + _loc2_.roomLimit));
                if (this._navigator.sessionData.hasUserRight("fuse_can_create_more_rooms", HabboClubLevelEnum.var_114))
                {
                    _loc3_ = new SimpleAlertView(this._navigator, "${navigator.createroom.error}", "${navigator.createroom.limitreached}");
                }
                else
                {
                    _loc3_ = new ClubPromoAlertView(this._navigator, "${navigator.createroom.error}", "${navigator.createroom.limitreached}", "${navigator.createroom.vippromo}");
                };
                _loc3_.show();
            };
        }

        private function onFlatControllerAdded(param1:IMessageEvent):void
        {
            var _loc3_:RoomSettingsCtrl;
            var _loc2_:FlatControllerAddedMessageParser = (param1 as FlatControllerAddedEvent).getParser();
            Logger.log(((((("Flat controller added: " + _loc2_.flatId) + ", ") + _loc2_.data.userId) + ", ") + _loc2_.data.userName));
            for each (_loc3_ in this._navigator.roomSettingsCtrls)
            {
                _loc3_.onFlatControllerAdded(_loc2_.flatId, _loc2_.data);
            };
        }

        private function onFlatControllerRemoved(param1:IMessageEvent):void
        {
            var _loc3_:RoomSettingsCtrl;
            var _loc2_:FlatControllerRemovedMessageParser = (param1 as FlatControllerRemovedEvent).getParser();
            Logger.log(((("Flat controller removed: " + _loc2_.flatId) + ", ") + _loc2_.userId));
            for each (_loc3_ in this._navigator.roomSettingsCtrls)
            {
                _loc3_.onFlatControllerRemoved(_loc2_.flatId, _loc2_.userId);
            };
        }

        private function onError(param1:IMessageEvent):void
        {
            var _loc2_:GenericErrorEvent = (param1 as GenericErrorEvent);
            if (_loc2_ == null)
            {
                return;
            };
            switch (_loc2_.getParser().errorCode)
            {
                case -100002:
                    this._navigator.passwordInput.showRetry();
                    return;
            };
        }

        private function onDoorbell(param1:IMessageEvent):void
        {
            var _loc2_:DoorbellMessageEvent = (param1 as DoorbellMessageEvent);
            if (_loc2_ == null)
            {
                return;
            };
            if (_loc2_.userName != "")
            {
                return;
            };
            this._navigator.doorbell.showWaiting();
        }

        private function onDoorOpened(param1:IMessageEvent):void
        {
            var _loc2_:FlatAccessibleMessageEvent = (param1 as FlatAccessibleMessageEvent);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:FlatAccessibleMessageParser = _loc2_.getParser();
            if (((!(_loc3_ == null)) && ((_loc3_.userName == null) || (_loc3_.userName.length == 0))))
            {
                this._navigator.doorbell.hide();
            };
        }

        private function onRoomRating(param1:IMessageEvent):void
        {
            var _loc2_:RoomRatingMessageParser = (param1 as RoomRatingEvent).getParser();
            Logger.log(("Received room rating: " + _loc2_.rating));
            this._navigator.data.currentRoomRating = _loc2_.rating;
            this._navigator.roomInfoViewCtrl.reload();
        }

        private function onFlatAccessDenied(param1:IMessageEvent):void
        {
            var _loc2_:FlatAccessDeniedMessageParser = (param1 as FlatAccessDeniedMessageEvent).getParser();
            if (((_loc2_.userName == null) || (_loc2_.userName == "")))
            {
                this._navigator.doorbell.showNoAnswer();
            };
        }

        private function forwardToRoom(param1:Boolean, param2:int):void
        {
            this._navigator.send(((param1) ? new GetPublicSpaceCastLibsMessageComposer(param2) : new GetGuestRoomMessageComposer(param2, false, true)));
            this._navigator.trackNavigationDataPoint("Room Forward", "go.roomforward", "", param2);
        }

        private function closeOpenCantConnectAlerts():void
        {
            var _loc1_:Array;
            var _loc2_:IWindowContext;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:IWindow;
            var _loc6_:IWindow;
            var _loc7_:AlertView;
            if (this._navigator != null)
            {
                _loc1_ = new Array();
                _loc2_ = this._navigator.windowManager.getWindowContext(2);
                _loc3_ = _loc2_.getDesktopWindow().numChildren;
                _loc4_ = 0;
                while (_loc4_ < _loc3_)
                {
                    _loc5_ = _loc2_.getDesktopWindow().getChildAt(_loc4_);
                    if (_loc5_.tags.indexOf("SimpleAlertView") > -1)
                    {
                        _loc1_.push(_loc5_);
                    };
                    _loc4_++;
                };
                if (_loc1_.length > 0)
                {
                    for each (_loc6_ in _loc1_)
                    {
                        _loc7_ = AlertView.findAlertView(_loc6_);
                        if (_loc7_ != null)
                        {
                            _loc7_.dispose();
                        };
                    };
                };
            };
        }

        private function onCantConnect(param1:IMessageEvent):void
        {
            var _loc3_:SimpleAlertView;
            var _loc2_:CantConnectMessageParser = (param1 as CantConnectMessageEvent).getParser();
            Logger.log(("FAILED TO CONNECT: REASON: " + _loc2_.reason));
            switch (_loc2_.reason)
            {
                case CantConnectMessageParser.var_941:
                    _loc3_ = new SimpleAlertView(this._navigator, "${navigator.guestroomfull.title}", "${navigator.guestroomfull.text}");
                    _loc3_.show();
                    return;
                case CantConnectMessageParser.var_942:
                    _loc3_ = new SimpleAlertView(this._navigator, "${room.queue.error.title}", (("${room.queue.error." + _loc2_.parameter) + "}"));
                    _loc3_.show();
                    return;
                case CantConnectMessageParser.var_943:
                    _loc3_ = new SimpleAlertView(this._navigator, "${navigator.banned.title}", "${navigator.banned.text}");
                    _loc3_.show();
                    return;
                default:
                    _loc3_ = new SimpleAlertView(this._navigator, "${room.queue.error.title}", "${room.queue.error.title}");
                    _loc3_.show();
            };
        }


    }
}