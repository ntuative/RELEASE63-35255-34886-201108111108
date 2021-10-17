package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.navigator.RoomPopupCtrl;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.habbo.navigator.UserCountRenderer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomSettingsFlatInfo;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;

    public class GuestRoomListCtrl implements IViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var var_2578:IWindowContainer;
        private var var_2632:IItemListWindow;
        private var var_4286:RoomPopupCtrl;
        private var var_2713:IScrollbarWindow;
        private var var_4287:UserCountRenderer;
        private var var_4288:IWindowContainer;
        private var var_4289:int;
        private var var_4290:Boolean;

        public function GuestRoomListCtrl(param1:HabboNavigator):void
        {
            this._navigator = param1;
            this.var_4286 = new RoomPopupCtrl(this._navigator, 5, -5);
            this.var_4287 = new UserCountRenderer(this._navigator);
        }

        public function dispose():void
        {
            if (this.var_4286)
            {
                this.var_4286.dispose();
                this.var_4286 = null;
            };
            if (this.var_4287)
            {
                this.var_4287.dispose();
                this.var_4287 = null;
            };
        }

        public function set content(param1:IWindowContainer):void
        {
            this.var_2578 = param1;
            this.var_2632 = IItemListWindow(this.var_2578.findChildByName("item_list"));
            this.var_2713 = IScrollbarWindow(this.var_2578.findChildByName("scroller"));
        }

        public function get content():IWindowContainer
        {
            return (this.var_2578);
        }

        public function refresh():void
        {
            var _loc4_:Boolean;
            var _loc1_:Array = this._navigator.data.guestRoomSearchResults.rooms;
            var _loc2_:int = this.getVisibleEntryCount();
            this.var_2632.autoArrangeItems = false;
            var _loc3_:int;
            while (true)
            {
                if (_loc3_ < _loc1_.length)
                {
                    this.refreshEntry(true, _loc3_, _loc1_[_loc3_]);
                }
                else
                {
                    _loc4_ = this.refreshEntry(false, _loc3_, null);
                    if (_loc4_) break;
                };
                _loc3_++;
            };
            this.var_2632.autoArrangeItems = true;
            if (this.getVisibleEntryCount() != _loc2_)
            {
                this.var_2713.scrollV = 0;
            };
            this.var_2578.findChildByName("no_rooms_found").visible = (_loc1_.length < 1);
        }

        private function getVisibleEntryCount():int
        {
            var _loc1_:int;
            var _loc2_:int;
            while (_loc2_ < this.var_2632.numListItems)
            {
                if (this.var_2632.getListItemAt(_loc2_).visible)
                {
                    _loc1_++;
                };
                _loc2_++;
            };
            return (_loc1_);
        }

        private function getListEntry(param1:int):IWindowContainer
        {
            var _loc2_:IWindowContainer = IWindowContainer(this._navigator.getXmlWindow("grs_guest_room_details_short"));
            _loc2_.background = true;
            _loc2_.addEventListener(WindowMouseEvent.var_654, this.onMouseMove);
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseOver);
            _loc2_.addEventListener(WindowMouseEvent.var_624, this.onMouseOut);
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
            _loc2_.setParamFlag(HabboWindowParam.var_158, true);
            _loc2_.setParamFlag(HabboWindowParam.var_837, true);
            _loc2_.color = this.getBgColor(param1);
            _loc2_.tags.push(param1);
            return (_loc2_);
        }

        private function getBgColor(param1:int):uint
        {
            return (((param1 % 2) != 0) ? 0xFFFFFFFF : 4292797682);
        }

        private function refreshEntry(param1:Boolean, param2:int, param3:GuestRoomData):Boolean
        {
            var _loc4_:IWindowContainer = IWindowContainer(this.var_2632.getListItemAt(param2));
            var _loc5_:Boolean;
            if (_loc4_ == null)
            {
                if (!param1)
                {
                    return (true);
                };
                _loc4_ = this.getListEntry(param2);
                this.var_2632.addListItem(_loc4_);
                _loc5_ = true;
            };
            Util.hideChildren(_loc4_);
            if (param1)
            {
                this.refreshEntryDetails(_loc4_, param3);
                _loc4_.visible = true;
                _loc4_.height = 17;
            }
            else
            {
                _loc4_.height = 0;
                _loc4_.visible = false;
            };
            if (_loc5_)
            {
                this._navigator.mainViewCtrl.stretchNewEntryIfNeeded(this, _loc4_);
            };
            return (false);
        }

        public function refreshEntryDetails(param1:IWindowContainer, param2:GuestRoomData):void
        {
            param1.visible = true;
            Util.hideChildren(param1);
            this.refreshFavouriteIcon(param1, param2);
            this._navigator.refreshButton(param1, "home", this.isHome(param2), null, 0);
            this._navigator.refreshButton(param1, "doormode_doorbell_small", (param2.doorMode == RoomSettingsFlatInfo.var_939), null, 0);
            this._navigator.refreshButton(param1, "doormode_password_small", (param2.doorMode == RoomSettingsFlatInfo.var_940), null, 0);
            this.refreshRoomName(param1, param2);
            this.var_4287.refreshUserCount(param2.maxUserCount, param1, param2.userCount, "${navigator.usercounttooltip.users}", 233, 2);
        }

        private function refreshRoomName(param1:IWindowContainer, param2:GuestRoomData):void
        {
            var _loc3_:ITextWindow = ITextWindow(param1.getChildByName("roomname"));
            _loc3_.visible = true;
            var _loc4_:Boolean = (((param1.findChildByName("home").visible) || (param1.findChildByName("favourite").visible)) || (param1.findChildByName("make_favourite").visible));
            Util.cutTextToWidth(_loc3_, param2.roomName, ((_loc4_) ? (_loc3_.width - 20) : _loc3_.width));
        }

        private function onMouseMove(param1:WindowEvent):void
        {
            this.checkFastHorizontalMove(param1);
        }

        private function onMouseOver(param1:WindowEvent):void
        {
            var _loc2_:IWindow = param1.target;
            if (((this.var_4286.visible) && (this.var_4290)))
            {
                return;
            };
            this.hilite(IWindowContainer(_loc2_));
            var _loc3_:int = _loc2_.tags[0];
            if (this._navigator.data.guestRoomSearchResults == null)
            {
                Logger.log("No guest room search results while room entry mouse over");
                return;
            };
            var _loc4_:GuestRoomData = this._navigator.data.guestRoomSearchResults.rooms[_loc3_];
            if (_loc4_ == null)
            {
                Logger.log(((("No room found " + _loc3_) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                return;
            };
            this.var_4286.room = _loc4_;
            this.var_4286.showPopup(_loc2_);
        }

        private function onMouseOut(param1:WindowEvent):void
        {
            var _loc2_:IWindow = param1.target;
            if (Util.containsMouse(_loc2_))
            {
                Logger.log(("Mouse entered contained element: " + _loc2_.rectangle));
                return;
            };
            var _loc3_:int = _loc2_.tags[0];
            _loc2_.color = this.getBgColor(_loc3_);
            this.var_4286.closePopup();
        }

        private function onMouseClick(param1:WindowEvent):void
        {
            var _loc5_:Point;
            var _loc2_:IWindow = param1.target;
            var _loc3_:int = _loc2_.tags[0];
            if (this._navigator.data.guestRoomSearchResults == null)
            {
                Logger.log("No guest room search results while room entry mouse click");
                return;
            };
            var _loc4_:GuestRoomData = this._navigator.data.guestRoomSearchResults.rooms[_loc3_];
            if (_loc4_ == null)
            {
                Logger.log(((("No room found " + _loc3_) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                return;
            };
            if (_loc4_.ownerName != this._navigator.sessionData.userName)
            {
                _loc5_ = new Point((param1 as WindowMouseEvent).stageX, (param1 as WindowMouseEvent).stageY);
                switch (_loc4_.doorMode)
                {
                    case RoomSettingsFlatInfo.var_940:
                        this._navigator.passwordInput.show(_loc4_, _loc5_);
                        return;
                    case RoomSettingsFlatInfo.var_939:
                        this._navigator.doorbell.show(_loc4_, _loc5_);
                        return;
                };
            };
            this._navigator.goToRoom(_loc4_.flatId, true, "", _loc3_);
            this.var_4286.hideInstantly();
        }

        private function refreshFavouriteIcon(param1:IWindowContainer, param2:GuestRoomData):void
        {
            var _loc3_:Boolean = this._navigator.data.isRoomFavourite(param2.flatId);
            var _loc4_:Boolean = this.isHome(param2);
            this.refreshRegion(param1, "make_favourite", ((!(_loc3_)) && (!(_loc4_))), this.onAddFavouriteClick);
            this.refreshRegion(param1, "favourite", ((_loc3_) && (!(_loc4_))), this.onRemoveFavouriteClick);
        }

        private function isHome(param1:GuestRoomData):Boolean
        {
            return (param1.flatId == this._navigator.data.homeRoomId);
        }

        private function refreshRegion(param1:IWindowContainer, param2:String, param3:Boolean, param4:Function):void
        {
            var _loc5_:IRegionWindow = (param1.findChildByName(param2) as IRegionWindow);
            if (!param3)
            {
                _loc5_.visible = false;
                if (_loc5_.hasEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK))
                {
                    _loc5_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, param4);
                };
            }
            else
            {
                _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, param4);
                _loc5_.visible = true;
                this._navigator.refreshButton(_loc5_, param2, param3, null, 0);
            };
        }

        private function onRemoveFavouriteClick(param1:WindowMouseEvent):void
        {
            var _loc2_:IWindow = param1.target;
            if (((_loc2_ == null) || (_loc2_.parent == null)))
            {
                return;
            };
            if (((this._navigator == null) || (this._navigator.data == null)))
            {
                return;
            };
            if (((this._navigator.data.guestRoomSearchResults == null) || (this._navigator.data.guestRoomSearchResults.rooms == null)))
            {
                return;
            };
            var _loc3_:int = int(_loc2_.parent.tags[0]);
            var _loc4_:GuestRoomData = this._navigator.data.guestRoomSearchResults.rooms[_loc3_];
            if (_loc4_ == null)
            {
                Logger.log(((("No room found at index " + _loc3_) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                return;
            };
            this._navigator.send(new DeleteFavouriteRoomMessageComposer(_loc4_.flatId));
        }

        private function onAddFavouriteClick(param1:WindowMouseEvent):void
        {
            var _loc2_:IWindow = param1.target;
            if (((_loc2_ == null) || (_loc2_.parent == null)))
            {
                return;
            };
            if (((this._navigator == null) || (this._navigator.data == null)))
            {
                return;
            };
            if (((this._navigator.data.guestRoomSearchResults == null) || (this._navigator.data.guestRoomSearchResults.rooms == null)))
            {
                return;
            };
            var _loc3_:int = int(_loc2_.parent.tags[0]);
            var _loc4_:GuestRoomData = this._navigator.data.guestRoomSearchResults.rooms[_loc3_];
            if (_loc4_ == null)
            {
                Logger.log(((("No room found " + _loc3_) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                return;
            };
            this._navigator.send(new AddFavouriteRoomMessageComposer(_loc4_.flatId));
        }

        private function hilite(param1:IWindowContainer):void
        {
            var _loc2_:int;
            if (this.var_4288 != null)
            {
                _loc2_ = this.var_4288.tags[0];
                this.var_4288.color = this.getBgColor(_loc2_);
            };
            this.var_4288 = param1;
            param1.color = 4288861930;
        }

        private function checkFastHorizontalMove(param1:WindowEvent):void
        {
            var _loc2_:WindowMouseEvent = WindowMouseEvent(param1);
            var _loc3_:int = Math.abs((this.var_4289 - _loc2_.stageX));
            this.var_4289 = _loc2_.stageX;
            this.var_4290 = (_loc3_ > 2);
        }


    }
}