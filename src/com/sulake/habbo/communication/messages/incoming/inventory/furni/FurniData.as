package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    public class FurniData 
    {

        private var var_3427:int;
        private var var_3428:String;
        private var _objId:int;
        private var var_3429:int;
        private var _category:int;
        private var var_3129:String;
        private var var_3430:Boolean;
        private var var_3431:Boolean;
        private var var_3432:Boolean;
        private var var_2967:Boolean;
        private var var_3433:int;
        private var var_3434:int;
        private var var_2998:String = "";
        private var var_1932:int = -1;

        public function FurniData(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:int)
        {
            this.var_3427 = param1;
            this.var_3428 = param2;
            this._objId = param3;
            this.var_3429 = param4;
            this._category = param5;
            this.var_3129 = param6;
            this.var_3430 = param7;
            this.var_3431 = param8;
            this.var_3432 = param9;
            this.var_2967 = param10;
            this.var_3433 = param11;
        }

        public function setExtraData(param1:String, param2:int):void
        {
            this.var_2998 = param1;
            this.var_3434 = param2;
        }

        public function get stripId():int
        {
            return (this.var_3427);
        }

        public function get itemType():String
        {
            return (this.var_3428);
        }

        public function get objId():int
        {
            return (this._objId);
        }

        public function get classId():int
        {
            return (this.var_3429);
        }

        public function get category():int
        {
            return (this._category);
        }

        public function get stuffData():String
        {
            return (this.var_3129);
        }

        public function get isGroupable():Boolean
        {
            return (this.var_3430);
        }

        public function get isRecyclable():Boolean
        {
            return (this.var_3431);
        }

        public function get isTradeable():Boolean
        {
            return (this.var_3432);
        }

        public function get isSellable():Boolean
        {
            return (this.var_2967);
        }

        public function get expiryTime():int
        {
            return (this.var_3433);
        }

        public function get slotId():String
        {
            return (this.var_2998);
        }

        public function get songId():int
        {
            return (this.var_1932);
        }

        public function get extra():int
        {
            return (this.var_3434);
        }


    }
}