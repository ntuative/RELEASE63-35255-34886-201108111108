package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class UserUpdateMessageData 
    {

        private var _id:int = 0;
        private var _x:Number = 0;
        private var var_2960:Number = 0;
        private var var_2961:Number = 0;
        private var var_3554:Number = 0;
        private var var_3555:Number = 0;
        private var var_3556:Number = 0;
        private var var_3557:Number = 0;
        private var var_3536:int = 0;
        private var var_3558:int = 0;
        private var var_2856:Array = [];
        private var var_3559:Boolean = false;

        public function UserUpdateMessageData(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:int, param7:int, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Array)
        {
            this._id = param1;
            this._x = param2;
            this.var_2960 = param3;
            this.var_2961 = param4;
            this.var_3554 = param5;
            this.var_3536 = param6;
            this.var_3558 = param7;
            this.var_3555 = param8;
            this.var_3556 = param9;
            this.var_3557 = param10;
            this.var_3559 = param11;
            this.var_2856 = param12;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function get y():Number
        {
            return (this.var_2960);
        }

        public function get z():Number
        {
            return (this.var_2961);
        }

        public function get localZ():Number
        {
            return (this.var_3554);
        }

        public function get targetX():Number
        {
            return (this.var_3555);
        }

        public function get targetY():Number
        {
            return (this.var_3556);
        }

        public function get targetZ():Number
        {
            return (this.var_3557);
        }

        public function get dir():int
        {
            return (this.var_3536);
        }

        public function get dirHead():int
        {
            return (this.var_3558);
        }

        public function get isMoving():Boolean
        {
            return (this.var_3559);
        }

        public function get actions():Array
        {
            return (this.var_2856.slice());
        }


    }
}