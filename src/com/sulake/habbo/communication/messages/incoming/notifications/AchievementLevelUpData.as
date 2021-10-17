package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementLevelUpData 
    {

        private var _type:int;
        private var var_3416:int;
        private var var_3514:int;
        private var var_3419:int;
        private var var_3420:int;
        private var var_3515:int;
        private var var_3417:int;
        private var var_3516:String = "";
        private var var_3517:String = "";
        private var var_3518:int;
        private var _category:String;

        public function AchievementLevelUpData(param1:IMessageDataWrapper)
        {
            this._type = param1.readInteger();
            this.var_3416 = param1.readInteger();
            this.var_3417 = param1.readInteger();
            this.var_3516 = param1.readString();
            this.var_3514 = param1.readInteger();
            this.var_3419 = param1.readInteger();
            this.var_3420 = param1.readInteger();
            this.var_3515 = param1.readInteger();
            this.var_3518 = param1.readInteger();
            this.var_3517 = param1.readString();
            this._category = param1.readString();
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get level():int
        {
            return (this.var_3416);
        }

        public function get points():int
        {
            return (this.var_3514);
        }

        public function get levelRewardPoints():int
        {
            return (this.var_3419);
        }

        public function get levelRewardPointType():int
        {
            return (this.var_3420);
        }

        public function get bonusPoints():int
        {
            return (this.var_3515);
        }

        public function get badgeId():int
        {
            return (this.var_3417);
        }

        public function get badgeCode():String
        {
            return (this.var_3516);
        }

        public function get removedBadgeCode():String
        {
            return (this.var_3517);
        }

        public function get achievementID():int
        {
            return (this.var_3518);
        }

        public function get category():String
        {
            return (this._category);
        }


    }
}