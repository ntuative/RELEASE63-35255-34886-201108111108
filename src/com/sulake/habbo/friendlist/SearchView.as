package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;
    import com.sulake.habbo.friendlist.domain.AvatarSearchResults;
    import com.sulake.habbo.friendlist.domain.FriendListTab;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import flash.utils.Dictionary;
    import flash.external.ExternalInterface;
    import flash.ui.Keyboard;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.HabboSearchMessageComposer;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class SearchView implements ITabView, ISearchView 
    {

        private var _friendList:HabboFriendList;
        private var var_3989:ITextFieldWindow;
        private var var_2632:IItemListWindow;
        private var var_3980:AvatarPopupCtrl;


        public function init(param1:HabboFriendList):void
        {
            this._friendList = param1;
            this.var_3980 = new AvatarPopupCtrl(this._friendList);
        }

        public function getEntryCount():int
        {
            if (this._friendList.searchResults.friends == null)
            {
                return (0);
            };
            return (this._friendList.searchResults.friends.length + this._friendList.searchResults.others.length);
        }

        public function fillList(param1:IItemListWindow):void
        {
            this.var_2632 = param1;
        }

        public function fillFooter(param1:IWindowContainer):void
        {
            this.var_3989 = ITextFieldWindow(param1.findChildByName("search_str"));
            this.var_3989.procedure = this.onSearchInput;
            this.var_3989.addEventListener(WindowKeyboardEvent.var_1253, this.onSearchStrInput);
            param1.findChildByName("search_but").procedure = this.onSearchButtonClick;
            this._friendList.refreshButton(param1, "search", true, null, 0);
        }

        public function tabClicked(param1:int):void
        {
        }

        public function refreshList():void
        {
            var _loc3_:HabboSearchResultData;
            var _loc4_:HabboSearchResultData;
            var _loc5_:Boolean;
            this.var_2632.autoArrangeItems = false;
            var _loc1_:AvatarSearchResults = this._friendList.searchResults;
            var _loc2_:int;
            while (true)
            {
                if (_loc2_ == 0)
                {
                    this.refreshEntry(true, _loc2_, null, null, this.getFriendsCaption(), false, false, false, 0);
                }
                else
                {
                    if (_loc2_ <= _loc1_.friends.length)
                    {
                        _loc3_ = _loc1_.friends[(_loc2_ - 1)];
                        this.refreshEntry(true, _loc2_, _loc3_.avatarFigure, _loc3_.avatarName, null, (!(_loc3_.isAvatarOnline)), _loc3_.isAvatarOnline, false, _loc3_.avatarId);
                    }
                    else
                    {
                        if (_loc2_ == (_loc1_.friends.length + 1))
                        {
                            this.refreshEntry(true, _loc2_, null, null, this.getOthersCaption(), false, false, false, 0);
                        }
                        else
                        {
                            if (_loc2_ <= ((_loc1_.friends.length + _loc1_.others.length) + 1))
                            {
                                _loc4_ = _loc1_.others[((_loc2_ - 2) - _loc1_.friends.length)];
                                this.refreshEntry(true, _loc2_, _loc4_.avatarFigure, _loc4_.avatarName, null, false, false, ((!(_loc4_.avatarId == this._friendList.avatarId)) && (!(this._friendList.searchResults.isFriendRequestSent(_loc4_.avatarId)))), _loc4_.avatarId);
                            }
                            else
                            {
                                _loc5_ = this.refreshEntry(false, _loc2_, null, null, null, false, false, false, 0);
                                if (_loc5_) break;
                            };
                        };
                    };
                };
                _loc2_++;
            };
            this.refreshShading();
            this.var_2632.autoArrangeItems = true;
        }

        private function refreshShading():void
        {
            var _loc1_:int;
            while (_loc1_ < this.var_2632.numListItems)
            {
                this.var_2632.getListItemAt(_loc1_).color = this._friendList.laf.getRowShadingColor(FriendListTab.var_537, ((_loc1_ % 2) == 1));
                _loc1_++;
            };
        }

        public function setSearchStr(param1:String):void
        {
            this.var_3989.text = param1;
        }

        private function getFriendsCaption():String
        {
            if (this._friendList.searchResults.friends.length == 0)
            {
                return ("${friendlist.search.nofriendsfound}");
            };
            this._friendList.registerParameter("friendlist.search.friendscaption", "cnt", ("" + this._friendList.searchResults.friends.length));
            return ("${friendlist.search.friendscaption}");
        }

        private function getOthersCaption():String
        {
            if (this._friendList.searchResults.others.length == 0)
            {
                return ("${friendlist.search.noothersfound}");
            };
            this._friendList.registerParameter("friendlist.search.otherscaption", "cnt", ("" + this._friendList.searchResults.others.length));
            return ("${friendlist.search.otherscaption}");
        }

        private function refreshEntry(param1:Boolean, param2:int, param3:String, param4:String, param5:String, param6:Boolean, param7:Boolean, param8:Boolean, param9:int):Boolean
        {
            var _loc10_:IWindowContainer = (this.var_2632.getListItemAt(param2) as IWindowContainer);
            if (_loc10_ == null)
            {
                if (!param1)
                {
                    return (true);
                };
                _loc10_ = IWindowContainer(this._friendList.getXmlWindow("search_entry"));
                _loc10_.procedure = this.onSearchEntry;
                this.var_2632.addListItem(_loc10_);
            };
            if (param1)
            {
                _loc10_.height = 20;
                _loc10_.visible = true;
            }
            else
            {
                _loc10_.height = 0;
                _loc10_.visible = false;
            };
            _loc10_.id = param9;
            this.refreshFigure(_loc10_, param3);
            this._friendList.refreshText(_loc10_, "name", (!(param4 == null)), param4);
            this._friendList.refreshText(_loc10_, "caption", (!(param5 == null)), param5);
            this._friendList.refreshButton(_loc10_, "minimail", param6, this.onMinimailButtonClick, param9);
            this._friendList.refreshButton(_loc10_, "start_chat", param7, this.onChatButtonClick, param9);
            this._friendList.refreshButton(_loc10_, "ask_for_friend", param8, this.onAskForFriendButtonClick, param9);
            return (false);
        }

        private function refreshFigure(param1:IWindowContainer, param2:String):void
        {
            var _loc3_:IBitmapWrapperWindow = (param1.getChildByName(HabboFriendList.var_274) as IBitmapWrapperWindow);
            if (((param2 == null) || (param2 == "")))
            {
                _loc3_.visible = false;
            }
            else
            {
                _loc3_.bitmap = this._friendList.getAvatarFaceBitmap(param2);
                _loc3_.width = _loc3_.bitmap.width;
                _loc3_.height = _loc3_.bitmap.height;
                _loc3_.visible = true;
            };
        }

        private function onSearchEntry(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:HabboSearchResultData;
            if (param2.id < 1)
            {
                return;
            };
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
            {
                _loc3_ = this._friendList.searchResults.getResult(param2.id);
                if (_loc3_ == null)
                {
                    return;
                };
                this.var_3980.setData(_loc3_.isAvatarOnline, _loc3_.avatarName, _loc3_.avatarMotto, _loc3_.avatarFigure, _loc3_.lastOnlineDate, _loc3_.realName);
                this.var_3980.showPopup(this._friendList.view.mainWindow, IWindowContainer(param2));
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_624)
                {
                    this.var_3980.closePopup();
                };
            };
        }

        private function onSearchButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.search}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log(("Search clicked: " + param2.name));
            this.searchAvatar();
        }

        private function onAskForFriendButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.addfriend}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log(("Ask for friend clicked: " + param2.id));
            var _loc3_:HabboSearchResultData = this._friendList.searchResults.getResult(param2.id);
            if (_loc3_ == null)
            {
                Logger.log(("No search result found with id: " + param2.id));
                return;
            };
            Logger.log(("Search result found: " + _loc3_.avatarName));
            var _loc4_:Boolean = this._friendList.askForAFriend(_loc3_.avatarId, _loc3_.avatarName);
            if (!_loc4_)
            {
                this._friendList.showLimitReachedAlert();
            }
            else
            {
                this.showFriendRequestSentAlert(_loc3_.avatarName);
                this.refreshEntry(true, this.findIndexFor(_loc3_.avatarId), _loc3_.avatarFigure, _loc3_.avatarName, null, false, false, false, _loc3_.avatarId);
            };
        }

        private function findIndexFor(param1:int):int
        {
            var _loc2_:int;
            while (_loc2_ < this.var_2632.numListItems)
            {
                if (this.var_2632.getListItemAt(_loc2_).id == param1)
                {
                    return (_loc2_);
                };
                _loc2_++;
            };
            return (-1);
        }

        private function showFriendRequestSentAlert(param1:String):void
        {
            this._friendList.registerParameter("friendlist.friendrequestsent.text", "user_name", param1);
            new SimpleAlertView(this._friendList, "${friendlist.friendrequestsent.title}", "${friendlist.friendrequestsent.text}").show();
        }

        private function onMinimailButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.mail}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:HabboSearchResultData = this._friendList.searchResults.getResult(param2.id);
            if (_loc3_ == null)
            {
                Logger.log(("No search result found with id: " + param2.id));
                return;
            };
            var _loc4_:Dictionary = new Dictionary();
            _loc4_["recipientid"] = ("" + _loc3_.avatarId);
            _loc4_["random"] = ("" + Math.round((Math.random() * 100000000)));
            var _loc5_:WindowMouseEvent = (param1 as WindowMouseEvent);
            if (this._friendList.isEmbeddedMinimailEnabled())
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.openHabblet", "minimail", (((("#mail/compose/" + _loc4_["recipientid"]) + "/") + _loc4_["random"]) + "/"));
                };
            }
            else
            {
                this._friendList.openHabboWebPage("link.format.mail.compose", _loc4_, _loc5_.stageX, _loc5_.stageY);
            };
        }

        private function onChatButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.im}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:HabboSearchResultData = this._friendList.searchResults.getResult(param2.id);
            if (_loc3_ == null)
            {
                Logger.log(("No search result found with id: " + param2.id));
                return;
            };
            this._friendList.messenger.startConversation(_loc3_.avatarId);
        }

        private function onSearchInput(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.searchstr}");
        }

        private function onSearchStrInput(param1:WindowKeyboardEvent):void
        {
            var _loc3_:Keyboard;
            var _loc4_:int;
            var _loc5_:String;
            var _loc2_:IWindow = IWindow(param1.target);
            Logger.log(((((("Test key event " + param1) + ", ") + param1.type) + " ") + _loc2_.name));
            if (param1.charCode == Keyboard.ENTER)
            {
                this.searchAvatar();
            }
            else
            {
                _loc4_ = 25;
                _loc5_ = this.var_3989.text;
                if (_loc5_.length > _loc4_)
                {
                    this.var_3989.text = _loc5_.substring(0, _loc4_);
                };
            };
        }

        private function searchAvatar():void
        {
            var _loc1_:String = this.var_3989.text;
            Logger.log(("Search avatar: " + _loc1_));
            if (_loc1_ == "")
            {
                Logger.log("No text...");
                return;
            };
            this._friendList.send(new HabboSearchMessageComposer(_loc1_));
        }


    }
}