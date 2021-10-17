package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.domain.FriendListTab;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IItemListWindow;

    public class FriendListTabsView 
    {

        private var _friendList:HabboFriendList;
        private var var_2578:IWindowContainer;

        public function FriendListTabsView(param1:HabboFriendList)
        {
            this._friendList = param1;
        }

        public function prepare(param1:IWindowContainer):void
        {
            this.var_2578 = param1;
            this.refresh("prepare");
        }

        public function refresh(param1:String):void
        {
            var _loc3_:FriendListTab;
            var _loc4_:IWindowContainer;
            var _loc5_:int;
            Logger.log(("TABS: REFRESH: " + param1));
            this.var_2578.width = this._friendList.tabs.tabContentWidth;
            this.var_2578.findChildByName("bg").width = this._friendList.tabs.tabContentWidth;
            var _loc2_:int = 1;
            for each (_loc3_ in this._friendList.tabs.getTabs())
            {
                _loc4_ = (this.var_2578.getChildByName(("flt_" + _loc3_.id)) as IWindowContainer);
                if (!this.isTabVisible(_loc3_.id))
                {
                    _loc4_.visible = false;
                }
                else
                {
                    _loc4_.visible = true;
                    _loc4_.width = this._friendList.tabs.tabContentWidth;
                    _loc4_.y = _loc2_;
                    _loc5_ = this.refreshHeader(_loc3_, _loc4_);
                    this.refreshTabContent(_loc3_, _loc4_);
                    _loc4_.height = (_loc5_ + ((_loc3_.selected) ? this._friendList.tabs.tabContentHeight : 0));
                    _loc2_ = (_loc2_ + _loc4_.height);
                };
            };
            this.var_2578.height = (_loc2_ + 1);
            this.var_2578.findChildByName("bg").height = this.var_2578.height;
            Logger.log("TABS: REFRESH END");
        }

        private function isTabVisible(param1:int):Boolean
        {
            if (param1 != FriendListTab.var_536)
            {
                return (true);
            };
            return (this._friendList.friendRequests.requests.length > 0);
        }

        private function refreshTabContent(param1:FriendListTab, param2:IWindowContainer):void
        {
            if (param1.selected)
            {
                if (param1.view == null)
                {
                    param1.view = (this.getTabContent(param1) as IWindowContainer);
                };
                this.refreshTabContentDims(param1.view);
                this.refreshScrollBarVisibility(param1.view);
                param2.addChild(param1.view);
            }
            else
            {
                if (param1.view != null)
                {
                    param2.removeChild(param1.view);
                };
            };
        }

        private function refreshHeader(param1:FriendListTab, param2:IWindowContainer):int
        {
            var _loc3_:IWindowContainer = (param2.getChildByName("header") as IWindowContainer);
            _loc3_.width = this._friendList.tabs.tabContentWidth;
            this.showBgImage(_loc3_, param1.newMessageArrived, "hdr_hilite");
            this.showBgImage(_loc3_, (!(param1.newMessageArrived)), param1.headerPicName);
            var _loc4_:Boolean = ((param1.id == FriendListTab.var_535) && (!(param1.newMessageArrived)));
            Logger.log(((((("TAB " + param1.id) + ", ") + param1.name) + ", ") + _loc4_));
            this.refreshArrowIcon(_loc3_, "arrow_down_black", ((param1.selected) && (_loc4_)), 12);
            this.refreshArrowIcon(_loc3_, "arrow_right_black", ((!(param1.selected)) && (_loc4_)), 15);
            this.refreshArrowIcon(_loc3_, "arrow_down_white", ((param1.selected) && (!(_loc4_))), 12);
            this.refreshArrowIcon(_loc3_, "arrow_right_white", ((!(param1.selected)) && (!(_loc4_))), 15);
            this.refreshTabText(param1, _loc3_);
            return (_loc3_.height);
        }

        private function showBgImage(param1:IWindowContainer, param2:Boolean, param3:String):void
        {
            Logger.log(((("REFRESHING BG IMAGE: " + param2) + ", ") + param3));
            var _loc4_:IBitmapWrapperWindow = (param1.getChildByName(param3) as IBitmapWrapperWindow);
            if (!param2)
            {
                if (_loc4_ != null)
                {
                    _loc4_.visible = false;
                };
            }
            else
            {
                if (_loc4_.bitmap == null)
                {
                    _loc4_.bitmap = this._friendList.getButtonImage(param3);
                    _loc4_.height = _loc4_.bitmap.height;
                    param1.height = _loc4_.bitmap.height;
                    _loc4_.procedure = this.onTabClick;
                };
                _loc4_.width = this._friendList.tabs.tabContentWidth;
                _loc4_.visible = true;
            };
        }

        private function refreshArrowIcon(param1:IWindowContainer, param2:String, param3:Boolean, param4:int):void
        {
            var _loc5_:ITextWindow;
            var _loc6_:IWindow;
            this._friendList.refreshButton(param1, param2, param3, null, 0);
            if (param3)
            {
                _loc5_ = ITextWindow(param1.findChildByName("caption_text"));
                _loc6_ = IWindow(param1.findChildByName(param2));
                _loc6_.x = (_loc5_.textWidth + param4);
            };
        }

        private function refreshTabText(param1:FriendListTab, param2:IWindowContainer):void
        {
            var _loc3_:ITextWindow = (param2.findChildByName("caption_text") as ITextWindow);
            _loc3_.text = (((param1.name + " (") + param1.tabView.getEntryCount()) + ")");
            _loc3_.textColor = this._friendList.laf.getTabTextColor(param1.newMessageArrived, param1.id);
        }

        private function onTabClick(param1:WindowEvent, param2:IWindow):void
        {
            var _loc4_:FriendListTab;
            this._friendList.view.showInfo(param1, (("${friendlist.tip.tab." + param2.id) + "}"));
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("TAB CLICKED!");
            var _loc3_:FriendListTab = this._friendList.tabs.findTab(param2.id);
            for each (_loc4_ in this._friendList.tabs.getTabs())
            {
                _loc4_.tabView.tabClicked(_loc3_.id);
            };
            this._friendList.tabs.toggleSelected(_loc3_);
            this._friendList.view.refresh("tabClick");
            if (_loc3_.selected)
            {
                switch (_loc3_.id)
                {
                    case FriendListTab.var_535:
                        this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS);
                        break;
                    case FriendListTab.var_537:
                        this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH);
                        break;
                    case FriendListTab.var_536:
                        this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST);
                        break;
                };
            }
            else
            {
                this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.var_47);
            };
        }

        private function getTabContent(param1:FriendListTab):IWindow
        {
            var _loc2_:IWindowContainer = IWindowContainer(this._friendList.getXmlWindow("tab_content"));
            _loc2_.background = true;
            _loc2_.color = this._friendList.laf.getTabBgColor(param1.id);
            _loc2_.addChild(this.getTabContentFooter(param1));
            var _loc3_:IItemListWindow = IItemListWindow(_loc2_.findChildByName("list_content"));
            _loc3_.color = this._friendList.laf.getTabBgColor(param1.id);
            param1.tabView.fillList(_loc3_);
            return (_loc2_);
        }

        private function refreshTabContentDims(param1:IWindowContainer):void
        {
            var _loc2_:IWindowContainer = (param1.getChildByName("footer") as IWindowContainer);
            var _loc3_:IWindowContainer = (param1.getChildByName("list") as IWindowContainer);
            var _loc4_:IWindow = (_loc3_.getChildByName("scroller") as IWindow);
            var _loc5_:IItemListWindow = IItemListWindow(_loc3_.getChildByName("list_content"));
            var _loc6_:IWindow = _loc3_.parent;
            var _loc7_:int = this._friendList.tabs.tabContentWidth;
            var _loc8_:int = this._friendList.tabs.tabContentHeight;
            _loc6_.height = Math.max(0, _loc8_);
            _loc6_.width = _loc7_;
            var _loc9_:int = Math.max(((_loc8_ - _loc3_.y) - _loc2_.height), 0);
            _loc3_.height = _loc9_;
            _loc4_.height = _loc9_;
            _loc5_.height = _loc9_;
            _loc3_.width = _loc7_;
            _loc5_.width = _loc7_;
            _loc4_.x = (_loc7_ - 27);
            _loc2_.y = (_loc8_ - _loc2_.height);
            _loc2_.width = _loc7_;
        }

        private function refreshScrollBarVisibility(param1:IWindowContainer):void
        {
            var _loc2_:IWindowContainer = (param1.getChildByName("list") as IWindowContainer);
            var _loc3_:IWindow = (_loc2_.getChildByName("scroller") as IWindow);
            var _loc4_:IItemListWindow = IItemListWindow(_loc2_.getChildByName("list_content"));
            var _loc5_:* = (_loc4_.scrollableRegion.height > _loc4_.height);
            var _loc6_:int = 22;
            var _loc7_:int = (this._friendList.tabs.tabContentWidth - 10);
            var _loc8_:int = (_loc7_ - _loc6_);
            var _loc9_:int = ((_loc5_) ? _loc8_ : _loc7_);
            _loc3_.visible = _loc5_;
            _loc4_.width = _loc9_;
            this.change(_loc4_, _loc9_);
        }

        private function change(param1:IItemListWindow, param2:int):void
        {
            var _loc4_:IWindow;
            var _loc3_:int;
            while (_loc3_ < param1.numListItems)
            {
                _loc4_ = param1.getListItemAt(_loc3_);
                _loc4_.width = param2;
                _loc3_++;
            };
        }

        private function getTabContentFooter(param1:FriendListTab):IWindow
        {
            var _loc2_:IWindowContainer = IWindowContainer(this._friendList.getXmlWindow(param1.footerName));
            param1.tabView.fillFooter(_loc2_);
            return (_loc2_);
        }


    }
}