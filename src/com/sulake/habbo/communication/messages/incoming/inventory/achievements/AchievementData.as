package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementData 
    {

        private var _type:int;
        private var var_3416:int;
        private var var_3417:String;
        private var var_3418:int;
        private var var_3419:int;
        private var var_3420:int;
        private var var_3421:int;
        private var var_3422:Boolean;
        private var _category:String;
        private var var_3423:int;

        public function AchievementData(param1:IMessageDataWrapper)
        {
            this._type = param1.readInteger();
            this.var_3416 = param1.readInteger();
            this.var_3417 = param1.readString();
            this.var_3418 = Math.max(1, param1.readInteger());
            this.var_3419 = param1.readInteger();
            this.var_3420 = param1.readInteger();
            this.var_3421 = param1.readInteger();
            this.var_3422 = param1.readBoolean();
            this._category = param1.readString();
            this.var_3423 = param1.readInteger();
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get badgeId():String
        {
            return (this.var_3417);
        }

        public function get level():int
        {
            return (this.var_3416);
        }

        public function get scoreLimit():int
        {
            return (this.var_3418);
        }

        public function get levelRewardPoints():int
        {
            return (this.var_3419);
        }

        public function get levelRewardPointType():int
        {
            return (this.var_3420);
        }

        public function get currentPoints():int
        {
            return (this.var_3421);
        }

        public function get finalLevel():Boolean
        {
            return (this.var_3422);
        }

        public function get category():String
        {
            return (this._category);
        }

        public function get levelCount():int
        {
            return (this.var_3423);
        }

        public function get firstLevelAchieved():Boolean
        {
            return ((this.var_3416 > 1) || (this.var_3422));
        }

        public function setMaxProgress():void
        {
            this.var_3421 = this.var_3418;
        }


    }
}