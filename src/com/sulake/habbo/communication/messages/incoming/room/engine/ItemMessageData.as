package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class ItemMessageData 
    {

        private var _id:int = 0;
        private var var_3531:Boolean = false;
        private var var_3532:int = 0;
        private var var_3533:int = 0;
        private var var_3534:int = 0;
        private var var_3535:int = 0;
        private var var_2960:Number = 0;
        private var var_2961:Number = 0;
        private var var_3536:String = "";
        private var _type:int = 0;
        private var var_3537:String = "";
        private var var_3434:int = 0;
        private var _state:int = 0;
        private var _data:String = "";
        private var var_3538:Boolean = false;
        private var var_3539:Boolean;

        public function ItemMessageData(param1:int, param2:int, param3:Boolean)
        {
            this._id = param1;
            this._type = param2;
            this.var_3531 = param3;
        }

        public function setReadOnly():void
        {
            this.var_3538 = true;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get isOldFormat():Boolean
        {
            return (this.var_3531);
        }

        public function get wallX():Number
        {
            return (this.var_3532);
        }

        public function set wallX(param1:Number):void
        {
            if (!this.var_3538)
            {
                this.var_3532 = param1;
            };
        }

        public function get wallY():Number
        {
            return (this.var_3533);
        }

        public function set wallY(param1:Number):void
        {
            if (!this.var_3538)
            {
                this.var_3533 = param1;
            };
        }

        public function get localX():Number
        {
            return (this.var_3534);
        }

        public function set localX(param1:Number):void
        {
            if (!this.var_3538)
            {
                this.var_3534 = param1;
            };
        }

        public function get localY():Number
        {
            return (this.var_3535);
        }

        public function set localY(param1:Number):void
        {
            if (!this.var_3538)
            {
                this.var_3535 = param1;
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

        public function get dir():String
        {
            return (this.var_3536);
        }

        public function set dir(param1:String):void
        {
            if (!this.var_3538)
            {
                this.var_3536 = param1;
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

        public function get knownAsUsable():Boolean
        {
            return (this.var_3539);
        }

        public function set knownAsUsable(param1:Boolean):void
        {
            if (!this.var_3538)
            {
                this.var_3539 = param1;
            };
        }


    }
}