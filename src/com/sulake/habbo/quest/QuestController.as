package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;

    public class QuestController implements IDisposable, IUpdateReceiver 
    {

        private var var_4407:HabboQuestEngine;
        private var var_4458:QuestsList;
        private var var_4459:QuestDetails;
        private var _questCompleted:QuestCompleted;
        private var var_4460:QuestTracker;
        private var var_4461:NextQuestTimer;

        public function QuestController(param1:HabboQuestEngine)
        {
            this.var_4407 = param1;
            this.var_4460 = new QuestTracker(this.var_4407);
            this.var_4458 = new QuestsList(this.var_4407);
            this.var_4459 = new QuestDetails(this.var_4407);
            this._questCompleted = new QuestCompleted(this.var_4407);
            this.var_4461 = new NextQuestTimer(this.var_4407);
        }

        public function onToolbarClick():void
        {
            this.var_4458.onToolbarClick();
        }

        public function onQuests(param1:Array, param2:Boolean):void
        {
            this.var_4458.onQuests(param1, param2);
        }

        public function onQuest(param1:QuestMessageData):void
        {
            this.var_4460.onQuest(param1);
            this.var_4459.onQuest(param1);
            this._questCompleted.onQuest(param1);
            this.var_4461.onQuest(param1);
        }

        public function onQuestCompleted(param1:QuestMessageData):void
        {
            this.var_4460.onQuestCompleted(param1);
            this.var_4459.onQuestCompleted(param1);
            this._questCompleted.onQuestCompleted(param1);
        }

        public function onQuestCancelled():void
        {
            this.var_4460.onQuestCancelled();
            this.var_4459.onQuestCancelled();
            this._questCompleted.onQuestCancelled();
            this.var_4461.onQuestCancelled();
        }

        public function onRoomEnter():void
        {
            this.var_4460.onRoomEnter();
        }

        public function onRoomExit():void
        {
            this.var_4458.onRoomExit();
            this.var_4460.onRoomExit();
            this.var_4459.onRoomExit();
            this.var_4461.onRoomExit();
        }

        public function update(param1:uint):void
        {
            this._questCompleted.update(param1);
            this.var_4460.update(param1);
            this.var_4461.update(param1);
            this.var_4458.update(param1);
            this.var_4459.update(param1);
        }

        public function dispose():void
        {
            this.var_4407 = null;
            if (this.var_4458)
            {
                this.var_4458.dispose();
                this.var_4458 = null;
            };
            if (this.var_4460)
            {
                this.var_4460.dispose();
                this.var_4460 = null;
            };
            if (this.var_4459)
            {
                this.var_4459.dispose();
                this.var_4459 = null;
            };
            if (this._questCompleted)
            {
                this._questCompleted.dispose();
                this._questCompleted = null;
            };
            if (this.var_4461)
            {
                this.var_4461.dispose();
                this.var_4461 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this.var_4407 == null);
        }

        public function get questsList():QuestsList
        {
            return (this.var_4458);
        }

        public function get questDetails():QuestDetails
        {
            return (this.var_4459);
        }

        public function get questTracker():QuestTracker
        {
            return (this.var_4460);
        }


    }
}