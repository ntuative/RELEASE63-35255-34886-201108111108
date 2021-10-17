package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    public class ItemDataStructure 
    {

        private var var_3435:int;
        private var var_3428:String;
        private var var_3436:int;
        private var var_3437:int;
        private var _category:int;
        private var var_3129:String;
        private var var_3434:int;
        private var var_3438:int;
        private var var_3439:int;
        private var var_3440:int;
        private var var_3441:int;
        private var var_3442:Boolean;
        private var var_3443:int;

        public function ItemDataStructure(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:int, param8:int, param9:int, param10:int, param11:int, param12:Boolean)
        {
            this.var_3435 = param1;
            this.var_3428 = param2;
            this.var_3436 = param3;
            this.var_3437 = param4;
            this._category = param5;
            this.var_3129 = param6;
            this.var_3434 = param7;
            this.var_3438 = param8;
            this.var_3439 = param9;
            this.var_3440 = param10;
            this.var_3441 = param11;
            this.var_3442 = param12;
        }

        public function get itemID():int
        {
            return (this.var_3435);
        }

        public function get itemType():String
        {
            return (this.var_3428);
        }

        public function get roomItemID():int
        {
            return (this.var_3436);
        }

        public function get itemTypeID():int
        {
            return (this.var_3437);
        }

        public function get category():int
        {
            return (this._category);
        }

        public function get stuffData():String
        {
            return (this.var_3129);
        }

        public function get extra():int
        {
            return (this.var_3434);
        }

        public function get timeToExpiration():int
        {
            return (this.var_3438);
        }

        public function get creationDay():int
        {
            return (this.var_3439);
        }

        public function get creationMonth():int
        {
            return (this.var_3440);
        }

        public function get creationYear():int
        {
            return (this.var_3441);
        }

        public function get groupable():Boolean
        {
            return (this.var_3442);
        }

        public function get songID():int
        {
            return (this.var_3434);
        }


    }
}