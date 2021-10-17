package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class ObjectMessageData 
    {

        private var _id:int = 0;
        private var _x:Number = 0;
        private var var_2960:Number = 0;
        private var var_2961:Number = 0;
        private var var_3536:int = 0;
        private var var_3540:int = 0;
        private var var_3541:int = 0;
        private var _type:int = 0;
        private var var_3537:String = "";
        private var var_3434:int = -1;
        private var _state:int = 0;
        private var _data:String = "";
        private var var_3433:int = 0;
        private var var_3539:Boolean;
        private var var_3542:String = null;
        private var var_3538:Boolean = false;

        public function ObjectMessageData(param1:int)
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

        public function get type():int
        {
            return (this._type);
        }

        public function set type(param1:int):void
        {
            if (!this.var_3538)
            {
                this._type = param1;
            };
        }

        public function get state():int
        {
            return (this._state);
        }

        public function set state(param1:int):void
        {
            if (!this.var_3538)
            {
                this._state = param1;
            };
        }

        public function get data():String
        {
            return (this._data);
        }

        public function set data(param1:String):void
        {
            if (!this.var_3538)
            {
                this._data = param1;
            };
        }

        public function get staticClass():String
        {
            return (this.var_3542);
        }

        public function set staticClass(param1:String):void
        {
            if (!this.var_3538)
            {
                this.var_3542 = param1;
            };
        }

        public function get extra():int
        {
            return (this.var_3434);
        }

        public function set extra(param1:int):void
        {
            if (!this.var_3538)
            {
                this.var_3434 = param1;
            };
        }

        public function get expiryTime():int
        {
            return (this.var_3433);
        }

        public function set expiryTime(param1:int):void
        {
            if (!this.var_3538)
            {
                this.var_3433 = param1;
            };
        }

        public function get knownAsUsable():Boolean
        {
            return (this.var_3539);
        }

        public function set knownAsUsable(param1:Boolean):void
        {
            this.var_3539 = param1;
        }


    }
}