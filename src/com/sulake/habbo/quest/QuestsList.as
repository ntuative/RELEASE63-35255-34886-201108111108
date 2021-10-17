package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.help.WelcomeNotification;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.AcceptQuestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.RejectQuestMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class QuestsList implements IDisposable 
    {

        private static const var_2195:int = 5;
        private static const var_2193:int = 10;
        private static const var_2194:int = 10;
        private static const var_2196:int = 30;

        private var var_4407:HabboQuestEngine;
        private var _window:IFrameWindow;
        private var var_2632:IItemListWindow;
        private var var_2713:IScrollbarWindow;
        private var var_4463:Boolean = true;
        private var var_4464:Boolean;
        private var var_4304:WindowToggle;
        private var var_3789:Array;
        private var var_4443:int = 1000;

        public function QuestsList(param1:HabboQuestEngine)
        {
            this.var_4407 = param1;
        }

        public function dispose():void
        {
            this.var_4407 = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_4304)
            {
                this.var_4304.dispose();
                this.var_4304 = null;
            };
            this.var_2632 = null;
            this.var_2713 = null;
            this.var_3789 = null;
        }

        public function get disposed():Boolean
        {
            return (this.var_4407 == null);
        }

        public function isVisible():Boolean
        {
            return ((this._window) && (this._window.visible));
        }

        public function close():void
        {
            if (this._window)
            {
                this._window.visible = false;
            };
        }

        public function onRoomExit():void
        {
            this.close();
        }

        public function onToolbarClick():void
        {
            if (!this._window)
            {
                this.requestQuests();
                return;
            };
            if (((!(this.var_4304)) || (this.var_4304.disposed)))
            {
                this.var_4304 = new WindowToggle(this._window, this._window.desktop, this.requestQuests, this.close);
            };
            this.var_4304.toggle();
            this.var_4463 = false;
        }

        private function requestQuests():void
        {
            this.var_4407.send(new GetQuestsMessageComposer());
        }

        public function onQuests(param1:Array, param2:Boolean):void
        {
            var _loc3_:QuestMessageData;
            this.var_3789 = param1;
            if (((!(this.isVisible())) && (!(param2))))
            {
                return;
            };
            this.refresh(false);
            this._window.visible = true;
            this._window.activate();
            this.var_4464 = false;
            for each (_loc3_ in param1)
            {
                if (_loc3_.accepted)
                {
                    this.var_4464 = true;
                };
            };
        }

        private function refresh(param1:Boolean):void
        {
            var _loc3_:Boolean;
            this.prepareWindow();
            this.var_2632.autoArrangeItems = false;
            var _loc2_:int;
            while (true)
            {
                if (_loc2_ < this.var_3789.length)
                {
                    this.refreshEntry(true, _loc2_, this.var_3789[_loc2_], param1);
                }
                else
                {
                    _loc3_ = this.refreshEntry(false, _loc2_, null, param1);
                    if (_loc3_) break;
                };
                _loc2_++;
            };
            this.var_2632.autoArrangeItems = true;
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            this._window = IFrameWindow(this.var_4407.getXmlWindow("Quests"));
            this._window.findChildByTag("close").procedure = this.onWindowClose;
            this.var_2632 = IItemListWindow(this._window.findChildByName("quest_list"));
            this.var_2713 = IScrollbarWindow(this._window.findChildByName("scroller"));
            this._window.center();
            this.var_2632.spacing = var_2193;
        }

        private function refreshEntry(param1:Boolean, param2:int, param3:QuestMessageData, param4:Boolean):Boolean
        {
            var _loc5_:IWindowContainer = IWindowContainer(this.var_2632.getListItemAt(param2));
            var _loc6_:Boolean;
            if (_loc5_ == null)
            {
                if (!param1)
                {
                    return (true);
                };
                _loc5_ = this.createListEntry();
                this.var_2632.addListItem(_loc5_);
                _loc6_ = true;
            };
            if (param1)
            {
                if (param4)
                {
                    this.refreshDelay(_loc5_, param3);
                }
                else
                {
                    this.refreshEntryDetails(_loc5_, param3);
                };
                _loc5_.visible = true;
            }
            else
            {
                _loc5_.visible = false;
            };
            return (false);
        }

        public function createListEntry():IWindowContainer
        {
            var _loc1_:IWindowContainer = IWindowContainer(this.var_4407.getXmlWindow("QuestEntry"));
            var _loc2_:IWindowContainer = IWindowContainer(this.var_4407.getXmlWindow("Campaign"));
            var _loc3_:IWindowContainer = IWindowContainer(this.var_4407.getXmlWindow("Quest"));
            var _loc4_:IWindowContainer = IWindowContainer(this.var_4407.getXmlWindow("EntryArrows"));
            var _loc5_:IWindowContainer = IWindowContainer(this.var_4407.getXmlWindow("CampaignCompleted"));
            _loc1_.addChild(_loc2_);
            _loc1_.addChild(_loc3_);
            _loc1_.addChild(_loc5_);
            _loc1_.addChild(_loc4_);
            _loc3_.findChildByName("accept_button").procedure = this.onAcceptQuest;
            _loc3_.findChildByName("cancel_region").procedure = this.onCancelQuest;
            _loc1_.findChildByName("hint_txt").visible = false;
            _loc1_.findChildByName("link_region").visible = false;
            var _loc6_:IWindow = _loc1_.findChildByName("cancel_region");
            var _loc7_:IWindow = _loc1_.findChildByName("cancel_txt");
            _loc6_.width = _loc7_.width;
            _loc6_.x = ((_loc3_.width - _loc6_.width) - var_2194);
            new PendingImage(this.var_4407, IBitmapWrapperWindow(_loc4_.findChildByName("arrow_0")), "quest_arrow1");
            new PendingImage(this.var_4407, IBitmapWrapperWindow(_loc4_.findChildByName("arrow_1")), "quest_arrow2");
            new PendingImage(this.var_4407, IBitmapWrapperWindow(_loc2_.findChildByName("completion_bg_red_bitmap")), "quest_counterbkg_disabled");
            new PendingImage(this.var_4407, IBitmapWrapperWindow(_loc2_.findChildByName("completion_bg_blue_bitmap")), "quest_counterbkg_active");
            new PendingImage(this.var_4407, IBitmapWrapperWindow(_loc2_.findChildByName("completion_bg_green_bitmap")), "quest_counterbkg_completed");
            new PendingImage(this.var_4407, IBitmapWrapperWindow(_loc5_.findChildByName("completed_pic_bitmap")), "category_completed");
            _loc3_.x = ((_loc2_.x + _loc2_.width) + var_2195);
            _loc1_.width = (_loc3_.x + _loc3_.width);
            _loc5_.x = _loc3_.x;
            this.setEntryHeight(_loc1_);
            return (_loc1_);
        }

        public function setEntryHeight(param1:IWindowContainer):void
        {
            var _loc2_:IWindowContainer = IWindowContainer(param1.findChildByName("campaign_container"));
            var _loc3_:IWindowContainer = IWindowContainer(param1.findChildByName("quest_container"));
            var _loc4_:IWindowContainer = IWindowContainer(param1.findChildByName("entry_arrows_cont"));
            _loc2_.height = _loc3_.height;
            param1.height = _loc3_.height;
            _loc4_.x = ((_loc2_.x + _loc2_.width) - 2);
            _loc4_.y = (Math.floor(((_loc2_.height - _loc4_.height) / 2)) + 1);
            _loc2_.findChildByName("completion_txt").y = (_loc2_.height - var_2196);
            var _loc5_:int = 2;
            var _loc6_:IWindow = _loc2_.findChildByName("bg_bottom");
            _loc6_.height = Math.floor(((_loc2_.height - (2 * _loc5_)) / 2));
            _loc6_.y = (_loc5_ + _loc6_.height);
        }

        public function refreshEntryDetails(param1:IWindowContainer, param2:QuestMessageData):void
        {
            param1.findChildByName("campaign_header_txt").caption = this.var_4407.getCampaignName(param2);
            param1.findChildByName("completion_txt").caption = ((param2.completedQuestsInCampaign + "/") + param2.questCountInCampaign);
            this.var_4407.setupCampaignImage(param1, param2, true);
            this.setColor(param1, "bg", param2.accepted, 4290944315, 4284769380);
            this.setColor(param1, "bg_top", param2.accepted, 0xFFFFD788, 4290427578);
            this.setColor(param1, "bg_bottom", param2.accepted, 0xFFFFC758, 4289440683);
            param1.findChildByName("completion_bg_red_bitmap").visible = ((!(param2.completedCampaign)) && (param2.completedQuestsInCampaign < 1));
            param1.findChildByName("completion_bg_blue_bitmap").visible = ((!(param2.completedCampaign)) && (param2.completedQuestsInCampaign > 0));
            param1.findChildByName("completion_bg_green_bitmap").visible = param2.completedCampaign;
            param1.findChildByName("arrow_0").visible = (!(param2.accepted));
            param1.findChildByName("arrow_1").visible = param2.accepted;
            param1.findChildByName("quest_container").visible = (!(param2.completedCampaign));
            param1.findChildByName("campaign_completed_container").visible = param2.completedCampaign;
            if (!param2.completedCampaign)
            {
                this.refreshEntryQuestDetails(IWindowContainer(param1.findChildByName("quest_container")), param2);
                this.refreshDelay(param1, param2);
            };
        }

        private function refreshEntryQuestDetails(param1:IWindowContainer, param2:QuestMessageData):void
        {
            param1.findChildByName("quest_header_txt").caption = this.var_4407.getQuestRowTitle(param2);
            param1.findChildByName("desc_txt").caption = this.var_4407.getQuestDesc(param2);
            param1.findChildByName("cancel_txt").visible = param2.accepted;
            param1.findChildByName("cancel_region").visible = param2.accepted;
            param1.findChildByName("accept_button").visible = (!(param2.accepted));
            param1.findChildByName("accept_button").id = param2.id;
            this.setColor(param1, null, param2.accepted, 15982264, 0xC8C8C8);
            this.setColor(param1, "quest_header", param2.accepted, 15577658, 0x8D8D8D);
            ITextWindow(param1.findChildByName("quest_header_txt")).textColor = ((param2.accepted) ? 0xFFFFFFFF : 4281808695);
            this.var_4407.setupQuestImage(param1, param2);
            this.var_4407.refreshReward((param2.waitPeriodSeconds < 1), param1, param2.activityPointType, param2.rewardCurrencyAmount);
            param1.findChildByName("delay_desc_txt").visible = (param2.waitPeriodSeconds > 0);
            param1.findChildByName("delay_txt").visible = (param2.waitPeriodSeconds > 0);
            param1.findChildByName("desc_txt").visible = (param2.waitPeriodSeconds < 1);
        }

        public function refreshDelay(param1:IWindowContainer, param2:QuestMessageData):Boolean
        {
            var _loc3_:int;
            var _loc4_:String;
            if (param1.findChildByName("delay_desc_txt").visible)
            {
                _loc3_ = param2.waitPeriodSeconds;
                if (_loc3_ > 0)
                {
                    _loc4_ = FriendlyTime.getFriendlyTime(this.var_4407.localization, _loc3_);
                    param1.findChildByName("delay_txt").caption = _loc4_;
                }
                else
                {
                    this.refreshEntryQuestDetails(param1, param2);
                    return (true);
                };
            };
            return (false);
        }

        private function onWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:Boolean;
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.close();
                _loc3_ = Boolean(parseInt(this.var_4407.configuration.getKey("new.identity", "0")));
                if ((((_loc3_) && (this.var_4463)) && (!(this.var_4464))))
                {
                    this.var_4463 = false;
                    this.var_4407.habboHelp.showWelcomeScreen(new WelcomeNotification(HabboToolbarIconEnum.QUESTS, "quests.rejectnotification"));
                };
            };
        }

        private function onAcceptQuest(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:int = param2.id;
            Logger.log(("Accept quest: " + _loc3_));
            this.var_4407.send(new AcceptQuestMessageComposer(_loc3_));
            this._window.visible = false;
        }

        private function onCancelQuest(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Reject quest");
            this.var_4407.send(new RejectQuestMessageComposer());
        }

        private function setColor(param1:IWindowContainer, param2:String, param3:Boolean, param4:uint, param5:uint):void
        {
            ((param2 == null) ? param1 : param1.findChildByName(param2)).color = ((param3) ? param4 : param5);
        }

        public function onAlert(param1:IAlertDialog, param2:WindowEvent):void
        {
            if (((param2.type == WindowEvent.var_131) || (param2.type == WindowEvent.var_132)))
            {
                param1.dispose();
            };
        }

        public function update(param1:uint):void
        {
            if (((this._window == null) || (!(this._window.visible))))
            {
                return;
            };
            this.var_4443 = (this.var_4443 - param1);
            if (this.var_4443 > 0)
            {
                return;
            };
            this.var_4443 = NextQuestTimer.var_2169;
            this.refresh(true);
        }


    }
}