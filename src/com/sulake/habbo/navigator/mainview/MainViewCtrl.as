package com.sulake.habbo.navigator.mainview
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.navigator.TextSearchInputs;
    import flash.utils.Timer;
    import com.sulake.habbo.utils.WindowToggle;
    import flash.events.TimerEvent;
    import com.sulake.habbo.navigator.domain.Tab;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.habbo.navigator.IViewCtrl;
    import flash.events.Event;
    import com.sulake.habbo.navigator.events.HabboNavigatorTrackingEvent;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetPopularRoomTagsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetOfficialRoomsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFavouriteRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFriendsRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomHistorySearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.PopularRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWhereMyFriendsAreSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWithHighestScoreSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTagSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTextSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.LatestEventsSearchMessageComposer;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;

    public class MainViewCtrl implements IUpdateReceiver, IDisposable 
    {

        public static const var_868:int = 1;
        public static const var_869:int = 2;
        public static const var_870:int = 3;
        public static const var_871:int = 4;
        private static const var_873:int = 1;
        private static const var_872:int = 2;
        private static const var_883:int = 3;
        private static const var_884:int = 4;
        private static const SCROLLBAR_WIDTH:int = 22;

        private const var_3343:Point = new Point(100, 10);

        private var _navigator:HabboNavigator;
        private var var_3966:IFrameWindow;
        private var var_2578:IWindowContainer;
        private var var_4291:IWindowContainer;
        private var var_3968:IWindowContainer;
        private var var_4292:IWindowContainer;
        private var var_4293:PopularTagsListCtrl;
        private var var_4294:GuestRoomListCtrl;
        private var var_4295:OfficialRoomListCtrl;
        private var var_4162:ITabContextWindow;
        private var var_4296:Boolean;
        private var var_4297:int;
        private var var_4298:Boolean = true;
        private var var_4299:int = 0;
        private var var_4300:IWindow;
        private var var_4301:IRegionWindow;
        private var var_4302:int = 0;
        private var var_4303:TextSearchInputs;
        private var var_4148:Timer;
        private var _disposed:Boolean = false;
        private var var_4304:WindowToggle;

        public function MainViewCtrl(param1:HabboNavigator):void
        {
            this._navigator = param1;
            this.var_4293 = new PopularTagsListCtrl(this._navigator);
            this.var_4294 = new GuestRoomListCtrl(this._navigator);
            this.var_4295 = new OfficialRoomListCtrl(this._navigator);
            this.var_4148 = new Timer(300, 1);
            this.var_4148.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function onNavigatorToolBarIconClick():Boolean
        {
            if (!this.var_3966)
            {
                this.reloadData();
                return (true);
            };
            if (((!(this.var_4304)) || (this.var_4304.disposed)))
            {
                this.var_4304 = new WindowToggle(this.var_3966, this.var_3966.desktop, this.reloadData, this.close);
            };
            var _loc1_:int = this.var_4304.toggle();
            return (_loc1_ == WindowToggle.RESULT_SHOW);
        }

        private function reloadData():void
        {
            var _loc1_:Tab = this._navigator.tabs.getSelected();
            _loc1_.tabPageDecorator.navigatorOpenedWhileInTab();
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this._navigator = null;
                if (this.var_3966)
                {
                    this.var_3966.dispose();
                    this.var_3966 = null;
                };
                if (this.var_4304)
                {
                    this.var_4304.dispose();
                    this.var_4304 = null;
                };
                if (this.var_2578)
                {
                    this.var_2578.dispose();
                    this.var_2578 = null;
                };
                if (this.var_4148)
                {
                    this.var_4148.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                    this.var_4148.reset();
                    this.var_4148 = null;
                };
                if (this.var_4293)
                {
                    this.var_4293.dispose();
                    this.var_4293 = null;
                };
                if (this.var_4294)
                {
                    this.var_4294.dispose();
                    this.var_4294 = null;
                };
                if (this.var_4295)
                {
                    this.var_4295.dispose();
                    this.var_4295 = null;
                };
                if (this.var_4303)
                {
                    this.var_4303.dispose();
                    this.var_4303 = null;
                };
            };
        }

        public function open():void
        {
            if (this.var_3966 == null)
            {
                this.prepare();
            };
            this.refresh();
            this.var_3966.visible = true;
            this.var_3966.activate();
        }

        public function isOpen():Boolean
        {
            return ((!(this.var_3966 == null)) && (this.var_3966.visible));
        }

        public function close():void
        {
            if (this.var_3966 != null)
            {
                this.var_3966.visible = false;
            };
        }

        public function get mainWindow():IFrameWindow
        {
            return (this.var_3966);
        }

        private function prepare():void
        {
            var _loc2_:Tab;
            var _loc3_:ITabButtonWindow;
            this.var_3966 = IFrameWindow(this._navigator.getXmlWindow("grs_main_window"));
            this.var_4162 = ITabContextWindow(this.var_3966.findChildByName("tab_context"));
            this.var_2578 = IWindowContainer(this.var_3966.findChildByName("tab_content"));
            this.var_4291 = IWindowContainer(this.var_3966.findChildByName("custom_content"));
            this.var_4292 = IWindowContainer(this.var_3966.findChildByName("list_content"));
            this.var_3968 = IWindowContainer(this.var_3966.findChildByName("custom_footer"));
            this.var_4300 = this.var_3966.findChildByName("loading_text");
            var _loc1_:IWindow = this.var_3966.findChildByTag("close");
            if (_loc1_ != null)
            {
                _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onWindowClose);
            };
            this.var_4301 = IRegionWindow(this.var_3966.findChildByName("to_hotel_view"));
            if (this.var_4301 != null)
            {
                this.var_4301.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onHotelViewMouseOver);
                this.var_4301.addEventListener(WindowMouseEvent.var_624, this.onHotelViewMouseOut);
                this.var_4301.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onHotelViewMouseClick);
            };
            this.refreshToHotelViewButton(false);
            this.var_3966.addEventListener(WindowEvent.var_589, this.onWindowResized);
            for each (_loc2_ in this._navigator.tabs.tabs)
            {
                _loc3_ = this.var_4162.getTabItemByID(_loc2_.id);
                if (_loc3_ != null)
                {
                    _loc3_.addEventListener(WindowEvent.var_576, this.onTabSelected);
                    _loc2_.button = _loc3_;
                };
            };
            this.var_3966.scaler.setParamFlag(HabboWindowParam.var_862, false);
            this.var_3966.scaler.setParamFlag(HabboWindowParam.var_861, true);
            this.var_3966.position = this.var_3343;
            this.createSearchInput();
        }

        private function createSearchInput():void
        {
            var _loc3_:IWindowContainer;
            var _loc1_:String = "search_header";
            if (this.var_4303 == null)
            {
                _loc3_ = (this.var_3966.findChildByName(_loc1_) as IWindowContainer);
                this.var_4303 = new TextSearchInputs(this._navigator, _loc3_);
            };
            var _loc2_:IWindowContainer = (this.var_3966.findChildByName(_loc1_) as IWindowContainer);
            _loc2_.visible = true;
        }

        public function refresh():void
        {
            if (this.var_3966 == null)
            {
                return;
            };
            this.refreshTab();
            this.refreshCustomContent();
            this.refreshListContent(true);
            this.refreshFooter();
            this.var_4291.height = Util.getLowestPoint(this.var_4291);
            this.var_3968.height = Util.getLowestPoint(this.var_3968);
            var _loc1_:int = this.var_4292.y;
            Util.moveChildrenToColumn(this.var_2578, ["custom_content", "list_content"], this.var_4291.y, 8);
            this.var_4292.height = ((((this.var_4292.height + _loc1_) - this.var_4292.y) - this.var_3968.height) + this.var_4302);
            Util.moveChildrenToColumn(this.var_2578, ["list_content", "custom_footer"], this.var_4292.y, 0);
            this.var_4302 = this.var_3968.height;
            this.onResizeTimer(null);
        }

        private function refreshTab():void
        {
            var _loc1_:Tab = this._navigator.tabs.getSelected();
            var _loc2_:ISelectableWindow = this.var_4162.selector.getSelected();
            if (_loc1_.button != _loc2_)
            {
                this.var_4296 = true;
                this.var_4162.selector.setSelected(_loc1_.button);
            };
        }

        private function refreshCustomContent():void
        {
            Util.hideChildren(this.var_4291);
            var _loc1_:Tab = this._navigator.tabs.getSelected();
            _loc1_.tabPageDecorator.refreshCustomContent(this.var_4291);
            if (Util.hasVisibleChildren(this.var_4291))
            {
                this.var_4291.visible = true;
            }
            else
            {
                this.var_4291.visible = false;
                this.var_4291.blend = 1;
            };
        }

        private function refreshFooter():void
        {
            Util.hideChildren(this.var_3968);
            var _loc1_:Tab = this._navigator.tabs.getSelected();
            _loc1_.tabPageDecorator.refreshFooter(this.var_3968);
            if (Util.hasVisibleChildren(this.var_3968))
            {
                this.var_3968.visible = true;
            }
            else
            {
                this.var_3968.visible = false;
            };
        }

        private function refreshListContent(param1:Boolean):void
        {
            Util.hideChildren(this.var_4292);
            this.refreshGuestRooms(param1, this._navigator.data.guestRoomSearchArrived);
            this.refreshPopularTags(param1, this._navigator.data.popularTagsArrived);
            this.refreshOfficialRooms(param1, this._navigator.data.officialRoomsArrived);
        }

        private function refreshGuestRooms(param1:Boolean, param2:Boolean):void
        {
            this.refreshList(param1, param2, this.var_4294, "guest_rooms");
        }

        private function refreshPopularTags(param1:Boolean, param2:Boolean):void
        {
            this.refreshList(param1, param2, this.var_4293, "popular_tags");
        }

        private function refreshOfficialRooms(param1:Boolean, param2:Boolean):void
        {
            this.refreshList(param1, param2, this.var_4295, "official_rooms");
        }

        private function refreshList(param1:Boolean, param2:Boolean, param3:IViewCtrl, param4:String):void
        {
            var _loc5_:IWindow;
            if (param2)
            {
                if (param3.content == null)
                {
                    _loc5_ = this.var_4292.findChildByName(param4);
                    param3.content = IWindowContainer(_loc5_);
                };
                if (param1)
                {
                    param3.refresh();
                };
                param3.content.visible = true;
            };
        }

        private function onWindowClose(param1:WindowEvent):void
        {
            Logger.log("Close navigator window");
            this.close();
        }

        private function onTabSelected(param1:WindowEvent):void
        {
            var _loc2_:IWindow = param1.target;
            var _loc3_:int = _loc2_.id;
            if (this.var_4296)
            {
                this.var_4296 = false;
                return;
            };
            var _loc4_:Tab = this._navigator.tabs.getTab(_loc3_);
            _loc4_.sendSearchRequest();
            switch (_loc4_.id)
            {
                case Tabs.var_154:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS));
                    return;
                case Tabs.var_152:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME));
                    return;
                case Tabs.var_151:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL));
                    return;
                case Tabs.var_153:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS));
                    return;
                case Tabs.var_155:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH));
                    return;
            };
        }

        public function reloadRoomList(param1:int):Boolean
        {
            ErrorReportStorage.addDebugData("MainViewCtrl", "Reloading RoomList");
            if ((((this.isOpen()) && (!(this._navigator.data.guestRoomSearchResults == null))) && (this._navigator.data.guestRoomSearchResults.searchType == param1)))
            {
                this.startSearch(this._navigator.tabs.getSelected().id, param1, "");
                return (true);
            };
            return (false);
        }

        public function startSearch(param1:int, param2:int, param3:String="-1", param4:int=1):void
        {
            var _loc5_:Tab = this._navigator.tabs.getSelected();
            this._navigator.tabs.setSelectedTab(param1);
            var _loc6_:Tab = this._navigator.tabs.getSelected();
            ErrorReportStorage.addDebugData("StartSearch", ((("Start search " + _loc5_.id) + " => ") + _loc6_.id));
            this.var_4298 = (!(_loc5_ == _loc6_));
            if (_loc5_ != _loc6_)
            {
                _loc6_.tabPageDecorator.tabSelected();
            };
            this._navigator.data.startLoading();
            if (param4 == var_868)
            {
                this._navigator.send(this.getSearchMsg(param2, param3));
            }
            else
            {
                if (param4 == var_869)
                {
                    this._navigator.send(new GetPopularRoomTagsMessageComposer());
                }
                else
                {
                    this._navigator.send(new GetOfficialRoomsMessageComposer(this._navigator.data.adIndex));
                };
            };
            if (!this.isOpen())
            {
                this.open();
                this.var_4297 = var_872;
                this.var_4292.blend = 0;
                if (this.var_4291.visible)
                {
                    this.var_4291.blend = 0;
                    this.var_3968.blend = 0;
                };
            }
            else
            {
                this.var_4297 = var_873;
            };
            this.var_4299 = 0;
            this._navigator.registerUpdateReceiver(this, 2);
            this.sendTrackingEvent(param2);
        }

        private function sendTrackingEvent(param1:int):void
        {
            switch (param1)
            {
                case Tabs.var_874:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS));
                    return;
                case Tabs.var_875:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES));
                    return;
                case Tabs.var_876:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS));
                    return;
                case Tabs.var_877:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY));
                    return;
                case Tabs.var_162:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS));
                    return;
                case Tabs.var_878:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS));
                    return;
                case Tabs.var_879:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS));
                    return;
                case Tabs.var_880:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE));
                    return;
                case Tabs.var_881:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE));
                    return;
                case Tabs.var_161:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH));
                    return;
                case Tabs.var_882:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH));
                    return;
            };
        }

        private function getSearchMsg(param1:int, param2:String):IMessageComposer
        {
            if (param1 == Tabs.var_875)
            {
                return (new MyFavouriteRoomsSearchMessageComposer());
            };
            if (param1 == Tabs.var_876)
            {
                return (new MyFriendsRoomsSearchMessageComposer());
            };
            if (param1 == Tabs.var_877)
            {
                return (new MyRoomHistorySearchMessageComposer());
            };
            if (param1 == Tabs.var_162)
            {
                return (new MyRoomsSearchMessageComposer());
            };
            if (param1 == Tabs.var_879)
            {
                return (new PopularRoomsSearchMessageComposer(param2, this._navigator.data.adIndex));
            };
            if (param1 == Tabs.var_880)
            {
                return (new RoomsWhereMyFriendsAreSearchMessageComposer());
            };
            if (param1 == Tabs.var_881)
            {
                return (new RoomsWithHighestScoreSearchMessageComposer(this._navigator.data.adIndex));
            };
            if (param1 == Tabs.var_161)
            {
                return (new RoomTagSearchMessageComposer(param2));
            };
            if (param1 == Tabs.var_882)
            {
                return (new RoomTextSearchMessageComposer(param2));
            };
            if (param1 == Tabs.var_874)
            {
                return (new LatestEventsSearchMessageComposer(param2, this._navigator.data.adIndex));
            };
            Logger.log(("No message for searchType: " + param1));
            return (null);
        }

        public function update(param1:uint):void
        {
            var _loc3_:Number;
            if (this.var_4292 == null)
            {
                return;
            };
            var _loc2_:Number = (param1 / 150);
            if (this.var_4297 == var_873)
            {
                _loc3_ = Math.min(1, Math.max(0, (this.var_4292.blend - _loc2_)));
                this.var_4292.blend = _loc3_;
                this.var_4291.blend = ((this.var_4298) ? _loc3_ : 1);
                this.var_3968.blend = ((this.var_4298) ? _loc3_ : 1);
                if (_loc3_ == 0)
                {
                    this.var_4297 = var_872;
                };
            }
            else
            {
                if (this.var_4297 == var_872)
                {
                    if ((this.var_4299 % 10) == 1)
                    {
                        this.var_4300.visible = (!(this.var_4300.visible));
                    };
                    this.var_4299++;
                    if (!this._navigator.data.isLoading())
                    {
                        this.var_4297 = var_883;
                    };
                }
                else
                {
                    if (this.var_4297 == var_883)
                    {
                        this.refresh();
                        this.var_4297 = var_884;
                    }
                    else
                    {
                        this.var_4300.visible = false;
                        _loc3_ = Math.min(1, Math.max(0, (this.var_4292.blend + _loc2_)));
                        this.var_4292.blend = _loc3_;
                        this.var_4291.blend = ((this.var_4298) ? _loc3_ : 1);
                        this.var_3968.blend = ((this.var_4298) ? _loc3_ : 1);
                        if (this.var_4292.blend >= 1)
                        {
                            this._navigator.removeUpdateReceiver(this);
                        };
                    };
                };
            };
        }

        private function onWindowResized(param1:WindowEvent):void
        {
            var _loc2_:IWindow = param1.target;
            if (_loc2_ != this.var_3966)
            {
                return;
            };
            if (!this.var_4148.running)
            {
                this.var_4148.reset();
                this.var_4148.start();
            };
        }

        private function onResizeTimer(param1:TimerEvent):void
        {
            this.refreshScrollbar(this.var_4293);
            this.refreshScrollbar(this.var_4294);
        }

        private function refreshScrollbar(param1:IViewCtrl):void
        {
            if (((param1.content == null) || (!(param1.content.visible))))
            {
                return;
            };
            var _loc2_:IItemListWindow = IItemListWindow(param1.content.findChildByName("item_list"));
            var _loc3_:IWindow = param1.content.findChildByName("scroller");
            var _loc4_:* = (_loc2_.scrollableRegion.height > _loc2_.height);
            if (_loc3_.visible)
            {
                if (_loc4_)
                {
                    return;
                };
                _loc3_.visible = false;
                _loc2_.width = (_loc2_.width + SCROLLBAR_WIDTH);
            }
            else
            {
                if (_loc4_)
                {
                    _loc3_.visible = true;
                    _loc2_.width = (_loc2_.width - SCROLLBAR_WIDTH);
                }
                else
                {
                    return;
                };
            };
        }

        public function stretchNewEntryIfNeeded(param1:IViewCtrl, param2:IWindowContainer):void
        {
            var _loc3_:IWindow = param1.content.findChildByName("scroller");
            if (_loc3_.visible)
            {
                return;
            };
            param2.width = (param2.width + SCROLLBAR_WIDTH);
        }

        private function refreshToHotelViewButton(param1:Boolean):void
        {
            this._navigator.refreshButton(this.var_4301, "icon_hotelview", (!(param1)), null, 0);
            this._navigator.refreshButton(this.var_4301, "icon_hotelview_reactive", param1, null, 0);
        }

        private function onHotelViewMouseOver(param1:WindowEvent):void
        {
            this.refreshToHotelViewButton(true);
        }

        private function onHotelViewMouseOut(param1:WindowEvent):void
        {
            this.refreshToHotelViewButton(false);
        }

        private function onHotelViewMouseClick(param1:WindowEvent):void
        {
            this._navigator.send(new QuitMessageComposer());
        }


    }
}