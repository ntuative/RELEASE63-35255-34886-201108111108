package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestCompletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestCancelledMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementShareIdMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestCompletedMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestsMessageParser;
    import com.sulake.habbo.communication.messages.parser.quest.QuestMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreMessageParser;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;

    public class IncomingMessages implements IDisposable 
    {

        private var var_4407:HabboQuestEngine;
        private var _communication:IHabboCommunicationManager;
        private var var_4441:IAlertDialog;
        private var var_1023:Boolean = false;

        public function IncomingMessages(param1:HabboQuestEngine)
        {
            this.var_4407 = param1;
            this._communication = this.var_4407.communication;
            this._communication.addHabboConnectionMessageEvent(new QuestCompletedMessageEvent(this.onQuestCompleted));
            this._communication.addHabboConnectionMessageEvent(new QuestCancelledMessageEvent(this.onQuestCancelled));
            this._communication.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(this.onRoomExit));
            this._communication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEnter));
            this._communication.addHabboConnectionMessageEvent(new QuestsMessageEvent(this.onQuests));
            this._communication.addHabboConnectionMessageEvent(new QuestMessageEvent(this.onQuest));
            this._communication.addHabboConnectionMessageEvent(new AchievementsEvent(this.onAchievements));
            this._communication.addHabboConnectionMessageEvent(new AchievementEvent(this.onAchievement));
            this._communication.addHabboConnectionMessageEvent(new AchievementsScoreEvent(this.onAchievementsScore));
            this._communication.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(this.onLevelUp));
            this._communication.addHabboConnectionMessageEvent(new HabboAchievementShareIdMessageEvent(this.onAchievementShareId));
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        private function onQuestCompleted(param1:IMessageEvent):void
        {
            var _loc2_:QuestCompletedMessageParser = (param1 as QuestCompletedMessageEvent).getParser();
            Logger.log(((("Quest Completed: " + _loc2_.questData.campaignCode) + " quest: ") + _loc2_.questData.id));
            this.var_4407.questController.onQuestCompleted(_loc2_.questData);
        }

        private function onQuestCancelled(param1:IMessageEvent):void
        {
            Logger.log("Quest Cancelled: ");
            this.var_4407.questController.onQuestCancelled();
        }

        private function onQuests(param1:IMessageEvent):void
        {
            var _loc2_:QuestsMessageParser = (param1 as QuestsMessageEvent).getParser();
            Logger.log(((("Got Quests: " + _loc2_.quests) + ", ") + _loc2_.openWindow));
            this.var_4407.questController.onQuests(_loc2_.quests, _loc2_.openWindow);
        }

        private function onQuest(param1:IMessageEvent):void
        {
            var _loc2_:QuestMessageParser = (param1 as QuestMessageEvent).getParser();
            Logger.log(("Got Quest: " + _loc2_.quest));
            this.var_4407.questController.onQuest(_loc2_.quest);
        }

        public function dispose():void
        {
            if (this.var_4441)
            {
                this.var_4441.dispose();
                this.var_4441 = null;
            };
            this.var_1023 = true;
        }

        private function onRoomEnter(param1:IMessageEvent):void
        {
            this.var_4407.questController.onRoomEnter();
            this.var_4407.currentlyInRoom = true;
        }

        private function onRoomExit(param1:IMessageEvent):void
        {
            this.var_4407.questController.onRoomExit();
            this.var_4407.achievementController.onRoomExit();
            this.var_4407.currentlyInRoom = false;
        }

        private function onAchievements(param1:IMessageEvent):void
        {
            var _loc2_:AchievementsEvent = (param1 as AchievementsEvent);
            var _loc3_:AchievementsMessageParser = (_loc2_.getParser() as AchievementsMessageParser);
            this.var_4407.achievementController.onAchievements(_loc3_.achievements, _loc3_.defaultCategory);
        }

        private function onAchievement(param1:IMessageEvent):void
        {
            var _loc2_:AchievementEvent = (param1 as AchievementEvent);
            var _loc3_:AchievementMessageParser = (_loc2_.getParser() as AchievementMessageParser);
            this.var_4407.achievementController.onAchievement(_loc3_.achievement);
        }

        private function onAchievementsScore(param1:IMessageEvent):void
        {
            var _loc2_:AchievementsScoreEvent = (param1 as AchievementsScoreEvent);
            var _loc3_:AchievementsScoreMessageParser = (_loc2_.getParser() as AchievementsScoreMessageParser);
            this.var_4407.localization.registerParameter("achievements.categories.score", "score", _loc3_.score.toString());
        }

        private function onLevelUp(param1:IMessageEvent):void
        {
            var _loc2_:HabboAchievementNotificationMessageEvent = (param1 as HabboAchievementNotificationMessageEvent);
            var _loc3_:HabboAchievementNotificationMessageParser = _loc2_.getParser();
            var _loc4_:String = this.var_4407.localization.getBadgeBaseName(_loc3_.data.badgeCode);
            this.var_4407.send(new EventLogMessageComposer("Achievements", _loc4_, "Leveled", "", _loc3_.data.level));
            this.var_4407.achievementController.levelUpDialog.onLevelUp(_loc3_.data);
        }

        private function onAchievementShareId(param1:IMessageEvent):void
        {
            var _loc2_:HabboAchievementShareIdMessageEvent = (param1 as HabboAchievementShareIdMessageEvent);
            this.var_4407.achievementController.levelUpDialog.requestFacebookPostDialog(_loc2_.badgeID, _loc2_.shareID);
        }


    }
}