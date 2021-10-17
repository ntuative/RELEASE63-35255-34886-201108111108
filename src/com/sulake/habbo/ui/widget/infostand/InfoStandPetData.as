package com.sulake.habbo.ui.widget.infostand
{
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;

    public class InfoStandPetData 
    {

        private var var_3416:int;
        private var var_4987:int;
        private var var_3836:int;
        private var var_4988:int;
        private var _energy:int;
        private var var_4989:int;
        private var _nutrition:int;
        private var var_4990:int;
        private var _petRespect:int;
        private var _name:String = "";
        private var var_3606:int = -1;
        private var _type:int;
        private var var_4495:int;
        private var var_1033:BitmapData;
        private var var_5254:Boolean;
        private var var_3468:int;
        private var _ownerName:String;
        private var _canOwnerBeKicked:Boolean;
        private var var_3804:int;
        private var var_3841:int;


        public function get name():String
        {
            return (this._name);
        }

        public function get id():int
        {
            return (this.var_3606);
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get race():int
        {
            return (this.var_4495);
        }

        public function get image():BitmapData
        {
            return (this.var_1033);
        }

        public function get isOwnPet():Boolean
        {
            return (this.var_5254);
        }

        public function get ownerId():int
        {
            return (this.var_3468);
        }

        public function get ownerName():String
        {
            return (this._ownerName);
        }

        public function get canOwnerBeKicked():Boolean
        {
            return (this._canOwnerBeKicked);
        }

        public function get age():int
        {
            return (this.var_3841);
        }

        public function get level():int
        {
            return (this.var_3416);
        }

        public function get levelMax():int
        {
            return (this.var_4987);
        }

        public function get experience():int
        {
            return (this.var_3836);
        }

        public function get experienceMax():int
        {
            return (this.var_4988);
        }

        public function get energy():int
        {
            return (this._energy);
        }

        public function get energyMax():int
        {
            return (this.var_4989);
        }

        public function get nutrition():int
        {
            return (this._nutrition);
        }

        public function get nutritionMax():int
        {
            return (this.var_4990);
        }

        public function get petRespect():int
        {
            return (this._petRespect);
        }

        public function get roomIndex():int
        {
            return (this.var_3804);
        }

        public function setData(param1:RoomWidgetPetInfoUpdateEvent):void
        {
            this._name = param1.name;
            this.var_3606 = param1.id;
            this._type = param1.petType;
            this.var_4495 = param1.petRace;
            this.var_1033 = param1.image;
            this.var_5254 = param1.isOwnPet;
            this.var_3468 = param1.ownerId;
            this._ownerName = param1.ownerName;
            this._canOwnerBeKicked = param1.canOwnerBeKicked;
            this.var_3416 = param1.level;
            this.var_4987 = param1.levelMax;
            this.var_3836 = param1.experience;
            this.var_4988 = param1.experienceMax;
            this._energy = param1.energy;
            this.var_4989 = param1.energyMax;
            this._nutrition = param1.nutrition;
            this.var_4990 = param1.nutritionMax;
            this._petRespect = param1.petRespect;
            this.var_3804 = param1.roomIndex;
            this.var_3841 = param1.age;
        }


    }
}