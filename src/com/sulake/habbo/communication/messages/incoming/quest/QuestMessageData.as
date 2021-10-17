package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestMessageData 
    {

        private var var_3519:String;
        private var var_3520:int;
        private var var_3521:int;
        private var var_3297:int;
        private var _id:int;
        private var var_3522:Boolean;
        private var _type:String;
        private var var_3523:String;
        private var var_3524:int;
        private var var_3525:String;
        private var var_3526:int;
        private var var_3527:int;
        private var var_3528:int;
        private var var_3529:Date = new Date();

        public function QuestMessageData(param1:IMessageDataWrapper)
        {
            this.var_3519 = param1.readString();
            this.var_3520 = param1.readInteger();
            this.var_3521 = param1.readInteger();
            this.var_3297 = param1.readInteger();
            this._id = param1.readInteger();
            this.var_3522 = param1.readBoolean();
            this._type = param1.readString();
            this.var_3523 = param1.readString();
            this.var_3524 = param1.readInteger();
            this.var_3525 = param1.readString();
            this.var_3526 = param1.readInteger();
            this.var_3527 = param1.readInteger();
            this.var_3528 = param1.readInteger();
        }

        public function get campaignCode():String
        {
            return (this.var_3519);
        }

        public function get localizationCode():String
        {
            return (this.var_3525);
        }

        public function get completedQuestsInCampaign():int
        {
            return (this.var_3520);
        }

        public function get questCountInCampaign():int
        {
            return (this.var_3521);
        }

        public function get activityPointType():int
        {
            return (this.var_3297);
        }

        public function get accepted():Boolean
        {
            return (this.var_3522);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get imageVersion():String
        {
            return (this.var_3523);
        }

        public function get rewardCurrencyAmount():int
        {
            return (this.var_3524);
        }

        public function get completedSteps():int
        {
            return (this.var_3526);
        }

        public function get totalSteps():int
        {
            return (this.var_3527);
        }

        public function get waitPeriodSeconds():int
        {
            if (this.var_3528 < 1)
            {
                return (0);
            };
            var _loc1_:Date = new Date();
            var _loc2_:int = (_loc1_.getTime() - this.var_3529.getTime());
            return (int(Math.max(0, (this.var_3528 - Math.floor((_loc2_ / 1000))))));
        }

        public function getCampaignLocalizationKey():String
        {
            return ("quests." + this.var_3519);
        }

        public function getQuestLocalizationKey():String
        {
            return ((this.getCampaignLocalizationKey() + ".") + this.var_3525);
        }

        public function get completedCampaign():Boolean
        {
            return (this._id < 1);
        }

        public function set id(param1:int):void
        {
            this._id = param1;
        }

        public function set accepted(param1:Boolean):void
        {
            this.var_3522 = param1;
        }

        public function get lastQuestInCampaign():Boolean
        {
            return (this.var_3520 >= this.var_3521);
        }

        public function get receiveTime():Date
        {
            return (this.var_3529);
        }

        public function set waitPeriodSeconds(param1:int):void
        {
            this.var_3528 = param1;
        }


    }
}