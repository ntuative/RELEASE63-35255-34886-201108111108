package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.OpenQuestTrackerMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
    import com.sulake.core.window.components.ITextWindow;

    public class QuestCompleted implements IDisposable 
    {

        private static const var_2200:int = 2000;
        private static const var_2198:int = 5;
        private static const var_2201:int = 31;

        private var _window:IFrameWindow;
        private var var_4407:HabboQuestEngine;
        private var var_3788:QuestMessageData;
        private var var_4434:Animation;
        private var var_4457:int;

        public function QuestCompleted(param1:HabboQuestEngine)
        {
            this.var_4407 = param1;
        }

        public function dispose():void
        {
            this.var_4407 = null;
            this.var_3788 = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_4434)
            {
                this.var_4434.dispose();
                this.var_4434 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this._window == null);
        }

        public function onQuest(param1:QuestMessageData):void
        {
            this.close();
        }

        public function onQuestCancelled():void
        {
            this.close();
        }

        public function onQuestCompleted(param1:QuestMessageData):void
        {
            this.prepare(param1);
            this.var_4457 = var_2200;
        }

        private function close():void
        {
            if (this._window)
            {
                this._window.visible = false;
            };
        }

        private function onNextQuest(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this._window.visible = false;
            this.var_4407.questController.questDetails.openForNextQuest = (this.var_4407.configuration.getKey("questing.showDetailsForNextQuest") == "true");
            this.var_4407.send(new OpenQuestTrackerMessageComposer());
        }

        private function onMoreQuests(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this._window.visible = false;
                this.var_4407.send(new GetQuestsMessageComposer());
            };
        }

        public function prepare(param1:QuestMessageData):void
        {
            this.var_3788 = param1;
            if (this._window == null)
            {
                this._window = IFrameWindow(this.var_4407.getXmlWindow("QuestCompletedDialog"));
                this._window.findChildByTag("close").procedure = this.onNextQuest;
                this._window.findChildByName("next_quest_button").procedure = this.onNextQuest;
                this._window.findChildByName("more_quests_button").procedure = this.onMoreQuests;
                new PendingImage(this.var_4407, this._window.findChildByName("reward_icon"), "quest_doneicon");
                new PendingImage(this.var_4407, this._window.findChildByName("campaign_reward_icon"), "ach_receive_star");
                this._window.findChildByName("catalog_link_region").procedure = this.onCatalogLink;
                this.var_4434 = this.var_4407.getTwinkleAnimation(this._window);
            };
            this._window.findChildByName("catalog_link_txt").caption = this.var_4407.localization.getKey(("quests.completed.cataloglink." + this.var_3788.activityPointType));
            var _loc2_:String = ("quests.completed.reward." + this.var_3788.activityPointType);
            this.var_4407.localization.registerParameter(_loc2_, "amount", this.var_3788.rewardCurrencyAmount.toString());
            this._window.findChildByName("reward_txt").caption = this.var_4407.localization.getKey(_loc2_, _loc2_);
            this._window.visible = false;
            this._window.findChildByName("congrats_txt").caption = this.var_4407.localization.getKey(((this.var_3788.lastQuestInCampaign) ? "quests.completed.campaign.caption" : "quests.completed.quest.caption"));
            this._window.findChildByName("more_quests_button").visible = this.var_3788.lastQuestInCampaign;
            this._window.findChildByName("campaign_reward_icon").visible = this.var_3788.lastQuestInCampaign;
            this._window.findChildByName("catalog_link_region").visible = (!(this.var_3788.lastQuestInCampaign));
            this._window.findChildByName("next_quest_button").visible = (!(this.var_3788.lastQuestInCampaign));
            this._window.findChildByName("reward_icon").visible = (!(this.var_3788.lastQuestInCampaign));
            this._window.findChildByName("campaign_reward_icon").visible = this.var_3788.lastQuestInCampaign;
            this._window.findChildByName("campaign_pic_bitmap").visible = this.var_3788.lastQuestInCampaign;
            this.setWindowTitle(((this.var_3788.lastQuestInCampaign) ? "quests.completed.campaign.title" : "quests.completed.quest.title"));
            this.var_4407.setupCampaignImage(this._window, param1, this.var_3788.lastQuestInCampaign);
            var _loc3_:ITextWindow = ITextWindow(this._window.findChildByName("desc_txt"));
            var _loc4_:int = _loc3_.height;
            this.setDesc((this.var_3788.getQuestLocalizationKey() + ".completed"));
            _loc3_.height = Math.max(var_2201, (_loc3_.textHeight + var_2198));
            var _loc5_:int = (_loc3_.height - _loc4_);
            this._window.height = (this._window.height + _loc5_);
        }

        private function setWindowTitle(param1:String):void
        {
            this.var_4407.localization.registerParameter(param1, "category", this.var_4407.getCampaignName(this.var_3788));
            this._window.caption = this.var_4407.localization.getKey(param1, param1);
        }

        private function setDesc(param1:String):void
        {
            this._window.findChildByName("desc_txt").caption = this.var_4407.localization.getKey(param1, param1);
        }

        private function onCatalogLink(param1:WindowEvent, param2:IWindow=null):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.var_4407.openCatalog(this.var_3788);
            };
        }

        public function update(param1:uint):void
        {
            if (this.var_4457 > 0)
            {
                this.var_4457 = (this.var_4457 - param1);
                if (this.var_4457 < 1)
                {
                    this._window.center();
                    this._window.visible = true;
                    this._window.activate();
                    if (this.var_3788.lastQuestInCampaign)
                    {
                        this.var_4434.restart();
                    }
                    else
                    {
                        this.var_4434.stop();
                    };
                };
            };
            if (this.var_4434 != null)
            {
                this.var_4434.update(param1);
            };
        }


    }
}