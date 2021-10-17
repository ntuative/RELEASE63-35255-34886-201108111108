package com.sulake.habbo.help
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpReplyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsDeletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqClientFaqsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqCategoriesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqTextMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqSearchResultsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.FaqCategoryMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.IssueCloseNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.TutorialStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.HotelMergeNameChangeEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpReplyMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.habbo.communication.messages.parser.help.IssueCloseNotificationMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpResultMessageParser;
    import com.sulake.habbo.help.enum.CallForHelpResultEnum;
    import com.sulake.habbo.help.help.data.FaqCategory;
    import com.sulake.habbo.communication.messages.parser.help.FaqClientFaqsMessageParser;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.help.FaqCategoriesMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.FaqCategoryMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.FaqTextMessageParser;
    import com.sulake.habbo.help.help.data.FaqItem;
    import com.sulake.habbo.communication.messages.parser.help.FaqSearchResultsMessageParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.help.TutorialStatusMessageParser;

    public class IncomingMessages 
    {

        private var var_4007:HabboHelp;
        private var _userId:int = -1;
        private var var_3598:int = -1;

        public function IncomingMessages(param1:HabboHelp, param2:IHabboCommunicationManager)
        {
            this.var_4007 = param1;
            var _loc3_:IHabboCommunicationManager = param2;
            _loc3_.addHabboConnectionMessageEvent(new CallForHelpReplyMessageEvent(this.onCallForHelpReply));
            _loc3_.addHabboConnectionMessageEvent(new CallForHelpResultMessageEvent(this.onCallForHelpResult));
            _loc3_.addHabboConnectionMessageEvent(new CallForHelpPendingCallsDeletedMessageEvent(this.onPendingCallsForHelpDeleted));
            _loc3_.addHabboConnectionMessageEvent(new FaqClientFaqsMessageEvent(this.onFaqClientFaqs));
            _loc3_.addHabboConnectionMessageEvent(new FaqCategoriesMessageEvent(this.onFaqCategories));
            _loc3_.addHabboConnectionMessageEvent(new FaqTextMessageEvent(this.onFaqText));
            _loc3_.addHabboConnectionMessageEvent(new FaqSearchResultsMessageEvent(this.onFaqSearchResults));
            _loc3_.addHabboConnectionMessageEvent(new FaqCategoryMessageEvent(this.onFaqCategory));
            _loc3_.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEntryInfo));
            _loc3_.addHabboConnectionMessageEvent(new RoomReadyMessageEvent(this.onRoomReady));
            _loc3_.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(this.onGuestRoomResult));
            _loc3_.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObject));
            _loc3_.addHabboConnectionMessageEvent(new UserNameChangedMessageEvent(this.onUserNameChange));
            _loc3_.addHabboConnectionMessageEvent(new UsersMessageEvent(this.onUsers));
            _loc3_.addHabboConnectionMessageEvent(new IssueCloseNotificationMessageEvent(this.onIssueClose));
            _loc3_.addHabboConnectionMessageEvent(new TutorialStatusMessageEvent(this.onTutorialStatus));
            _loc3_.addHabboConnectionMessageEvent(new ChangeUserNameResultMessageEvent(this.onChangeUserNameResult));
            _loc3_.addHabboConnectionMessageEvent(new CheckUserNameResultMessageEvent(this.onCheckUserNameResult));
            _loc3_.addHabboConnectionMessageEvent(new HotelMergeNameChangeEvent(this.onHotelMergeNameChange));
        }

        private function onCallForHelpReply(param1:IMessageEvent):void
        {
            var _loc2_:CallForHelpReplyMessageParser = CallForHelpReplyMessageEvent(param1).getParser();
            this.var_4007.showCallForHelpReply(_loc2_.message);
        }

        private function onRoomEntryInfo(param1:IMessageEvent):void
        {
            var _loc2_:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(param1).getParser();
            if (((_loc2_.privateRoom) && (_loc2_.owner)))
            {
                this.var_4007.enableCallForGuideBotUI();
            }
            else
            {
                this.var_4007.disableCallForGuideBotUI();
            };
        }

        private function onRoomReady(param1:IMessageEvent):void
        {
            var _loc2_:RoomReadyMessageParser = RoomReadyMessageEvent(param1).getParser();
            if (_loc2_.roomType.indexOf("model_") == 0)
            {
                return;
            };
            var _loc3_:* = (((("nav_venue_" + _loc2_.roomType) + "/") + 0) + "_name");
            this.var_4007.userRegistry.registerRoom(this.var_4007.localization.getKey(_loc3_));
        }

        private function onGuestRoomResult(param1:IMessageEvent):void
        {
            var _loc2_:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(param1).getParser();
            this.var_4007.userRegistry.registerRoom(_loc2_.data.roomName);
        }

        private function onUserObject(param1:IMessageEvent):void
        {
            var _loc2_:UserObjectMessageParser = UserObjectEvent(param1).getParser();
            this._userId = _loc2_.id;
            this.var_4007.ownUserName = _loc2_.name;
        }

        private function onUserNameChange(param1:IMessageEvent):void
        {
            var _loc2_:UserNameChangedMessageParser = UserNameChangedMessageEvent(param1).getParser();
            if (this._userId != _loc2_.webId)
            {
                return;
            };
            this.var_4007.ownUserName = _loc2_.newName;
            if (this.var_4007.tutorialUI)
            {
                this.var_4007.tutorialUI.onUserNameChanged(_loc2_.newName);
            };
            if (this.var_4007.hotelMergeUI)
            {
                this.var_4007.hotelMergeUI.onUserNameChanged(_loc2_.newName);
            };
        }

        private function onUserChange(param1:IMessageEvent):void
        {
            var _loc2_:UserChangeMessageEvent = UserChangeMessageEvent(param1);
            if (this.var_3598 != _loc2_.id)
            {
                return;
            };
            if (((this.var_4007 == null) || (this.var_4007.tutorialUI == null)))
            {
                return;
            };
            this.var_4007.tutorialUI.onUserChanged();
        }

        private function onUsers(param1:IMessageEvent):void
        {
            var _loc5_:UserMessageData;
            var _loc2_:UsersMessageEvent = (param1 as UsersMessageEvent);
            var _loc3_:UsersMessageParser = _loc2_.getParser();
            var _loc4_:int;
            while (_loc4_ < _loc3_.getUserCount())
            {
                _loc5_ = _loc3_.getUser(_loc4_);
                if (((!(_loc5_.webID == this._userId)) && (_loc5_.userType == RoomObjectTypeEnum.var_1406)))
                {
                    this.var_4007.userRegistry.registerUser(_loc5_.webID, _loc5_.name);
                };
                if (_loc5_.webID == this._userId)
                {
                    this.var_3598 = _loc5_.id;
                };
                _loc4_++;
            };
            this.var_4007.tellUI(HabboHelpViewEnum.var_1401);
        }

        private function onIssueClose(param1:IMessageEvent):void
        {
            var _loc2_:IssueCloseNotificationMessageEvent = (param1 as IssueCloseNotificationMessageEvent);
            var _loc3_:IssueCloseNotificationMessageParser = _loc2_.getParser();
            this.var_4007.windowManager.alert("${mod.alert.title}", (("${help.cfh.closed." + this.getCloseReasonKey(_loc3_.closeReason)) + "}"), 0, this.onAlertClose);
        }

        private function getCloseReasonKey(param1:int):String
        {
            if (param1 == 1)
            {
                return ("useless");
            };
            if (param1 == 2)
            {
                return ("abusive");
            };
            return ("resolved");
        }

        private function onCallForHelpResult(param1:IMessageEvent):void
        {
            var _loc4_:String;
            var _loc2_:CallForHelpResultMessageParser = CallForHelpResultMessageEvent(param1).getParser();
            var _loc3_:int = _loc2_.resultType;
            switch (_loc3_)
            {
                case 1:
                    _loc4_ = CallForHelpResultEnum.var_1402;
                    break;
                case 2:
                    _loc4_ = CallForHelpResultEnum.var_1403;
                    break;
                default:
                    _loc4_ = CallForHelpResultEnum.var_1398;
            };
            this.var_4007.showCallForHelpResult(_loc4_);
        }

        private function onPendingCallsForHelpDeleted(param1:IMessageEvent):void
        {
            this.var_4007.showUI(HabboHelpViewEnum.var_279);
        }

        private function onFaqClientFaqs(param1:IMessageEvent):void
        {
            var _loc6_:FaqCategory;
            var _loc7_:int;
            var _loc2_:FaqClientFaqsMessageParser = FaqClientFaqsMessageEvent(param1).getParser();
            var _loc3_:FaqIndex = this.var_4007.getFaq();
            var _loc4_:Map = _loc2_.urgentData;
            var _loc5_:Map = _loc2_.normalData;
            if ((((_loc3_ == null) || (_loc4_ == null)) || (_loc5_ == null)))
            {
                return;
            };
            _loc6_ = _loc3_.getFrontPageUrgentCategory();
            _loc6_.reset();
            _loc6_.setTimeStamp();
            _loc7_ = 0;
            while (_loc7_ < _loc4_.length)
            {
                _loc6_.storeItem(_loc4_.getKey(_loc7_), _loc4_.getWithIndex(_loc7_));
                _loc7_++;
            };
            _loc6_ = _loc3_.getFrontPageNormalCategory();
            _loc6_.reset();
            _loc6_.setTimeStamp();
            _loc7_ = 0;
            while (_loc7_ < _loc5_.length)
            {
                _loc6_.storeItem(_loc5_.getKey(_loc7_), _loc5_.getWithIndex(_loc7_));
                _loc7_++;
            };
            this.var_4007.tellUI(HabboHelpViewEnum.var_1393);
        }

        private function onFaqCategories(param1:IMessageEvent):void
        {
            var _loc6_:int;
            var _loc7_:Map;
            var _loc8_:String;
            var _loc9_:FaqCategory;
            var _loc2_:FaqCategoriesMessageParser = FaqCategoriesMessageEvent(param1).getParser();
            var _loc3_:FaqIndex = this.var_4007.getFaq();
            var _loc4_:Map = _loc2_.data;
            if (((_loc3_ == null) || (_loc4_ == null)))
            {
                return;
            };
            var _loc5_:int;
            while (_loc5_ < _loc4_.length)
            {
                _loc6_ = _loc4_.getKey(_loc5_);
                _loc7_ = _loc4_.getWithIndex(_loc5_);
                _loc8_ = _loc7_.getValue("name");
                _loc9_ = _loc3_.getCategory(_loc6_, _loc8_, true);
                _loc9_.itemCount = _loc7_.getValue("count");
                _loc5_++;
            };
            this.var_4007.showUI(HabboHelpViewEnum.var_1394);
        }

        private function onFaqCategory(param1:IMessageEvent):void
        {
            var _loc8_:int;
            var _loc9_:String;
            var _loc2_:FaqCategoryMessageParser = FaqCategoryMessageEvent(param1).getParser();
            var _loc3_:FaqIndex = this.var_4007.getFaq();
            var _loc4_:Map = _loc2_.data;
            if (((_loc3_ == null) || (_loc4_ == null)))
            {
                return;
            };
            var _loc5_:int = _loc2_.categoryId;
            var _loc6_:FaqCategory = _loc3_.getCategory(_loc5_);
            if (_loc6_ == null)
            {
                return;
            };
            _loc6_.description = _loc2_.description;
            _loc6_.setTimeStamp();
            var _loc7_:int;
            while (_loc7_ < _loc4_.length)
            {
                _loc8_ = _loc4_.getKey(_loc7_);
                _loc9_ = _loc4_.getWithIndex(_loc7_);
                _loc6_.storeItem(_loc8_, _loc9_);
                _loc7_++;
            };
            this.var_4007.tellUI(HabboHelpViewEnum.var_1395, _loc6_);
        }

        private function onFaqText(param1:IMessageEvent):void
        {
            var _loc2_:FaqTextMessageParser = FaqTextMessageEvent(param1).getParser();
            var _loc3_:FaqIndex = this.var_4007.getFaq();
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.storeAnswerText(_loc2_.questionId, _loc2_.answerText);
            var _loc4_:FaqItem = _loc3_.getItem(_loc2_.questionId);
            if (_loc4_ != null)
            {
                this.var_4007.tellUI(HabboHelpViewEnum.var_1396, _loc4_);
            };
        }

        private function onFaqSearchResults(param1:IMessageEvent):void
        {
            var _loc2_:FaqSearchResultsMessageParser = FaqSearchResultsMessageEvent(param1).getParser();
            var _loc3_:FaqIndex = this.var_4007.getFaq();
            var _loc4_:Map = _loc2_.data;
            if (((_loc3_ == null) || (_loc4_ == null)))
            {
                return;
            };
            var _loc5_:FaqCategory = _loc3_.getSearchResultCategory();
            _loc5_.reset();
            _loc5_.setTimeStamp();
            var _loc6_:int;
            while (_loc6_ < _loc4_.length)
            {
                _loc5_.storeItem(_loc4_.getKey(_loc6_), _loc4_.getWithIndex(_loc6_));
                _loc6_++;
            };
            this.var_4007.showUI(HabboHelpViewEnum.var_1405);
            this.var_4007.tellUI(HabboHelpViewEnum.var_1405, _loc5_);
        }

        private function onAlertClose(param1:IAlertDialog, param2:WindowEvent):void
        {
            param1.dispose();
        }

        private function onTutorialStatus(param1:IMessageEvent):void
        {
            if (this.var_4007 == null)
            {
                return;
            };
            var _loc2_:TutorialStatusMessageParser = (param1 as TutorialStatusMessageEvent).getParser();
            this.var_4007.updateTutorial(_loc2_.hasChangedLooks, _loc2_.hasChangedName, _loc2_.hasCalledGuideBot);
        }

        private function onChangeUserNameResult(param1:ChangeUserNameResultMessageEvent):void
        {
            if (!this.var_4007)
            {
                return;
            };
            if (this.var_4007.tutorialUI)
            {
                this.var_4007.tutorialUI.onChangeUserNameResult(param1);
            };
            if (this.var_4007.hotelMergeUI)
            {
                this.var_4007.hotelMergeUI.onChangeUserNameResult(param1);
            };
        }

        private function onCheckUserNameResult(param1:CheckUserNameResultMessageEvent):void
        {
            if (!this.var_4007)
            {
                return;
            };
            if (this.var_4007.tutorialUI)
            {
                this.var_4007.tutorialUI.onCheckUserNameResult(param1);
            };
            if (this.var_4007.hotelMergeUI)
            {
                this.var_4007.hotelMergeUI.onCheckUserNameResult(param1);
            };
        }

        private function onHotelMergeNameChange(param1:HotelMergeNameChangeEvent):void
        {
            if (!this.var_4007)
            {
                return;
            };
            this.var_4007.initHotelMergeUI();
        }


    }
}