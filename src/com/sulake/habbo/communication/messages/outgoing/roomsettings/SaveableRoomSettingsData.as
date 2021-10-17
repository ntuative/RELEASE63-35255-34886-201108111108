package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
    public class SaveableRoomSettingsData 
    {

        private var _roomId:int;
        private var _name:String;
        private var var_2867:String;
        private var var_3474:int;
        private var _password:String;
        private var var_2930:int;
        private var var_3561:int;
        private var var_1209:Array;
        private var var_3563:Array;
        private var var_3481:Boolean;
        private var var_3565:Boolean;
        private var var_3566:Boolean;
        private var _hideWalls:Boolean;
        private var var_3567:int;
        private var var_3568:int;


        public function get allowPets():Boolean
        {
            return (this.var_3481);
        }

        public function set allowPets(param1:Boolean):void
        {
            this.var_3481 = param1;
        }

        public function get allowFoodConsume():Boolean
        {
            return (this.var_3565);
        }

        public function set allowFoodConsume(param1:Boolean):void
        {
            this.var_3565 = param1;
        }

        public function get allowWalkThrough():Boolean
        {
            return (this.var_3566);
        }

        public function set allowWalkThrough(param1:Boolean):void
        {
            this.var_3566 = param1;
        }

        public function get hideWalls():Boolean
        {
            return (this._hideWalls);
        }

        public function set hideWalls(param1:Boolean):void
        {
            this._hideWalls = param1;
        }

        public function get wallThickness():int
        {
            return (this.var_3567);
        }

        public function set wallThickness(param1:int):void
        {
            this.var_3567 = param1;
        }

        public function get floorThickness():int
        {
            return (this.var_3568);
        }

        public function set floorThickness(param1:int):void
        {
            this.var_3568 = param1;
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function set roomId(param1:int):void
        {
            this._roomId = param1;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(param1:String):void
        {
            this._name = param1;
        }

        public function get description():String
        {
            return (this.var_2867);
        }

        public function set description(param1:String):void
        {
            this.var_2867 = param1;
        }

        public function get doorMode():int
        {
            return (this.var_3474);
        }

        public function set doorMode(param1:int):void
        {
            this.var_3474 = param1;
        }

        public function get password():String
        {
            return (this._password);
        }

        public function set password(param1:String):void
        {
            this._password = param1;
        }

        public function get categoryId():int
        {
            return (this.var_2930);
        }

        public function set categoryId(param1:int):void
        {
            this.var_2930 = param1;
        }

        public function get maximumVisitors():int
        {
            return (this.var_3561);
        }

        public function set maximumVisitors(param1:int):void
        {
            this.var_3561 = param1;
        }

        public function get tags():Array
        {
            return (this.var_1209);
        }

        public function set tags(param1:Array):void
        {
            this.var_1209 = param1;
        }

        public function get controllers():Array
        {
            return (this.var_3563);
        }

        public function set controllers(param1:Array):void
        {
            this.var_3563 = param1;
        }


    }
}