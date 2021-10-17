package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class UserMessageData 
    {

        public static const var_1853:String = "M";
        public static const var_1854:String = "F";

        private var _id:int = 0;
        private var _x:Number = 0;
        private var var_2960:Number = 0;
        private var var_2961:Number = 0;
        private var var_3536:int = 0;
        private var _name:String = "";
        private var var_3545:int = 0;
        private var var_3546:String = "";
        private var var_2994:String = "";
        private var var_3547:String = "";
        private var var_3548:int;
        private var var_3549:int = 0;
        private var var_3550:String = "";
        private var var_3551:int = 0;
        private var var_3552:int = 0;
        private var var_3553:String = "";
        private var var_3538:Boolean = false;

        public function UserMessageData(param1:int)
        {
            this._id = param1;
        }

        public function setReadOnly():void
        {
            this.var_3538 = true;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function set x(param1:Number):void
        {
            if (!this.var_3538)
            {
                this._x = param1;
            };
        }

        public function get y():Number
        {
            return (this.var_2960);
        }

        public function set y(param1:Number):void
        {
            if (!this.var_3538)
            {
                this.var_2960 = param1;
            };
        }

        public function get z():Number
        {
            return (this.var_2961);
        }

        public function set z(param1:Number):void
        {
            if (!this.var_3538)
            {
                this.var_2961 = param1;
            };
        }

        public function get dir():int
        {
            return (this.var_3536);
        }

        public function set dir(param1:int):void
        {
            if (!this.var_3538)
            {
                this.var_3536 = param1;
            };
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(param1:String):void
        {
            if (!this.var_3538)
            {
                this._name = param1;
            };
        }

        public function get userType():int
        {
            return (this.var_3545);
        }

        public function set userType(param1:int):void
        {
            if (!this.var_3538)
            {
                this.var_3545 = param1;
            };
        }

        public function get sex():String
        {
            return (this.var_3546);
        }

        public function set sex(param1:String):void
        {
            if (!this.var_3538)
            {
                this.var_3546 = param1;
            };
        }

        public function get figure():String
        {
            return (this.var_2994);
        }

        public function set figure(param1:String):void
        {
            if (!this.var_3538)
            {
                this.var_2994 = param1;
            };
        }

        public function get custom():String
        {
            return (this.var_3547);
        }

        public function set custom(param1:String):void
        {
            if (!this.var_3538)
            {
                this.var_3547 = param1;
            };
        }

        public function get achievementScore():int
        {
            return (this.var_3548);
        }

        public function set achievementScore(param1:int):void
        {
            if (!this.var_3538)
            {
                this.var_3548 = param1;
            };
        }

        public function get webID():int
        {
            return (this.var_3549);
        }

        public function set webID(param1:int):void
        {
            if (!this.var_3538)
            {
                this.var_3549 = param1;
            };
        }

        public function get groupID():String
        {
            return (this.var_3550);
        }

        public function set groupID(param1:String):void
        {
            if (!this.var_3538)
            {
                this.var_3550 = param1;
            };
        }

        public function get groupStatus():int
        {
            return (this.var_3551);
        }

        public function set groupStatus(param1:int):void
        {
            if (!this.var_3538)
            {
                this.var_3551 = param1;
            };
        }

        public function get xp():int
        {
            return (this.var_3552);
        }

        public function set xp(param1:int):void
        {
            if (!this.var_3538)
            {
                this.var_3552 = param1;
            };
        }

        public function get subType():String
        {
            return (this.var_3553);
        }

        public function set subType(param1:String):void
        {
            if (!this.var_3538)
            {
                this.var_3553 = param1;
            };
        }


    }
}