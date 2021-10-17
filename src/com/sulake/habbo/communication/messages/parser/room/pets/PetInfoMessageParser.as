package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetInfoMessageParser implements IMessageParser 
    {

        private var var_3606:int;
        private var _name:String;
        private var var_3416:int;
        private var var_3835:int;
        private var var_3836:int;
        private var _energy:int;
        private var _nutrition:int;
        private var var_2994:String;
        private var var_3837:int;
        private var var_3838:int;
        private var var_3839:int;
        private var var_3840:int;
        private var var_3468:int;
        private var _ownerName:String;
        private var var_3841:int;


        public function get petId():int
        {
            return (this.var_3606);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get level():int
        {
            return (this.var_3416);
        }

        public function get maxLevel():int
        {
            return (this.var_3835);
        }

        public function get experience():int
        {
            return (this.var_3836);
        }

        public function get energy():int
        {
            return (this._energy);
        }

        public function get nutrition():int
        {
            return (this._nutrition);
        }

        public function get figure():String
        {
            return (this.var_2994);
        }

        public function get experienceRequiredToLevel():int
        {
            return (this.var_3837);
        }

        public function get maxEnergy():int
        {
            return (this.var_3838);
        }

        public function get maxNutrition():int
        {
            return (this.var_3839);
        }

        public function get respect():int
        {
            return (this.var_3840);
        }

        public function get ownerId():int
        {
            return (this.var_3468);
        }

        public function get ownerName():String
        {
            return (this._ownerName);
        }

        public function get age():int
        {
            return (this.var_3841);
        }

        public function flush():Boolean
        {
            this.var_3606 = -1;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_3606 = param1.readInteger();
            this._name = param1.readString();
            this.var_3416 = param1.readInteger();
            this.var_3835 = param1.readInteger();
            this.var_3836 = param1.readInteger();
            this.var_3837 = param1.readInteger();
            this._energy = param1.readInteger();
            this.var_3838 = param1.readInteger();
            this._nutrition = param1.readInteger();
            this.var_3839 = param1.readInteger();
            this.var_2994 = param1.readString();
            this.var_3840 = param1.readInteger();
            this.var_3468 = param1.readInteger();
            this.var_3841 = param1.readInteger();
            this._ownerName = param1.readString();
            return (true);
        }


    }
}