package com.sulake.habbo.navigator.inroom
{
    import com.sulake.habbo.navigator.roomsettings.IRoomSettingsCtrlOwner;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
    import com.sulake.habbo.navigator.roomthumbnails.RoomThumbnailCtrl;
    import com.sulake.habbo.navigator.TagRenderer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import com.sulake.habbo.navigator.events.HabboRoomSettingsTrackingEvent;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.navigator.SimpleAlertView;
    import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateEventMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateNavigatorSettingsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RateFlatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.ToggleStaffPickMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.navigator.events.HabboNavigatorEvent;
    import com.sulake.habbo.navigator.*;

    public class RoomInfoViewCtrl implements IRoomSettingsCtrlOwner 
    {

        private const var_1245:int = 75;
        private const var_1247:int = 3;
        private const var_1249:int = 45;

        private var _navigator:HabboNavigator;
        private var _window:IWindowContainer;
        private var var_2578:IWindowContainer;
        private var var_4254:int;
        private var var_4255:RoomEventViewCtrl;
        private var var_4253:Timer;
        private var var_4252:RoomSettingsCtrl;
        private var var_4256:RoomThumbnailCtrl;
        private var var_4257:TagRenderer;
        private var var_4258:IWindowContainer;
        private var var_4259:IWindowContainer;
        private var var_4260:IWindowContainer;
        private var var_4261:IWindowContainer;
        private var var_4262:IWindowContainer;
        private var var_4263:IWindowContainer;
        private var var_3463:ITextWindow;
        private var var_4264:ITextWindow;
        private var _ownerName:ITextWindow;
        private var var_4265:ITextWindow;
        private var var_4266:ITextWindow;
        private var var_4267:ITextWindow;
        private var var_4268:ITextWindow;
        private var var_3770:ITextWindow;
        private var var_4269:IWindowContainer;
        private var var_4270:IWindowContainer;
        private var var_4271:IWindowContainer;
        private var var_3504:ITextWindow;
        private var var_4272:ITextWindow;
        private var var_4273:IWindow;
        private var var_4274:IContainerButtonWindow;
        private var var_4275:IContainerButtonWindow;
        private var var_4276:IContainerButtonWindow;
        private var _remFavouriteButton:IContainerButtonWindow;
        private var var_4277:IContainerButtonWindow;
        private var var_4278:IButtonWindow;
        private var var_4279:IButtonWindow;
        private var var_4280:IButtonWindow;
        private var var_4281:IWindowContainer;
        private var var_4282:ITextWindow;
        private var var_4283:ITextFieldWindow;
        private var _buttons:IWindowContainer;
        private var var_4284:IButtonWindow;
        private var var_4285:Boolean = false;

        public function RoomInfoViewCtrl(param1:HabboNavigator)
        {
            this._navigator = param1;
            this.var_4255 = new RoomEventViewCtrl(this._navigator);
            this.var_4252 = new RoomSettingsCtrl(this._navigator, this, true);
            this.var_4256 = new RoomThumbnailCtrl(this._navigator);
            this.var_4257 = new TagRenderer(this._navigator);
            this._navigator.roomSettingsCtrls.push(this.var_4252);
            this.var_4253 = new Timer(6000, 1);
            this.var_4253.addEventListener(TimerEvent.TIMER, this.hideInfo);
        }

        public function dispose():void
        {
            if (this.var_4253)
            {
                this.var_4253.removeEventListener(TimerEvent.TIMER, this.hideInfo);
                this.var_4253.reset();
                this.var_4253 = null;
            };
            this._navigator = null;
            this.var_4255 = null;
            this.var_4252 = null;
            this.var_4256 = null;
            if (this.var_4257)
            {
                this.var_4257.dispose();
                this.var_4257 = null;
            };
            this.var_2578 = null;
            this.var_4258 = null;
            this.var_4259 = null;
            this.var_4260 = null;
            this.var_4261 = null;
            this.var_4262 = null;
            this.var_4263 = null;
            this.var_3463 = null;
            this.var_4264 = null;
            this._ownerName = null;
            this.var_4265 = null;
            this.var_4266 = null;
            this.var_4267 = null;
            this.var_4268 = null;
            this.var_3770 = null;
            this.var_4269 = null;
            this.var_4270 = null;
            this.var_4271 = null;
            this.var_3504 = null;
            this.var_4272 = null;
            this.var_4273 = null;
            this.var_4274 = null;
            this.var_4275 = null;
            this.var_4276 = null;
            this._remFavouriteButton = null;
            this.var_4277 = null;
            this.var_4278 = null;
            this.var_4279 = null;
            this.var_4280 = null;
            this.var_4281 = null;
            this.var_4282 = null;
            this.var_4283 = null;
            this._buttons = null;
            this.var_4284 = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        public function roomSettingsRefreshNeeded():void
        {
            this.refresh();
        }

        public function startEventEdit():void
        {
            this.var_4253.reset();
            this.var_4255.active = true;
            this.var_4252.active = false;
            this.var_4256.active = false;
            this.reload();
        }

        public function startRoomSettingsEdit(param1:int):void
        {
            this.var_4253.reset();
            this.var_4252.load(param1);
            this.var_4252.active = true;
            this.var_4255.active = false;
            this.var_4256.active = false;
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
        }

        public function backToRoomSettings():void
        {
            this.var_4252.active = true;
            this.var_4255.active = false;
            this.var_4256.active = false;
            this.reload();
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
        }

        public function startThumbnailEdit():void
        {
            this.var_4253.reset();
            this.var_4252.active = false;
            this.var_4255.active = false;
            this.var_4256.active = true;
            this.reload();
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS));
        }

        public function close():void
        {
            if (this._window == null)
            {
                return;
            };
            this._window.visible = false;
            this.var_4285 = false;
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED));
        }

        public function reload():void
        {
            if (((!(this._window == null)) && (this._window.visible)))
            {
                this.refresh();
            };
        }

        public function toggle():void
        {
            this.var_4253.reset();
            this.var_4255.active = false;
            this.var_4252.active = false;
            this.var_4256.active = false;
            this.refresh();
            this._window.visible = (!(this._window.visible));
            this._window.x = ((this._window.desktop.width - this._window.width) - this.var_1247);
            this._window.y = this.var_1245;
            if (((this._navigator.configuration.getBoolean("club.membership.extend.vip.promotion.enabled", false)) || (this._navigator.configuration.getBoolean("club.membership.extend.basic.promotion.enabled", false))))
            {
                this._window.y = 91;
            };
            if (this._window.visible)
            {
                this._window.activate();
            };
        }

        private function refresh():void
        {
            this.prepareWindow();
            this.refreshRoom();
            this.refreshEvent();
            this.refreshEmbed();
            this.refreshButtons();
            Util.moveChildrenToColumn(this.var_2578, ["room_info", "event_info", "embed_info", "buttons_container"], 0, 2);
            this.var_2578.height = Util.getLowestPoint(this.var_2578);
            var _loc1_:int = ((this._window.desktop.height - this._window.height) - this.var_1249);
            if (this._window.y > _loc1_)
            {
                this._window.y = ((_loc1_ < 0) ? 0 : _loc1_);
            };
        }

        private function refreshRoom():void
        {
            Util.hideChildren(this.var_4258);
            var _loc1_:GuestRoomData = this._navigator.data.enteredGuestRoom;
            var _loc2_:Boolean = ((!(_loc1_ == null)) && (_loc1_.flatId == this._navigator.data.homeRoomId));
            this.refreshRoomDetails(_loc1_, _loc2_);
            this.refreshPublicSpaceDetails(this._navigator.data.enteredPublicSpace);
            this.refreshRoomButtons(_loc2_);
            this.var_4252.refresh(this.var_4258);
            this.var_4256.refresh(this.var_4258);
            Util.moveChildrenToColumn(this.var_4258, ["room_details", "room_buttons"], 0, 2);
            this.var_4258.height = Util.getLowestPoint(this.var_4258);
            this.var_4258.visible = true;
            Logger.log(((((((((("XORP: " + this.var_4259.visible) + ", ") + this.var_4263.visible) + ", ") + this.var_4260.visible) + ", ") + this.var_4260.rectangle) + ", ") + this.var_4258.rectangle));
        }

        private function refreshEvent():void
        {
            Util.hideChildren(this.var_4269);
            var _loc1_:RoomEventData = this._navigator.data.roomEventData;
            this.refreshEventDetails(_loc1_);
            this.refreshEventButtons(_loc1_);
            this.var_4255.refresh(this.var_4269);
            if (((Util.hasVisibleChildren(this.var_4269)) && (!((this.var_4252.active) || (this.var_4256.active)))))
            {
                Util.moveChildrenToColumn(this.var_4269, ["event_details", "event_buttons"], 0, 2);
                this.var_4269.height = Util.getLowestPoint(this.var_4269);
                this.var_4269.visible = true;
            }
            else
            {
                this.var_4269.visible = false;
            };
            Logger.log(((("EVENT: " + this.var_4269.visible) + ", ") + this.var_4269.rectangle));
        }

        private function refreshEmbed():void
        {
            var _loc1_:* = (this._navigator.configuration.getKey("embed.showInRoomInfo", "false") == "true");
            var _loc2_:* = (!(this._navigator.data.enteredGuestRoom == null));
            if ((((((_loc2_) && (_loc1_)) && (!(this.var_4252.active))) && (!(this.var_4256.active))) && (!(this.var_4255.active))))
            {
                this.var_4281.visible = true;
                this.var_4283.text = this.getEmbedData();
            }
            else
            {
                this.var_4281.visible = false;
            };
        }

        private function refreshButtons():void
        {
            var _loc1_:Boolean;
            if (!this._buttons)
            {
                return;
            };
            if (this.var_4252.active)
            {
                this._buttons.visible = false;
                return;
            };
            this._buttons.visible = true;
            if (this.var_4284)
            {
                _loc1_ = (!(this._navigator.data.enteredGuestRoom == null));
                this.var_4284.visible = _loc1_;
                if (this.var_4285)
                {
                    this.var_4284.caption = ("$" + "{navigator.zoom.in}");
                }
                else
                {
                    this.var_4284.caption = ("$" + "{navigator.zoom.out}");
                };
            };
        }

        private function refreshRoomDetails(param1:GuestRoomData, param2:Boolean):void
        {
            if ((((param1 == null) || (this.var_4252.active)) || (this.var_4256.active)))
            {
                return;
            };
            this.var_3463.text = param1.roomName;
            this.var_3463.height = (this.var_3463.textHeight + 5);
            this._ownerName.text = param1.ownerName;
            this.var_4265.text = param1.description;
            this.var_4257.refreshTags(this.var_4259, param1.tags);
            this.var_4265.visible = false;
            if (param1.description != "")
            {
                this.var_4265.height = (this.var_4265.textHeight + 5);
                this.var_4265.visible = true;
            };
            var _loc3_:Boolean = Boolean((this._navigator.configuration.getKey("client.allow.facebook.like") == "1"));
            this._navigator.refreshButton(this.var_4275, "facebook_logo_small", _loc3_, null, 0);
            this.var_4275.visible = _loc3_;
            var _loc4_:* = (this._navigator.data.currentRoomRating == -1);
            this._navigator.refreshButton(this.var_4274, "thumb_up", _loc4_, null, 0);
            this.var_4274.visible = _loc4_;
            this.var_4268.visible = (!(_loc4_));
            this.var_3770.visible = (!(_loc4_));
            this.var_3770.text = ("" + this._navigator.data.currentRoomRating);
            this.refreshStuffPick();
            this._navigator.refreshButton(this.var_4259, "home", param2, null, 0);
            this._navigator.refreshButton(this.var_4259, "favourite", ((!(param2)) && (this._navigator.data.isCurrentRoomFavourite())), null, 0);
            Util.moveChildrenToColumn(this.var_4259, ["room_name", "owner_name_cont", "tags", "room_desc", "rating_cont", "staff_pick_button"], this.var_3463.y, 0);
            this.var_4259.visible = true;
            this.var_4259.height = Util.getLowestPoint(this.var_4259);
        }

        private function refreshStuffPick():void
        {
            var _loc1_:IWindow = this.var_4259.findChildByName("staff_pick_button");
            if (!this._navigator.data.roomPicker)
            {
                _loc1_.visible = false;
                return;
            };
            _loc1_.visible = true;
            _loc1_.caption = this._navigator.getText(((this._navigator.data.currentRoomIsStaffPick) ? "navigator.staffpicks.unpick" : "navigator.staffpicks.pick"));
        }

        private function refreshPublicSpaceDetails(param1:PublicRoomShortData):void
        {
            if ((((param1 == null) || (this.var_4252.active)) || (this.var_4256.active)))
            {
                return;
            };
            this.var_4264.text = this._navigator.getPublicSpaceName(param1.unitPropertySet, param1.worldId);
            this.var_4264.height = (this.var_4264.textHeight + 5);
            this.var_4266.text = this._navigator.getPublicSpaceDesc(param1.unitPropertySet, param1.worldId);
            this.var_4266.height = (this.var_4266.textHeight + 5);
            Util.moveChildrenToColumn(this.var_4260, ["public_space_name", "public_space_desc"], this.var_4264.y, 0);
            this.var_4260.visible = true;
            this.var_4260.height = Math.max(86, Util.getLowestPoint(this.var_4260));
        }

        private function refreshEventDetails(param1:RoomEventData):void
        {
            if (((param1 == null) || (this.var_4255.active)))
            {
                return;
            };
            this.var_3504.text = param1.eventName;
            this.var_4272.text = param1.eventDescription;
            this.var_4257.refreshTags(this.var_4270, [this._navigator.getText(("roomevent_type_" + param1.eventType)), param1.tags[0], param1.tags[1]]);
            this.var_4272.visible = false;
            if (param1.eventDescription != "")
            {
                this.var_4272.height = (this.var_4272.textHeight + 5);
                this.var_4272.y = (Util.getLowestPoint(this.var_4270) + 2);
                this.var_4272.visible = true;
            };
            this.var_4270.visible = true;
            this.var_4270.height = Util.getLowestPoint(this.var_4270);
        }

        private function refreshRoomButtons(param1:Boolean):void
        {
            if ((((this._navigator.data.enteredGuestRoom == null) || (this.var_4252.active)) || (this.var_4256.active)))
            {
                return;
            };
            this.var_4278.visible = this._navigator.data.canEditRoomSettings;
            var _loc2_:Boolean = this._navigator.data.isCurrentRoomFavourite();
            this.var_4276.visible = ((this._navigator.data.canAddFavourite) && (!(_loc2_)));
            this._remFavouriteButton.visible = ((this._navigator.data.canAddFavourite) && (_loc2_));
            this.var_4277.visible = ((this._navigator.data.canEditRoomSettings) && (!(param1)));
            this.var_4263.visible = Util.hasVisibleChildren(this.var_4263);
        }

        private function refreshEventButtons(param1:RoomEventData):void
        {
            if (this.var_4255.active)
            {
                return;
            };
            this.var_4279.visible = ((param1 == null) && (this._navigator.data.currentRoomOwner));
            this.var_4280.visible = ((!(param1 == null)) && ((this._navigator.data.currentRoomOwner) || (this._navigator.data.eventMod)));
            this.var_4271.visible = Util.hasVisibleChildren(this.var_4271);
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            this._window = IWindowContainer(this._navigator.getXmlWindow("iro_room_details_framed"));
            this.var_2578 = (this._window.findChildByName("content") as IWindowContainer);
            this._window.visible = false;
            this.var_4258 = IWindowContainer(this.find("room_info"));
            this.var_4259 = IWindowContainer(this.find("room_details"));
            this.var_4260 = IWindowContainer(this.find("public_space_details"));
            this.var_4261 = IWindowContainer(this.find("owner_name_cont"));
            this.var_4262 = IWindowContainer(this.find("rating_cont"));
            this.var_4263 = IWindowContainer(this.find("room_buttons"));
            this.var_3463 = ITextWindow(this.find("room_name"));
            this.var_4264 = ITextWindow(this.find("public_space_name"));
            this._ownerName = ITextWindow(this.find("owner_name"));
            this.var_4265 = ITextWindow(this.find("room_desc"));
            this.var_4266 = ITextWindow(this.find("public_space_desc"));
            this.var_4267 = ITextWindow(this.find("owner_caption"));
            this.var_4268 = ITextWindow(this.find("rating_caption"));
            this.var_3770 = ITextWindow(this.find("rating_txt"));
            this.var_4269 = IWindowContainer(this.find("event_info"));
            this.var_4270 = IWindowContainer(this.find("event_details"));
            this.var_4271 = IWindowContainer(this.find("event_buttons"));
            this.var_3504 = ITextWindow(this.find("event_name"));
            this.var_4272 = ITextWindow(this.find("event_desc"));
            this.var_4275 = IContainerButtonWindow(this.find("facebook_like_button"));
            this.var_4274 = IContainerButtonWindow(this.find("rate_up_button"));
            this.var_4273 = this.find("staff_pick_button");
            this.var_4276 = IContainerButtonWindow(this.find("add_favourite_button"));
            this._remFavouriteButton = IContainerButtonWindow(this.find("rem_favourite_button"));
            this.var_4277 = IContainerButtonWindow(this.find("make_home_button"));
            this.var_4278 = IButtonWindow(this.find("room_settings_button"));
            this.var_4279 = IButtonWindow(this.find("create_event_button"));
            this.var_4280 = IButtonWindow(this.find("edit_event_button"));
            this.var_4281 = IWindowContainer(this.find("embed_info"));
            this.var_4282 = ITextWindow(this.find("embed_info_txt"));
            this.var_4283 = ITextFieldWindow(this.find("embed_src_txt"));
            this._buttons = IWindowContainer(this.find("buttons_container"));
            this.var_4284 = IButtonWindow(this.find("zoom_button"));
            this.addMouseClickListener(this.var_4276, this.onAddFavouriteClick);
            this.addMouseClickListener(this._remFavouriteButton, this.onRemoveFavouriteClick);
            this.addMouseClickListener(this.var_4278, this.onRoomSettingsClick);
            this.addMouseClickListener(this.var_4277, this.onMakeHomeClick);
            this.addMouseClickListener(this.var_4279, this.onEventSettingsClick);
            this.addMouseClickListener(this.var_4280, this.onEventSettingsClick);
            this.addMouseClickListener(this.var_4283, this.onEmbedSrcClick);
            this.addMouseClickListener(this.var_4274, this.onThumbUp);
            this.addMouseClickListener(this.var_4273, this.onStaffPick);
            this.addMouseClickListener(this.var_4275, this.onFacebookLike);
            this.addMouseClickListener(this.var_4284, this.onZoomClick);
            this._navigator.refreshButton(this.var_4276, "favourite", true, null, 0);
            this._navigator.refreshButton(this._remFavouriteButton, "favourite", true, null, 0);
            this._navigator.refreshButton(this.var_4277, "home", true, null, 0);
            this.addMouseClickListener(this._window.findChildByTag("close"), this.onCloseButtonClick);
            this.addMouseOverListener(this.var_4258, this.onHover);
            this.addMouseOverListener(this.var_4269, this.onHover);
            this.var_4267.width = this.var_4267.textWidth;
            Util.moveChildrenToRow(this.var_4261, ["owner_caption", "owner_name"], this.var_4267.x, this.var_4267.y, 3);
            this.var_4268.width = this.var_4268.textWidth;
            Util.moveChildrenToRow(this.var_4262, ["rating_caption", "rating_txt"], this.var_4268.x, this.var_4268.y, 3);
            this.var_4282.height = (this.var_4282.textHeight + 5);
            Util.moveChildrenToColumn(this.var_4281, ["embed_info_txt", "embed_src_txt"], this.var_4282.y, 2);
            this.var_4281.height = (Util.getLowestPoint(this.var_4281) + 5);
            this.var_4254 = (this._window.y + this._window.height);
        }

        private function addMouseClickListener(param1:IWindow, param2:Function):void
        {
            if (param1 != null)
            {
                param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, param2);
            };
        }

        private function addMouseOverListener(param1:IWindow, param2:Function):void
        {
            if (param1 != null)
            {
                param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, param2);
            };
        }

        private function find(param1:String):IWindow
        {
            var _loc2_:IWindow = this._window.findChildByName(param1);
            if (_loc2_ == null)
            {
                throw (new Error((("Window element with name: " + param1) + " cannot be found!")));
            };
            return (_loc2_);
        }

        public function onAddFavouriteClick(param1:WindowEvent):void
        {
            var _loc2_:SimpleAlertView;
            if (this._navigator.data.enteredGuestRoom == null)
            {
                return;
            };
            if (this._navigator.data.isFavouritesFull())
            {
                _loc2_ = new SimpleAlertView(this._navigator, "${navigator.favouritesfull.title}", "${navigator.favouritesfull.body}");
                _loc2_.show();
            }
            else
            {
                this._navigator.send(new AddFavouriteRoomMessageComposer(this._navigator.data.enteredGuestRoom.flatId));
            };
        }

        public function onRemoveFavouriteClick(param1:WindowEvent):void
        {
            if (this._navigator.data.enteredGuestRoom == null)
            {
                return;
            };
            this._navigator.send(new DeleteFavouriteRoomMessageComposer(this._navigator.data.enteredGuestRoom.flatId));
        }

        private function onEventSettingsClick(param1:WindowEvent):void
        {
            if (this._navigator.data.roomEventData == null)
            {
                if (this._navigator.data.currentRoomOwner)
                {
                    this._navigator.send(new CanCreateEventMessageComposer());
                };
            }
            else
            {
                this.startEventEdit();
            };
        }

        private function onRoomSettingsClick(param1:WindowEvent):void
        {
            var _loc2_:GuestRoomData = this._navigator.data.enteredGuestRoom;
            if (_loc2_ == null)
            {
                Logger.log("No entered room data?!");
                return;
            };
            this.startRoomSettingsEdit(_loc2_.flatId);
        }

        private function onMakeHomeClick(param1:WindowEvent):void
        {
            var _loc2_:GuestRoomData = this._navigator.data.enteredGuestRoom;
            if (_loc2_ == null)
            {
                Logger.log("No entered room data?!");
                return;
            };
            Logger.log(("SETTING HOME ROOM TO: " + _loc2_.flatId));
            this._navigator.send(new UpdateNavigatorSettingsMessageComposer(_loc2_.flatId));
        }

        private function onCloseButtonClick(param1:WindowEvent):void
        {
            this.hideInfo(null);
        }

        private function onThumbUp(param1:WindowEvent):void
        {
            this._navigator.send(new RateFlatMessageComposer(1));
        }

        private function onStaffPick(param1:WindowEvent):void
        {
            this._navigator.send(new ToggleStaffPickMessageComposer(this._navigator.data.enteredGuestRoom.flatId, this._navigator.data.currentRoomIsStaffPick));
        }

        private function onFacebookLike(param1:WindowEvent):void
        {
            HabboWebTools.facebookLike(this._navigator.data.enteredGuestRoom.flatId);
        }

        private function onEmbedSrcClick(param1:WindowEvent):void
        {
            this.var_4283.setSelection(0, this.var_4283.text.length);
        }

        private function onZoomClick(param1:WindowEvent):void
        {
            this._navigator.events.dispatchEvent(new HabboNavigatorEvent(HabboNavigatorEvent.var_46));
            this.var_4285 = (!(this.var_4285));
            this.refreshButtons();
        }

        private function onHover(param1:WindowEvent):void
        {
            this.var_4253.reset();
        }

        private function hideInfo(param1:Event):void
        {
            this._window.visible = false;
            if (this.var_4252 != null)
            {
                this.var_4252.resetView();
            };
        }

        private function getEmbedData():String
        {
            var _loc1_:String;
            var _loc2_:String;
            if (this._navigator.data.enteredGuestRoom != null)
            {
                _loc1_ = "private";
                _loc2_ = ("" + this._navigator.data.enteredGuestRoom.flatId);
            }
            else
            {
                _loc1_ = "public";
                _loc2_ = ("" + this._navigator.data.publicSpaceNodeId);
                Logger.log(("Node id is: " + _loc2_));
            };
            var _loc3_:String = this._navigator.configuration.getKey("user.hash", "");
            this._navigator.registerParameter("navigator.embed.src", "roomType", _loc1_);
            this._navigator.registerParameter("navigator.embed.src", "embedCode", _loc3_);
            this._navigator.registerParameter("navigator.embed.src", "roomId", _loc2_);
            return (this._navigator.getText("navigator.embed.src"));
        }


    }
}