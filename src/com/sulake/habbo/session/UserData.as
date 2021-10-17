package com.sulake.habbo.session
{
    public class UserData implements IUserData 
    {

        private var _id:int = -1;
        private var _name:String = "";
        private var _type:int = 0;
        private var var_3546:String = "";
        private var var_2994:String = "";
        private var var_3547:String = "";
        private var var_3548:int;
        private var var_3549:int = 0;
        private var var_3550:String = "";
        private var var_3551:int = 0;
        private var var_3552:int = 0;

        public function UserData(param1:int)
        {
            this._id = param1;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get achievementScore():int
        {
            return (this.var_3548);
        }

        public function set achievementScore(param1:int):void
        {
            this.var_3548 = param1;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(param1:String):void
        {
            this._name = param1;
        }

        public function get type():int
        {
            return (this._type);
        }

        public function set type(param1:int):void
        {
            this._type = param1;
        }

        public function get sex():String
        {
            return (this.var_3546);
        }

        public function set sex(param1:String):void
        {
            this.var_3546 = param1;
        }

        public function get figure():String
        {
            return (this.var_2994);
        }

        public function set figure(param1:String):void
        {
            this.var_2994 = param1;
        }

        public function get custom():String
        {
            return (this.var_3547);
        }

        public function set custom(param1:String):void
        {
            this.var_3547 = param1;
        }

        public function get webID():int
        {
            return (this.var_3549);
        }

        public function set webID(param1:int):void
        {
            this.var_3549 = param1;
        }

        public function get groupID():String
        {
            return (this.var_3550);
        }

        public function set groupID(param1:String):void
        {
            this.var_3550 = param1;
        }

        public function get groupStatus():int
        {
            return (this.var_3551);
        }

        public function set groupStatus(param1:int):void
        {
            this.var_3551 = param1;
        }

        public function get xp():int
        {
            return (this.var_3552);
        }

        public function set xp(param1:int):void
        {
            this.var_3552 = param1;
        }


    }
}