package com.sulake.habbo.session
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import flash.geom.Matrix;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupsWhereMemberMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.SelectFavouriteHabboGroupMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.DeselectFavouriteHabboGroupMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class GroupDetailsView 
    {

        public static const var_448:String = "HabboGroups";

        private var var_4984:SessionDataManager;
        private var _window:IWindowContainer;
        private var var_2632:IItemListWindow;
        private var var_3204:HabboGroupDetailsData;
        private var var_4418:Matrix = new Matrix();

        public function GroupDetailsView(param1:SessionDataManager)
        {
            this.var_4984 = param1;
            this.var_4418.scale(2, 2);
            this.var_4984.events.addEventListener(BadgeImageReadyEvent.var_100, this.onBadgeImageReady);
        }

        public static function moveChildrenToColumn(param1:IWindowContainer, param2:Array, param3:int, param4:int):void
        {
            var _loc5_:String;
            var _loc6_:IWindow;
            for each (_loc5_ in param2)
            {
                _loc6_ = param1.getChildByName(_loc5_);
                if ((((!(_loc6_ == null)) && (_loc6_.visible)) && (_loc6_.height > 0)))
                {
                    _loc6_.y = param3;
                    param3 = (param3 + (_loc6_.height + param4));
                };
            };
        }

        public static function getLowestPoint(param1:IWindowContainer):int
        {
            var _loc4_:IWindow;
            var _loc2_:int;
            var _loc3_:int;
            while (_loc3_ < param1.numChildren)
            {
                _loc4_ = param1.getChildAt(_loc3_);
                if (_loc4_.visible)
                {
                    _loc2_ = Math.max(_loc2_, (_loc4_.y + _loc4_.height));
                };
                _loc3_++;
            };
            return (_loc2_);
        }


        public function onBadgeImageReady(param1:BadgeImageReadyEvent):void
        {
            var _loc3_:IWindowContainer;
            var _loc4_:IBitmapWrapperWindow;
            if ((((!(this._window == null)) && (!(this.var_3204 == null))) && (param1.badgeId == this.var_3204.badgeCode)))
            {
                this.refreshBadgeImage();
            };
            var _loc2_:int;
            while (_loc2_ < this.var_2632.numListItems)
            {
                _loc3_ = IWindowContainer(this.var_2632.getListItemAt(_loc2_));
                _loc4_ = (_loc3_.findChildByName("group_entry_logo") as IBitmapWrapperWindow);
                if (_loc4_.tags[0] == param1.badgeId)
                {
                    if (_loc4_.bitmap == null)
                    {
                        _loc4_.bitmap = new BitmapData(_loc4_.width, _loc4_.height);
                    };
                    _loc4_.bitmap.fillRect(_loc4_.bitmap.rect, 0xFFFFFF);
                    _loc4_.bitmap.draw(param1.badgeImage);
                    _loc4_.invalidate(_loc4_.rectangle);
                };
                _loc2_++;
            };
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            this._window = IFrameWindow(this.var_4984.getXmlWindow("group_info"));
            this._window.findChildByTag("close").procedure = this.onClose;
            this.setProc("group_homepage_link_region", this.onHomepageLink);
            this.setProc("group_room_link_region", this.onRoomLink);
            this._window.findChildByName("join_button").procedure = this.onJoin;
            this._window.findChildByName("my_groups_region").procedure = this.onMyGroups;
            this.var_2632 = IItemListWindow(this._window.findChildByName("groups_item_list"));
            this._window.center();
        }

        private function setVisibleContainer(param1:String, param2:String):void
        {
            this.prepareWindow();
            this._window.caption = this.var_4984.localization.getKey(param2, param2);
            this._window.findChildByName("groups_container").visible = false;
            this._window.findChildByName("group_container").visible = false;
            this._window.findChildByName(param1).visible = true;
        }

        public function onGroups(param1:Array):void
        {
            this.setVisibleContainer("groups_container", "group.owngroups.title");
            this.refreshGroups(param1);
        }

        private function refreshGroups(param1:Array):void
        {
            var _loc3_:Boolean;
            this.var_2632.autoArrangeItems = false;
            var _loc2_:int;
            while (true)
            {
                if (_loc2_ < param1.length)
                {
                    this.refreshEntry(true, _loc2_, param1[_loc2_]);
                }
                else
                {
                    _loc3_ = this.refreshEntry(false, _loc2_, null);
                    if (_loc3_) break;
                };
                _loc2_++;
            };
            this.var_2632.autoArrangeItems = true;
        }

        private function getListEntry(param1:int):IWindowContainer
        {
            var _loc2_:IRegionWindow = IRegionWindow(this.var_4984.getXmlWindow("group_entry"));
            _loc2_.findChildByName("bg").color = this.getBgColor(param1);
            _loc2_.procedure = this.onSelectGroup;
            this.setImageButton(_loc2_, "make_favourite", this.onMakeFavourite, "make_favourite");
            this.setImageButton(_loc2_, "clear_favourite", this.onClearFavourite, "clear_favourite");
            return (_loc2_);
        }

        private function setImageButton(param1:IRegionWindow, param2:String, param3:Function, param4:String):void
        {
            var _loc5_:IRegionWindow = IRegionWindow(param1.findChildByName(param2));
            _loc5_.procedure = param3;
            var _loc6_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc5_.findChildByName("icon"));
            _loc6_.bitmap = this.var_4984.getButtonImage(param4);
        }

        private function getBgColor(param1:int):uint
        {
            return (((param1 % 2) != 0) ? 0xFFFFFFFF : 4292797682);
        }

        private function refreshEntry(param1:Boolean, param2:int, param3:HabboGroupEntryData):Boolean
        {
            var _loc4_:IWindowContainer = IWindowContainer(this.var_2632.getListItemAt(param2));
            if (_loc4_ == null)
            {
                if (!param1)
                {
                    return (true);
                };
                _loc4_ = this.getListEntry(param2);
                this.var_2632.addListItem(_loc4_);
            };
            if (param1)
            {
                this.refreshEntryDetails(_loc4_, param3);
                _loc4_.visible = true;
                _loc4_.height = 43;
            }
            else
            {
                _loc4_.height = 0;
                _loc4_.visible = false;
            };
            return (false);
        }

        public function refreshEntryDetails(param1:IWindowContainer, param2:HabboGroupEntryData):void
        {
            param1.findChildByName("group_name_txt").caption = param2.groupName;
            param1.id = param2.groupId;
            this.refreshEntryBadgeImage(param1, param2);
            param1.findChildByName("clear_favourite").visible = param2.favourite;
            param1.findChildByName("make_favourite").visible = (!(param2.favourite));
        }

        public function onGroupDetails(param1:HabboGroupDetailsData):void
        {
            this.var_3204 = param1;
            this.setVisibleContainer("group_container", "group.title");
            this._window.findChildByName("group_name").caption = param1.groupName;
            var _loc2_:ITextWindow = ITextWindow(this._window.findChildByName("group_description"));
            _loc2_.caption = param1.description;
            _loc2_.height = (_loc2_.textHeight + 5);
            this._window.findChildByName("join_button").visible = (param1.status == HabboGroupDetailsData.var_1751);
            this._window.findChildByName("membership_pending_txt").visible = (param1.status == HabboGroupDetailsData.var_1752);
            this.var_4984.windowManager.registerLocalizationParameter("group.membercount", "totalMembers", ("" + param1.totalMembers));
            this._window.findChildByName("group_room_link_region").visible = (param1.roomId > -1);
            this.var_4984.windowManager.registerLocalizationParameter("group.room.link", "room_name", param1.roomName);
            this.refreshBadgeImage();
            var _loc3_:IWindowContainer = IWindowContainer(this._window.findChildByName("group_container"));
            moveChildrenToColumn(_loc3_, ["group_header", "group_description", "group_footer"], 0, 0);
            var _loc4_:int = _loc3_.height;
            _loc3_.height = getLowestPoint(_loc3_);
            this._window.height = (this._window.height + (_loc3_.height - _loc4_));
            this._window.visible = true;
        }

        private function refreshBadgeImage():void
        {
            var _loc1_:IBitmapWrapperWindow = (this._window.findChildByName("group_logo") as IBitmapWrapperWindow);
            if (_loc1_.bitmap == null)
            {
                _loc1_.bitmap = new BitmapData(_loc1_.width, _loc1_.height);
            };
            var _loc2_:BitmapData = this.var_4984.getGroupBadgeImage(this.var_3204.badgeCode);
            _loc1_.bitmap.fillRect(_loc1_.bitmap.rect, 0xFFFFFF);
            if (_loc2_ != null)
            {
                _loc1_.bitmap.draw(_loc2_, this.var_4418);
                _loc1_.invalidate(_loc1_.rectangle);
            };
        }

        private function refreshEntryBadgeImage(param1:IWindowContainer, param2:HabboGroupEntryData):void
        {
            var _loc3_:IBitmapWrapperWindow = (param1.findChildByName("group_entry_logo") as IBitmapWrapperWindow);
            if (_loc3_.tags[0] == param2.badgeCode)
            {
                return;
            };
            _loc3_.tags[0] = param2.badgeCode;
            if (_loc3_.bitmap == null)
            {
                _loc3_.bitmap = new BitmapData(_loc3_.width, _loc3_.height);
            };
            var _loc4_:BitmapData = this.var_4984.getGroupBadgeImage(param2.badgeCode);
            _loc3_.bitmap.fillRect(_loc3_.bitmap.rect, 0xFFFFFF);
            if (_loc4_ != null)
            {
                _loc3_.bitmap.draw(_loc4_);
                _loc3_.invalidate(_loc3_.rectangle);
            };
        }

        private function setProc(param1:String, param2:Function):void
        {
            var _loc3_:IWindow = this._window.findChildByName(param1);
            _loc3_.mouseThreshold = 0;
            _loc3_.procedure = param2;
        }

        private function onMyGroups(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_4984.send(new GetHabboGroupsWhereMemberMessageComposer());
            this.var_4984.send(new EventLogMessageComposer(var_448, "", "my groups"));
        }

        private function onSelectGroup(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_4984.showGroupBadgeInfo(param2.id);
            this.var_4984.send(new EventLogMessageComposer(var_448, ("" + param2.id), "select"));
        }

        private function onJoin(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_4984.send(new JoinHabboGroupMessageComposer(this.var_3204.groupId));
            this.var_4984.send(new EventLogMessageComposer(var_448, ("" + this.var_3204.groupId), "join"));
        }

        private function onMakeFavourite(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_4984.send(new SelectFavouriteHabboGroupMessageComposer(param2.parent.id));
            this.var_4984.send(new EventLogMessageComposer(var_448, ("" + param2.parent.id), "make favourite"));
        }

        private function onClearFavourite(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_4984.send(new DeselectFavouriteHabboGroupMessageComposer(param2.parent.id));
            this.var_4984.send(new EventLogMessageComposer(var_448, ("" + param2.parent.id), "clear favourite"));
        }

        private function onHomepageLink(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:String = this.var_4984.configuration.getKey("group.homepage.url", "http://%predefined%/groups/%groupid%/id");
            _loc3_ = _loc3_.replace("%groupid%", this.var_3204.groupId);
            this.openExternalLink(_loc3_);
            this.var_4984.send(new EventLogMessageComposer(var_448, ("" + this.var_3204.groupId), "homepage"));
        }

        private function onRoomLink(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_4984.roomSessionManager.gotoRoom(false, this.var_3204.roomId);
            this.close();
            this.var_4984.send(new EventLogMessageComposer(var_448, ("" + this.var_3204.groupId), "base"));
        }

        private function onClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.close();
        }

        public function close():void
        {
            if (this._window != null)
            {
                this._window.visible = false;
            };
        }

        private function openExternalLink(param1:String):void
        {
            if (param1 != "")
            {
                this.var_4984.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.onExternalLink);
                HabboWebTools.navigateToURL(param1, "_empty");
            };
        }

        private function onExternalLink(param1:IAlertDialog, param2:WindowEvent):void
        {
            param1.dispose();
        }


    }
}