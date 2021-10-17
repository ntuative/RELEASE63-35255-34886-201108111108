package com.sulake.habbo.communication.messages.parser.moderation
{
    public class IssueMessageData 
    {

        public static const var_1534:int = 1;
        public static const var_1535:int = 2;
        public static const var_1536:int = 3;

        private var var_3735:int;
        private var _state:int;
        private var var_2930:int;
        private var _reportedCategoryId:int;
        private var var_3737:int;
        private var _priority:int;
        private var var_3738:int = 0;
        private var var_3739:int;
        private var var_3740:String;
        private var var_3446:int;
        private var var_3741:String;
        private var var_3742:int;
        private var var_3743:String;
        private var _message:String;
        private var var_3447:int;
        private var var_3463:String;
        private var var_3744:int;
        private var var_3745:String;
        private var var_3465:int;
        private var var_3746:String;
        private var var_3747:String;
        private var var_3497:int;
        private var var_3498:int;

        public function IssueMessageData(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:String, param9:int, param10:String, param11:int, param12:String, param13:String, param14:int, param15:String, param16:int, param17:String, param18:int, param19:String, param20:String, param21:int, param22:int)
        {
            this.var_3735 = param1;
            this._state = param2;
            this.var_2930 = param3;
            this._reportedCategoryId = param4;
            this.var_3737 = param5;
            this._priority = param6;
            this.var_3739 = param7;
            this.var_3740 = param8;
            this.var_3446 = param9;
            this.var_3741 = param10;
            this.var_3742 = param11;
            this.var_3743 = param12;
            this._message = param13;
            this.var_3447 = param14;
            this.var_3463 = param15;
            this.var_3744 = param16;
            this.var_3745 = param17;
            this.var_3465 = param18;
            this.var_3746 = param19;
            this.var_3747 = param20;
            this.var_3497 = param21;
            this.var_3498 = param22;
        }

        public function get issueId():int
        {
            return (this.var_3735);
        }

        public function get state():int
        {
            return (this._state);
        }

        public function get categoryId():int
        {
            return (this.var_2930);
        }

        public function get reportedCategoryId():int
        {
            return (this._reportedCategoryId);
        }

        public function get timeStamp():int
        {
            return (this.var_3737);
        }

        public function get priority():int
        {
            return (this._priority + this.var_3738);
        }

        public function get reporterUserId():int
        {
            return (this.var_3739);
        }

        public function get reporterUserName():String
        {
            return (this.var_3740);
        }

        public function get reportedUserId():int
        {
            return (this.var_3446);
        }

        public function get reportedUserName():String
        {
            return (this.var_3741);
        }

        public function get pickerUserId():int
        {
            return (this.var_3742);
        }

        public function get pickerUserName():String
        {
            return (this.var_3743);
        }

        public function get message():String
        {
            return (this._message);
        }

        public function get chatRecordId():int
        {
            return (this.var_3447);
        }

        public function get roomName():String
        {
            return (this.var_3463);
        }

        public function get roomType():int
        {
            return (this.var_3744);
        }

        public function get flatType():String
        {
            return (this.var_3745);
        }

        public function get flatId():int
        {
            return (this.var_3465);
        }

        public function get flatOwnerName():String
        {
            return (this.var_3746);
        }

        public function get roomResources():String
        {
            return (this.var_3747);
        }

        public function get unitPort():int
        {
            return (this.var_3497);
        }

        public function get worldId():int
        {
            return (this.var_3498);
        }

        public function set temporalPriority(param1:int):void
        {
            this.var_3738 = param1;
        }

        public function getOpenTime(param1:int):String
        {
            var _loc2_:int = int(((param1 - this.var_3737) / 1000));
            var _loc3_:int = (_loc2_ % 60);
            var _loc4_:int = int((_loc2_ / 60));
            var _loc5_:int = (_loc4_ % 60);
            var _loc6_:int = int((_loc4_ / 60));
            var _loc7_:String = ((_loc3_ < 10) ? ("0" + _loc3_) : ("" + _loc3_));
            var _loc8_:String = ((_loc5_ < 10) ? ("0" + _loc5_) : ("" + _loc5_));
            var _loc9_:String = ((_loc6_ < 10) ? ("0" + _loc6_) : ("" + _loc6_));
            return ((((_loc9_ + ":") + _loc8_) + ":") + _loc7_);
        }


    }
}