package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.domain.FriendListTab;
    import com.sulake.habbo.friendlist.domain.FriendCategory;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.friendlist.domain.Friend;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import flash.external.ExternalInterface;
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.ITextWindow;

    public class FriendsView implements ITabView, IFriendsView 
    {

        public static const var_2435:String = "bg";

        private var _friendList:HabboFriendList;
        private var var_3976:IContainerButtonWindow;
        private var var_3977:IContainerButtonWindow;
        private var var_3978:IContainerButtonWindow;
        private var var_3979:IContainerButtonWindow;
        private var var_2632:IItemListWindow;
        private var var_3980:AvatarPopupCtrl;


        public function init(param1:HabboFriendList):void
        {
            this._friendList = param1;
            this.var_3980 = new AvatarPopupCtrl(this._friendList);
        }

        public function getEntryCount():int
        {
            return (this._friendList.categories.getFriendCount(true));
        }

        public function fillFooter(param1:IWindowContainer):void
        {
            this.var_3976 = this.initButton("open_minimail", this.onMinimailButtonClick, param1);
            this.var_3977 = this.initButton("open_homepage", this.onHomeButtonClick, param1);
            this.var_3978 = this.initButton("room_invite", this.onInviteButtonClick, param1);
            this.var_3979 = this.initButton("remove_friend", this.onRemoveButtonClick, param1);
            this.refreshButtons();
        }

        public function fillList(param1:IItemListWindow):void
        {
            this.var_2632 = param1;
            this.refreshList();
        }

        public function tabClicked(param1:int):void
        {
        }

        public function setNewMessageArrived():void
        {
            this._friendList.tabs.findTab(FriendListTab.var_535).setNewMessageArrived(true);
        }

        public function refreshList():void
        {
            var _loc2_:FriendCategory;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:Boolean;
            if (this.var_2632 == null)
            {
                return;
            };
            this.var_2632.autoArrangeItems = false;
            var _loc1_:int;
            for each (_loc2_ in this._friendList.categories.getCategories())
            {
                this.refreshEntry(true, _loc1_, _loc2_, null);
                _loc1_++;
                if (_loc2_.open)
                {
                    _loc3_ = _loc2_.getStartFriendIndex();
                    _loc4_ = _loc2_.getEndFriendIndex();
                    _loc5_ = _loc3_;
                    while (_loc5_ < _loc4_)
                    {
                        this.refreshEntry(true, _loc1_, _loc2_, _loc2_.friends[_loc5_]);
                        _loc1_++;
                        _loc5_++;
                    };
                };
            };
            while (true)
            {
                _loc6_ = this.refreshEntry(false, _loc1_, null, null);
                if (_loc6_) break;
                _loc1_++;
            };
            this.var_2632.autoArrangeItems = true;
            this.refreshButtons();
        }

        private function initButton(param1:String, param2:Function, param3:IWindowContainer):IContainerButtonWindow
        {
            var _loc4_:IContainerButtonWindow = IContainerButtonWindow(param3.findChildByName(("button_" + param1)));
            _loc4_.procedure = param2;
            var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc4_.findChildByName("icon"));
            _loc5_.bitmap = this._friendList.getButtonImage(param1);
            _loc5_.width = _loc5_.bitmap.width;
            _loc5_.height = _loc5_.bitmap.height;
            return (_loc4_);
        }

        private function refreshEntry(param1:Boolean, param2:int, param3:FriendCategory, param4:Friend):Boolean
        {
            var _loc5_:* = ((param2 % 2) == 1);
            var _loc6_:IWindowContainer = (this.var_2632.getListItemAt(param2) as IWindowContainer);
            if (_loc6_ == null)
            {
                if (!param1)
                {
                    return (true);
                };
                _loc6_ = IWindowContainer(this._friendList.getXmlWindow("friend_entry"));
                this.var_2632.addListItem(_loc6_);
            };
            Util.hideChildren(_loc6_);
            if (!param1)
            {
                _loc6_.height = 0;
                _loc6_.visible = false;
                return (false);
            };
            _loc6_.height = 20;
            _loc6_.visible = true;
            _loc6_.color = this._friendList.laf.getRowShadingColor(FriendListTab.var_535, _loc5_);
            if (param4 == null)
            {
                param3.view = _loc6_;
                this.refreshCategoryEntry(param3, _loc5_);
            }
            else
            {
                param4.view = _loc6_;
                this.refreshFriendEntry(param3, param4);
            };
            return (false);
        }

        public function refreshCategoryEntry(param1:FriendCategory, param2:Boolean):void
        {
            if (this.var_2632 == null)
            {
                return;
            };
            var _loc3_:IWindowContainer = param1.view;
            _loc3_.tags.splice(0, _loc3_.tags.length);
            _loc3_.tags.push(param1.id);
            this._friendList.refreshText(_loc3_, "caption", true, (((param1.name + " (") + param1.friends.length) + ")"));
            this.refreshCatIcon(_loc3_, "arrow_down_black", param1.open, param1.id, 6);
            this.refreshCatIcon(_loc3_, "arrow_right_black", (!(param1.open)), param1.id, 9);
            _loc3_.procedure = this.onCategoryClick;
            _loc3_.visible = false;
            this.refreshPager(param1, param2);
            _loc3_.height = Math.max(Util.getLowestPoint(_loc3_), 20);
            _loc3_.visible = true;
        }

        private function refreshFriendEntry(param1:FriendCategory, param2:Friend):void
        {
            if (((param1 == null) || (param2 == null)))
            {
                return;
            };
            var _loc3_:IWindowContainer = param2.view;
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.id = param2.id;
            _loc3_.procedure = this.onFriendClick;
            _loc3_.visible = true;
            if (param2.selected)
            {
                _loc3_.color = this._friendList.laf.getSelectedEntryBgColor();
            };
            ILabelWindow(param2.view.findChildByName("name")).textColor = this._friendList.laf.getFriendTextColor(param2.selected);
            var _loc4_:String = param2.name;
            if (((!(param2.realName == null)) && (!(param2.realName == ""))))
            {
                _loc4_ = (((_loc4_ + " (") + param2.realName) + ")");
            };
            this._friendList.refreshText(_loc3_, "name", true, _loc4_);
            this._friendList.refreshButton(_loc3_, "start_chat", param2.online, this.onChatButtonClick, param2.id);
            this._friendList.refreshButton(_loc3_, "follow_friend", param2.followingAllowed, this.onFollowButtonClick, param2.id);
            this.refreshFigure(_loc3_, param2);
        }

        private function refreshCatIcon(param1:IWindowContainer, param2:String, param3:Boolean, param4:int, param5:int):void
        {
            var _loc6_:ILabelWindow;
            var _loc7_:IWindow;
            this._friendList.refreshButton(param1, param2, param3, this.onCategoryClick, param4);
            if (param3)
            {
                _loc6_ = ILabelWindow(param1.findChildByName("caption"));
                _loc7_ = param1.findChildByName(param2);
                _loc7_.x = (_loc6_.textWidth + param5);
            };
        }

        private function refreshFigure(param1:IWindowContainer, param2:Friend):void
        {
            var _loc4_:BitmapData;
            if (!param1)
            {
                ErrorReportStorage.addDebugData("FriendsView", "refreshFigure: e is null!");
            };
            if (!param2)
            {
                ErrorReportStorage.addDebugData("FriendsView", "refreshFigure: f is null!");
            };
            var _loc3_:IBitmapWrapperWindow = (param1.getChildByName(HabboFriendList.var_274) as IBitmapWrapperWindow);
            if (!_loc3_)
            {
                ErrorReportStorage.addDebugData("FriendsView", "refreshFigure: child is null!");
            };
            if (!this._friendList)
            {
                ErrorReportStorage.addDebugData("FriendsView", "refreshFigure: _friendList is null!");
            };
            if (((param2.figure == null) || (param2.figure == "")))
            {
                _loc3_.visible = false;
            }
            else
            {
                if (param2.face == null)
                {
                    param2.face = this._friendList.getAvatarFaceBitmap(param2.figure);
                };
                if (_loc3_.bitmap == null)
                {
                    _loc3_.bitmap = new BitmapData(_loc3_.width, _loc3_.height);
                };
                if (_loc3_.tags[0] != param2.figure)
                {
                    _loc3_.tags.splice(0, _loc3_.tags.length);
                    _loc3_.tags.push(param2.figure);
                    _loc3_.bitmap.fillRect(_loc3_.bitmap.rect, 0);
                    _loc4_ = param2.face;
                    if (_loc4_)
                    {
                        _loc3_.bitmap.copyPixels(_loc4_, _loc4_.rect, new Point(0, 0), null, null, true);
                    };
                }
                else
                {
                    Logger.log(("Figure unchanged: " + _loc3_.tags[0]));
                };
                _loc3_.visible = true;
            };
        }

        private function getBgColor(param1:Boolean):uint
        {
            return (this._friendList.laf.getRowShadingColor(FriendListTab.var_535, param1));
        }

        private function refreshButtons():void
        {
            var _loc1_:Array = this._friendList.categories.getSelectedFriends();
            this.setEnabled(this.var_3976, this.isEnableMinimailButton(_loc1_));
            this.setEnabled(this.var_3977, this.isEnableHomeButton(_loc1_));
            this.setEnabled(this.var_3978, this.isEnableInviteButton(_loc1_));
            this.setEnabled(this.var_3979, this.isEnableRemoveButton(_loc1_));
        }

        private function setEnabled(param1:IContainerButtonWindow, param2:Boolean):void
        {
            if (param2)
            {
                param1.enable();
            }
            else
            {
                param1.disable();
            };
        }

        private function isEnableMinimailButton(param1:Array):Boolean
        {
            return ((this._friendList.isEmbeddedMinimailEnabled()) || (param1.length == 1));
        }

        private function isEnableHomeButton(param1:Array):Boolean
        {
            return (param1.length == 1);
        }

        private function isEnableInviteButton(param1:Array):Boolean
        {
            var _loc2_:Friend;
            if (param1.length < 1)
            {
                return (false);
            };
            for each (_loc2_ in param1)
            {
                if (_loc2_.online)
                {
                    return (true);
                };
            };
            return (true);
        }

        private function isEnableRemoveButton(param1:Array):Boolean
        {
            return (param1.length > 0);
        }

        private function onCategoryClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log(((("Category clicked: " + param2.name) + ", ") + param2.tags[0]));
            if (param2.tags.length == 0)
            {
                param2 = param2.parent;
            };
            Logger.log(((("Category id: " + param2.name) + ", ") + param2.tags[0]));
            var _loc3_:int = param2.tags[0];
            Logger.log(("Cat id: " + _loc3_));
            var _loc4_:FriendCategory = this._friendList.categories.findCategory(_loc3_);
            _loc4_.setOpen((!(_loc4_.open)));
            this.refreshList();
            this._friendList.view.refresh("Cat open/closed");
        }

        private function onFriendClick(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:Friend;
            var _loc4_:Friend;
            if (param2 == null)
            {
                return;
            };
            if (param2.id == 0)
            {
                param2 = param2.parent;
                if (param2 == null)
                {
                    return;
                };
            };
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
            {
                _loc3_ = this._friendList.categories.findFriend(param2.id);
                this.var_3980.setData(_loc3_.online, _loc3_.name, _loc3_.motto, _loc3_.figure, _loc3_.lastAccess);
                this.var_3980.showPopup(this._friendList.view.mainWindow, _loc3_.view);
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_624)
                {
                    this.var_3980.closePopup();
                }
                else
                {
                    if (((param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK) || (param1.type == WindowMouseEvent.var_649)))
                    {
                        _loc4_ = this._friendList.categories.findFriend(param2.id);
                        _loc4_.selected = (!(_loc4_.selected));
                        this.refreshButtons();
                        this.refreshList();
                        if (((param1.type == WindowMouseEvent.var_649) && (_loc4_.online)))
                        {
                            this._friendList.messenger.startConversation(_loc4_.id);
                        };
                    };
                };
            };
        }

        private function onChatButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.im}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log(((("chat clicked: " + param2.name) + ", ") + param2.id));
            this._friendList.messenger.startConversation(param2.id);
        }

        private function onFollowButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.follow}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this._friendList.send(new FollowFriendMessageComposer(param2.id));
            this._friendList.send(new EventLogMessageComposer("Navigation", "Friend List", "go.friendlist"));
        }

        private function onMinimailButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.compose}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:Array = this._friendList.categories.getSelectedFriends();
            if (_loc3_.length == 0)
            {
                Logger.log("No friend found when minimail clicked");
                if (this._friendList.isEmbeddedMinimailEnabled())
                {
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("FlashExternalInterface.openHabblet", "minimail", "#mail/inbox/");
                    };
                };
                return;
            };
            var _loc4_:Dictionary = new Dictionary();
            var _loc5_:Array = new Array();
            var _loc6_:int;
            while (((_loc6_ < _loc3_.length) && (_loc6_ < 50)))
            {
                _loc5_.push(_loc3_[_loc6_].id);
                _loc6_++;
            };
            _loc4_["recipientid"] = _loc5_.join(",");
            _loc4_["random"] = ("" + Math.round((Math.random() * 100000000)));
            var _loc7_:WindowMouseEvent = (param1 as WindowMouseEvent);
            if (this._friendList.isEmbeddedMinimailEnabled())
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.openHabblet", "minimail", (((("#mail/compose/" + _loc4_["recipientid"]) + "/") + _loc4_["random"]) + "/"));
                };
            }
            else
            {
                this._friendList.openHabboWebPage("link.format.mail.compose", _loc4_, _loc7_.stageX, _loc7_.stageY);
            };
        }

        private function onHomeButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.home}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:Friend = this._friendList.categories.getSelectedFriend();
            if (_loc3_ == null)
            {
                Logger.log("No friend found when home clicked");
                return;
            };
            var _loc4_:Dictionary = new Dictionary();
            _loc4_["ID"] = ("" + _loc3_.id);
            var _loc5_:WindowMouseEvent = (param1 as WindowMouseEvent);
            this._friendList.openHabboWebPage("link.format.userpage", _loc4_, _loc5_.stageX, _loc5_.stageY);
        }

        private function onInviteButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.invite}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            new RoomInviteView(this._friendList).show();
        }

        private function onRemoveButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.remove}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            new FriendRemoveView(this._friendList).show();
        }

        private function refreshPager(param1:FriendCategory, param2:Boolean):void
        {
            var _loc3_:IWindowContainer = IWindowContainer(param1.view.findChildByName("pager"));
            if (((param1.getPageCount() < 2) || (!(param1.open))))
            {
                Logger.log(((("PAGER NOT VISIBLE: " + param1.open) + ", ") + param1.getPageCount()));
                _loc3_.visible = false;
                return;
            };
            _loc3_.visible = true;
            Util.hideChildren(_loc3_);
            var _loc4_:int;
            while (_loc4_ < param1.getPageCount())
            {
                this.refreshPageLink(_loc3_, _loc4_, param1.pageIndex, param2);
                _loc4_++;
            };
            Util.layoutChildrenInArea(_loc3_, _loc3_.width, 15);
            _loc3_.height = Util.getLowestPoint(_loc3_);
        }

        private function refreshPageLink(param1:IWindowContainer, param2:int, param3:int, param4:Boolean):void
        {
            var _loc5_:String = ("page." + param2);
            var _loc6_:ITextWindow = ITextWindow(param1.getChildByName(_loc5_));
            if (_loc6_ == null)
            {
                _loc6_ = ITextWindow(this._friendList.getXmlWindow("pagelink"));
                _loc6_.name = _loc5_;
                param1.addChild(_loc6_);
            };
            _loc6_.underline = (!(param2 == param3));
            _loc6_.text = ((("" + ((param2 * FriendCategory.var_1834) + 1)) + "-") + ("" + ((param2 + 1) * FriendCategory.var_1834)));
            _loc6_.id = param2;
            _loc6_.procedure = this.onPageLinkClick;
            _loc6_.width = (_loc6_.textWidth + 5);
            _loc6_.color = this._friendList.laf.getRowShadingColor(FriendListTab.var_535, param4);
            _loc6_.visible = true;
        }

        private function onPageLinkClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:ITextWindow = ITextWindow(param2);
            var _loc4_:int = _loc3_.parent.parent.tags[0];
            var _loc5_:int = _loc3_.id;
            Logger.log(((("Page link clicked: " + _loc4_) + ", ") + _loc5_));
            var _loc6_:FriendCategory = this._friendList.categories.findCategory(_loc4_);
            _loc6_.pageIndex = _loc5_;
            this.refreshList();
        }


    }
}