package com.sulake.habbo.moderation
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import flash.utils.getTimer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetCfhChatlogMessageComposer;

    public class IssueHandler implements TrackedWindow 
    {

        private var var_4171:ModerationManager;
        private var var_4172:IssueBundle;
        private var _window:IFrameWindow;
        private var var_4173:UserInfoCtrl;
        private var var_4174:UserInfoCtrl;
        private var _disposed:Boolean;

        public function IssueHandler(param1:ModerationManager, param2:IssueBundle)
        {
            this.var_4171 = param1;
            this.var_4172 = param2;
        }

        public function getType():int
        {
            return (WindowTracker.TYPE_ISSUEHANDLER);
        }

        public function getId():String
        {
            return ("" + this.var_4172.id);
        }

        public function getFrame():IFrameWindow
        {
            return (this._window);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_4173 != null)
            {
                this.var_4173.dispose();
                this.var_4173 = null;
            };
            if (this.var_4174 != null)
            {
                this.var_4174.dispose();
                this.var_4174 = null;
            };
            this.var_4171 = null;
            this.var_4172 = null;
        }

        public function show():void
        {
            this.createView();
        }

        private function createView():void
        {
            var _loc6_:IItemListWindow;
            var _loc7_:IWindow;
            if (this._window != null)
            {
                return;
            };
            if (((this.var_4171.windowManager == null) || (this.var_4171.assets == null)))
            {
                return;
            };
            var _loc1_:XmlAsset = (this.var_4171.assets.getAssetByName("issue_handler_xml") as XmlAsset);
            if (((_loc1_ == null) || (_loc1_.content == null)))
            {
                return;
            };
            this._window = (this.var_4171.windowManager.buildFromXML((_loc1_.content as XML)) as IFrameWindow);
            if (this._window == null)
            {
                return;
            };
            var _loc2_:IWindow = this._window.findChildByTag("close");
            if (_loc2_ != null)
            {
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
            _loc2_ = this._window.findChildByName("issue_cont");
            if (_loc2_ != null)
            {
                _loc2_.addEventListener(WindowEvent.var_589, this.onResized);
            };
            this.setProc("close_useless", this.onCloseUseless);
            this.setProc("close_abusive", this.onCloseAbusive);
            this.setProc("close_resolved", this.onCloseResolved);
            this.setProc("release", this.onRelease);
            this.setProc("move_to_player_support", this.onMoveToPlayerSupport);
            this.setProc("show_chatlog", this.onShowChatlog);
            this.var_4171.disableButton(this.var_4171.initMsg.chatlogsPermission, this._window, "show_chatlog");
            _loc2_ = this._window.findChildByName("move_to_player_support");
            if (_loc2_ != null)
            {
                _loc2_.disable();
            };
            var _loc3_:IssueMessageData = this.var_4172.getHighestPriorityIssue();
            this.var_4173 = new UserInfoCtrl(this._window, this.var_4171, _loc3_.message);
            this.var_4174 = new UserInfoCtrl(this._window, this.var_4171, _loc3_.message);
            this.var_4173.load(IWindowContainer(this._window.findChildByName("caller_user_info")), _loc3_.reporterUserId);
            var _loc4_:IWindowContainer = IWindowContainer(this._window.findChildByName("reported_user_info"));
            if (this.var_4172.reportedUserId > 0)
            {
                this.var_4174.load(_loc4_, this.var_4172.reportedUserId);
            }
            else
            {
                _loc6_ = IItemListWindow(this._window.findChildByName("issue_cont"));
                _loc7_ = this._window.findChildByName("reported_user_info_caption");
                _loc6_.removeListItem(_loc7_);
                _loc6_.removeListItem(_loc4_);
            };
            var _loc5_:ICheckBoxWindow = (this._window.findChildByName("handle_next_checkbox") as ICheckBoxWindow);
            if (_loc5_ != null)
            {
                _loc5_.select();
            };
            Logger.log(("HARASSER: " + this.var_4172.reportedUserId));
            this.updateIssueList();
            this.updateMessages();
        }

        private function onResized(param1:WindowEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:IItemListWindow = (param1.window as IItemListWindow);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IItemListWindow = (_loc2_.getListItemByName("issues_item_list") as IItemListWindow);
            var _loc4_:IItemListWindow = (_loc2_.getListItemByName("msg_item_list") as IItemListWindow);
            if (((_loc3_ == null) || (_loc4_ == null)))
            {
                return;
            };
            var _loc5_:int = ((((_loc2_.height - _loc2_.scrollableRegion.height) + _loc3_.height) + _loc4_.height) * 0.5);
            _loc2_.autoArrangeItems = false;
            _loc3_.height = _loc5_;
            _loc4_.height = _loc5_;
            _loc2_.autoArrangeItems = true;
        }

        private function updateIssueList():void
        {
            var _loc4_:IWindowContainer;
            var _loc7_:IssueMessageData;
            var _loc9_:XmlAsset;
            var _loc10_:IWindowContainer;
            var _loc11_:IWindow;
            var _loc12_:IWindow;
            if (this._window == null)
            {
                return;
            };
            var _loc1_:IItemListWindow = (this._window.findChildByName("issues_item_list") as IItemListWindow);
            if (_loc1_ == null)
            {
                return;
            };
            var _loc2_:Array = this.var_4172.issues;
            var _loc3_:int;
            var _loc5_:int = _loc1_.numListItems;
            var _loc6_:int = _loc2_.length;
            if (_loc5_ < _loc6_)
            {
                _loc9_ = (this.var_4171.assets.getAssetByName("issue_handler_issue_info_xml") as XmlAsset);
                if (((_loc9_ == null) || (_loc9_.content == null)))
                {
                    return;
                };
                _loc4_ = (this.var_4171.windowManager.buildFromXML((_loc9_.content as XML)) as IWindowContainer);
                if (_loc4_ == null)
                {
                    return;
                };
                _loc1_.addListItem(_loc4_);
                _loc3_ = 1;
                while (_loc3_ < (_loc6_ - _loc5_))
                {
                    _loc10_ = (_loc4_.clone() as IWindowContainer);
                    if (_loc10_ == null)
                    {
                        return;
                    };
                    _loc1_.addListItem(_loc10_);
                    _loc3_++;
                };
            }
            else
            {
                if (_loc5_ > _loc6_)
                {
                    _loc3_ = 0;
                    while (_loc3_ < (_loc5_ - _loc6_))
                    {
                        _loc11_ = _loc1_.removeListItemAt(0);
                        _loc11_.dispose();
                        _loc3_++;
                    };
                };
            };
            var _loc8_:int = getTimer();
            _loc3_ = 0;
            for each (_loc7_ in _loc2_)
            {
                _loc4_ = (_loc1_.getListItemAt(_loc3_) as IWindowContainer);
                if (_loc4_ == null)
                {
                    return;
                };
                _loc4_.background = ((_loc3_++ % 2) == 0);
                _loc12_ = _loc4_.findChildByName("reporter");
                if (_loc12_ != null)
                {
                    _loc12_.caption = _loc7_.reporterUserName;
                    _loc12_.id = _loc7_.reporterUserId;
                    _loc12_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onReporterClicked);
                    _loc12_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onReporterClicked);
                };
                this.setCaption(_loc4_.findChildByName("category"), IssueCategoryNames.getCategoryName(_loc7_.reportedCategoryId));
                this.setCaption(_loc4_.findChildByName("room"), _loc7_.roomName);
                this.setCaption(_loc4_.findChildByName("time_open"), _loc7_.getOpenTime(_loc8_));
            };
        }

        private function updateMessages():void
        {
            var _loc4_:ITextWindow;
            var _loc7_:IssueMessageData;
            var _loc8_:XmlAsset;
            var _loc9_:ITextWindow;
            var _loc10_:IWindow;
            if (this._window == null)
            {
                return;
            };
            var _loc1_:IItemListWindow = (this._window.findChildByName("msg_item_list") as IItemListWindow);
            if (_loc1_ == null)
            {
                return;
            };
            var _loc2_:Array = this.var_4172.issues;
            var _loc3_:int;
            var _loc5_:int = _loc1_.numListItems;
            var _loc6_:int = _loc2_.length;
            if (_loc5_ < _loc6_)
            {
                _loc8_ = (this.var_4171.assets.getAssetByName("issue_handler_message_list_item_xml") as XmlAsset);
                if (((_loc8_ == null) || (_loc8_.content == null)))
                {
                    return;
                };
                _loc4_ = (this.var_4171.windowManager.buildFromXML((_loc8_.content as XML)) as ITextWindow);
                if (_loc4_ == null)
                {
                    return;
                };
                _loc1_.addListItem(_loc4_);
                _loc3_ = 1;
                while (_loc3_ < (_loc6_ - _loc5_))
                {
                    _loc9_ = (_loc4_.clone() as ITextWindow);
                    if (_loc9_ == null)
                    {
                        return;
                    };
                    _loc1_.addListItem(_loc9_);
                    _loc3_++;
                };
            }
            else
            {
                if (_loc5_ > _loc6_)
                {
                    _loc3_ = 0;
                    while (_loc3_ < (_loc5_ - _loc6_))
                    {
                        _loc10_ = _loc1_.removeListItemAt(0);
                        _loc10_.dispose();
                        _loc3_++;
                    };
                };
            };
            _loc3_ = 0;
            for each (_loc7_ in _loc2_)
            {
                _loc4_ = (_loc1_.getListItemAt(_loc3_) as ITextWindow);
                if (_loc4_ == null)
                {
                    return;
                };
                _loc4_.width = _loc1_.width;
                _loc4_.background = ((_loc3_++ % 2) == 0);
                _loc4_.caption = ((_loc7_.reporterUserName + ": ") + _loc7_.message);
                _loc4_.height = (_loc4_.textHeight + 10);
            };
        }

        private function setCaption(param1:IWindow, param2:String):void
        {
            if (param1 != null)
            {
                param1.caption = param2;
            };
        }

        private function setProc(param1:String, param2:Function):void
        {
            this._window.findChildByName(param1).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, param2);
        }

        private function onClose(param1:WindowMouseEvent):void
        {
            if ((((!(this.var_4171 == null)) && (!(this.var_4171.issueManager == null))) && (!(this.var_4172 == null))))
            {
                this.var_4171.issueManager.removeHandler(this.var_4172.id);
            };
            this.dispose();
        }

        private function onCloseUseless(param1:WindowMouseEvent):void
        {
            Logger.log("Close useless clicked");
            this.var_4171.issueManager.closeBundle(this.var_4172.id, 1);
            this.checkAutoHandling();
            this.dispose();
        }

        private function onCloseAbusive(param1:WindowMouseEvent):void
        {
            Logger.log("Close abusive clicked");
            this.var_4171.issueManager.closeBundle(this.var_4172.id, 2);
            this.checkAutoHandling();
            this.dispose();
        }

        private function onCloseResolved(param1:WindowMouseEvent):void
        {
            Logger.log("Close resolved clicked");
            this.var_4171.issueManager.closeBundle(this.var_4172.id, 3);
            this.checkAutoHandling();
            this.dispose();
        }

        private function onRelease(param1:WindowMouseEvent):void
        {
            Logger.log("Release clicked");
            this.var_4171.issueManager.releaseBundle(this.var_4172.id);
            this.checkAutoHandling();
            this.dispose();
        }

        private function onMoveToPlayerSupport(param1:WindowMouseEvent):void
        {
            Logger.log("Move to player support clicked");
        }

        private function onShowChatlog(param1:WindowMouseEvent):void
        {
            Logger.log("Show chatlog clicked");
            var _loc2_:int = this.var_4172.getHighestPriorityIssue().issueId;
            this.var_4171.windowTracker.show(new ChatlogCtrl(new GetCfhChatlogMessageComposer(_loc2_), this.var_4171, WindowTracker.var_1523, _loc2_), this._window, false, false, true);
        }

        private function onReporterClicked(param1:WindowMouseEvent):void
        {
            var _loc3_:IssueMessageData;
            var _loc2_:int = param1.window.id;
            if (_loc2_ != 0)
            {
                if (this.var_4173 != null)
                {
                    this.var_4173.dispose();
                };
                _loc3_ = this.var_4172.getHighestPriorityIssue();
                this.var_4173 = new UserInfoCtrl(this._window, this.var_4171, _loc3_.message);
                this.var_4173.load(IWindowContainer(this._window.findChildByName("caller_user_info")), _loc2_);
            };
        }

        public function update():void
        {
            this.updateIssueList();
            this.updateMessages();
        }

        private function checkAutoHandling():void
        {
            if ((((this._window == null) || (this.var_4171 == null)) || (this.var_4171.issueManager == null)))
            {
                return;
            };
            var _loc1_:ICheckBoxWindow = (this._window.findChildByName("handle_next_checkbox") as ICheckBoxWindow);
            if (((!(_loc1_ == null)) && (_loc1_.isSelected)))
            {
                this.var_4171.issueManager.autoPick();
            };
        }


    }
}