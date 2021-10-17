package com.sulake.habbo.messenger
{
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.messenger.domain.Conversation;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.messenger.domain.Message;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.utils.Dictionary;
    import flash.external.ExternalInterface;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.components.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.habbo.messenger.domain.*;

    public class ConversationView 
    {

        private static const var_2151:int = 10;
        private static const var_2149:int = 100;
        private static const var_2150:int = 20;

        private var _messenger:HabboMessenger;
        private var var_4143:IScrollbarWindow;
        private var var_4144:IContainerButtonWindow;
        private var var_2632:IItemListWindow;
        private var var_4145:Conversation;

        public function ConversationView(param1:HabboMessenger, param2:IWindowContainer)
        {
            this._messenger = param1;
            this.var_4144 = this.initButton("follow_friend", this.onFollowButtonClick, param2);
            this.var_2632 = IItemListWindow(param2.findChildByName("msg_list"));
            this.var_4143 = IScrollbarWindow(param2.findChildByName("scroller"));
            this._messenger.refreshButton(param2, "close", true, this.onCloseButtonClick, 0);
            this.initButton("minimail", this.onMinimailButtonClick, param2);
        }

        public function addMessage(param1:Message):void
        {
            var _loc2_:int = this.findAddIndex();
            if (_loc2_ >= (var_2149 + var_2150))
            {
                this.refreshList();
                this.afterResize();
            }
            else
            {
                this.var_2632.autoArrangeItems = false;
                this.refreshEntry(true, _loc2_, param1);
                this.var_2632.autoArrangeItems = true;
            };
            this.var_4143.scrollV = 1;
            this.refreshScrollBarVisibility();
        }

        public function afterResize():void
        {
            this.refreshListDims();
            var _loc1_:Boolean = this.refreshScrollBarVisibility();
            if (_loc1_)
            {
                this.refreshListDims();
            };
        }

        private function initButton(param1:String, param2:Function, param3:IWindowContainer):IContainerButtonWindow
        {
            var _loc4_:IContainerButtonWindow = IContainerButtonWindow(param3.findChildByName(("button_" + param1)));
            _loc4_.procedure = param2;
            var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc4_.findChildByName("icon"));
            _loc5_.bitmap = this._messenger.getButtonImage(param1);
            _loc5_.width = _loc5_.bitmap.width;
            _loc5_.height = _loc5_.bitmap.height;
            return (_loc4_);
        }

        private function refreshListDims():void
        {
            var _loc2_:ITextWindow;
            this.var_2632.autoArrangeItems = false;
            var _loc1_:int;
            while (_loc1_ < this.var_2632.numListItems)
            {
                _loc2_ = ITextWindow(this.var_2632.getListItemAt(_loc1_));
                this.refreshTextDims(_loc2_);
                if (!_loc2_.visible) break;
                _loc1_++;
            };
            this.var_2632.autoArrangeItems = true;
        }

        private function refreshTextDims(param1:ITextWindow):void
        {
            param1.width = this.var_2632.width;
            param1.height = (param1.textHeight + var_2151);
            param1.invalidate();
        }

        private function refreshScrollBarVisibility():Boolean
        {
            var _loc1_:IWindowContainer = IWindowContainer(this.var_2632.parent);
            var _loc2_:IWindow = (_loc1_.getChildByName("scroller") as IWindow);
            var _loc3_:* = (this.var_2632.scrollableRegion.height > this.var_2632.height);
            var _loc4_:int = 22;
            if (_loc2_.visible)
            {
                if (_loc3_)
                {
                    return (false);
                };
                _loc2_.visible = false;
                this.var_2632.width = (this.var_2632.width + _loc4_);
                return (true);
            };
            if (_loc3_)
            {
                _loc2_.visible = true;
                this.var_2632.width = (this.var_2632.width - _loc4_);
                return (true);
            };
            return (false);
        }

        private function findAddIndex():int
        {
            var _loc2_:IWindow;
            var _loc1_:int;
            while (_loc1_ < this.var_2632.numListItems)
            {
                _loc2_ = this.var_2632.getListItemAt(_loc1_);
                if (!_loc2_.visible)
                {
                    return (_loc1_);
                };
                _loc1_++;
            };
            return (_loc1_ + 1);
        }

        public function refresh():void
        {
            var _loc1_:Conversation = this._messenger.conversations.findSelectedConversation();
            if (_loc1_ == null)
            {
                return;
            };
            if (((this.var_4145 == null) || (!(_loc1_.id == this.var_4145.id))))
            {
                this.var_4145 = _loc1_;
                this.refreshList();
                this.afterResize();
            };
            this.refreshHeader();
        }

        public function refreshHeader():void
        {
            if (this.var_4145.followingAllowed)
            {
                this.var_4144.enable();
            }
            else
            {
                this.var_4144.disable();
            };
        }

        private function refreshList():void
        {
            var _loc3_:Boolean;
            if (this.var_2632 == null)
            {
                return;
            };
            this.var_2632.autoArrangeItems = false;
            var _loc1_:int;
            var _loc2_:int = Math.max(0, (this.var_4145.messages.length - var_2149));
            _loc1_ = 0;
            while ((_loc1_ + _loc2_) < this.var_4145.messages.length)
            {
                this.refreshEntry(true, _loc1_, this.var_4145.messages[(_loc1_ + _loc2_)]);
                _loc1_++;
            };
            while (true)
            {
                _loc3_ = this.refreshEntry(false, _loc1_, null);
                if (_loc3_) break;
                _loc1_++;
            };
            this.var_2632.autoArrangeItems = true;
        }

        private function refreshEntry(param1:Boolean, param2:int, param3:Message):Boolean
        {
            var _loc4_:ITextWindow = (this.var_2632.getListItemAt(param2) as ITextWindow);
            if (_loc4_ == null)
            {
                if (!param1)
                {
                    return (true);
                };
                _loc4_ = ITextWindow(this._messenger.getXmlWindow("msg_entry"));
                _loc4_.width = this.var_2632.width;
                this.var_2632.addListItem(_loc4_);
            };
            if (!param1)
            {
                _loc4_.height = 0;
                _loc4_.visible = false;
                return (false);
            };
            _loc4_.visible = true;
            var _loc5_:String = (((param3.type == Message.var_1387) || (param3.type == Message.var_276)) ? (param3.time + ": ") : "");
            _loc4_.text = (_loc5_ + param3.messageText);
            _loc4_.color = this.getChatBgColor(param3.type);
            _loc4_.textColor = this.getChatTextColor(param3.type);
            this.refreshTextDims(_loc4_);
            return (false);
        }

        private function onMinimailButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Minimail clicked");
            var _loc3_:Dictionary = new Dictionary();
            _loc3_["recipientid"] = ("" + this.var_4145.id);
            _loc3_["random"] = ("" + Math.round((Math.random() * 100000000)));
            if (this._messenger.isEmbeddedMinimailEnabled())
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.openHabblet", "minimail", (((("#mail/compose/" + _loc3_["recipientid"]) + "/") + _loc3_["random"]) + "/"));
                };
            }
            else
            {
                this._messenger.openHabboWebPage("link.format.mail.compose", _loc3_, param1);
            };
        }

        private function onFollowButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Follow clicked");
            this._messenger.send(new FollowFriendMessageComposer(this.var_4145.id));
            this._messenger.send(new EventLogMessageComposer("Navigation", "IM", "go.im"));
        }

        private function onCloseButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Close clicked");
            this._messenger.conversations.closeConversation();
            this._messenger.messengerView.refresh();
        }

        private function getChatBgColor(param1:int):uint
        {
            if (param1 == Message.var_1387)
            {
                return (0xFFFFFFFF);
            };
            if (param1 == Message.var_276)
            {
                return (4292801535);
            };
            if (param1 == Message.var_278)
            {
                return (0xFFFF6666);
            };
            if (param1 == Message.var_1388)
            {
                return (4293454056);
            };
            if (param1 == Message.var_1389)
            {
                return (4293454056);
            };
            if (param1 == Message.var_277)
            {
                return (4288269465);
            };
            return (4291611852);
        }

        private function getChatTextColor(param1:int):uint
        {
            if (param1 == Message.var_1388)
            {
                return (4285887861);
            };
            if (param1 == Message.var_1389)
            {
                return (4285887861);
            };
            return (0xFF000000);
        }


    }
}