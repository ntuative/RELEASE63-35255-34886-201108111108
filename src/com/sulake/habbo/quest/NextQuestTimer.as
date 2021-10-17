package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class NextQuestTimer implements IDisposable 
    {

        public static const var_2169:int = 1000;
        private static const var_621:String = "next_quest";

        private var var_4407:HabboQuestEngine;
        private var var_3788:QuestMessageData;
        private var _window:IWindowContainer;
        private var var_4442:Boolean = false;
        private var var_4443:int;

        public function NextQuestTimer(param1:HabboQuestEngine)
        {
            this.var_4407 = param1;
        }

        public function dispose():void
        {
            if (this.var_4407)
            {
                this.var_4407.toolbar.extensionView.detachExtension(var_621);
            };
            this.var_4407 = null;
            this.var_3788 = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this.var_4407 == null);
        }

        public function onQuestCancelled():void
        {
            this.var_3788 = null;
            this.close();
        }

        public function onRoomExit():void
        {
            if (((!(this._window == null)) && (this._window.visible)))
            {
                this._window.findChildByName("more_info_region").visible = false;
                this._window.findChildByName("more_info_txt").visible = false;
            };
        }

        public function onQuest(param1:QuestMessageData):void
        {
            if (param1.waitPeriodSeconds < 1)
            {
                this.close();
                return;
            };
            this.var_3788 = param1;
            this.prepareWindow();
            this.refreshVisibility();
            this._window.visible = true;
            this.var_4407.toolbar.extensionView.attachExtension(var_621, this._window);
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            this._window = IWindowContainer(this.var_4407.getXmlWindow("NextQuestTimer"));
            this._window.x = 0;
            this._window.y = 0;
            this._window.findChildByName("more_info_region").procedure = this.onMoreInfo;
            new PendingImage(this.var_4407, this._window.findChildByName("quest_timer_expanded"), "quest_timer_expanded");
            new PendingImage(this.var_4407, this._window.findChildByName("quest_timer_contracted"), "quest_timer_contracted");
            new PendingImage(this.var_4407, this._window.findChildByName("quest_pic_bitmap"), "quest_timer_questionmark");
            this._window.findChildByName("quest_timer_expanded").procedure = this.onToggleExpanded;
            this._window.findChildByName("quest_timer_contracted").procedure = this.onToggleExpanded;
            this.refreshVisibility();
        }

        private function refresh():void
        {
            var _loc1_:int = this.var_3788.waitPeriodSeconds;
            if (_loc1_ < 1)
            {
                this.close();
                this.var_3788.waitPeriodSeconds = 0;
                this.var_4407.questController.onQuest(this.var_3788);
            };
            var _loc2_:String = FriendlyTime.getFriendlyTime(this.var_4407.localization, _loc1_);
            var _loc3_:* = (this.var_3788.getCampaignLocalizationKey() + ".delayedmsg");
            this.var_4407.localization.registerParameter("quests.nextquesttimer.caption.contracted", "time", _loc2_);
            this.var_4407.localization.registerParameter(_loc3_, "time", _loc2_);
            this._window.findChildByName("quest_header_txt").caption = this.var_4407.localization.getKey(("quests.nextquesttimer.caption." + ((this.var_4442) ? "expanded" : "contracted")));
            this._window.findChildByName("desc_txt").caption = this.var_4407.localization.getKey(_loc3_, _loc3_);
        }

        private function refreshVisibility():void
        {
            this._window.findChildByName("quest_timer_expanded").visible = this.var_4442;
            this._window.findChildByName("quest_timer_contracted").visible = (!(this.var_4442));
            this._window.findChildByName("more_info_txt").visible = ((this.var_4442) && (this.var_4407.currentlyInRoom));
            this._window.findChildByName("more_info_region").visible = ((this.var_4442) && (this.var_4407.currentlyInRoom));
            this._window.findChildByName("quest_pic_bitmap").visible = this.var_4442;
            this._window.findChildByName("desc_txt").visible = this.var_4442;
            this.refresh();
        }

        private function onMoreInfo(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.var_4407.questController.questDetails.showDetails(this.var_3788);
            };
        }

        private function onToggleExpanded(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.var_4442 = (!(this.var_4442));
                this.refreshVisibility();
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
            this.var_4443 = var_2169;
            this.refresh();
        }

        private function getDefaultLocationX():int
        {
            return (0);
        }

        public function isVisible():Boolean
        {
            return ((this._window) && (this._window.visible));
        }

        public function close():void
        {
            if (((!(this._window == null)) && (this._window.visible)))
            {
                this._window.visible = false;
                this.var_4407.toolbar.extensionView.detachExtension(var_621);
            };
        }

        private function setQuestImageVisible(param1:Boolean):void
        {
            this._window.findChildByName("quest_pic_bitmap").visible = param1;
        }


    }
}