package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class PublicRoomObjectMessageData 
    {

        private var _name:String = "";
        private var _type:String = "";
        private var _x:Number = 0;
        private var var_2960:Number = 0;
        private var var_2961:Number = 0;
        private var var_3536:int = 0;
        private var var_3540:int = 0;
        private var var_3541:int = 0;
        private var var_3538:Boolean = false;


        public function setReadOnly():void
        {
            this.var_3538 = true;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function set type(param1:String):void
        {
            if (!this.var_3538)
            {
                this._type = param1;
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

        public function get sizeX():int
        {
            return (this.var_3540);
        }

        public function set sizeX(param1:int):void
        {
            if (!this.var_3538)
            {
                this.var_3540 = param1;
            };
        }

        public function get sizeY():int
        {
            return (this.var_3541);
        }

        public function set sizeY(param1:int):void
        {
            if (!this.var_3538)
            {
                this.var_3541 = param1;
            };
        }


    }
}