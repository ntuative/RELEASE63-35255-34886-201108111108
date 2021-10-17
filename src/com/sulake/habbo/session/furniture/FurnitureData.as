package com.sulake.habbo.session.furniture
{
    public class FurnitureData implements IFurnitureData 
    {

        public static const var_2428:String = "i";
        public static const var_2429:String = "s";
        public static const var_2430:String = "e";

        private var _type:String;
        private var _id:int;
        private var _name:String;
        private var var_4973:int;
        private var _revision:int;
        private var var_4974:int;
        private var var_4975:int;
        private var var_4976:int;
        private var var_3187:Array;
        private var _title:String;
        private var var_2867:String;
        private var var_4977:String;
        private var var_4978:int;
        private var var_3082:int;

        public function FurnitureData(param1:String, param2:int, param3:String, param4:int, param5:int, param6:int, param7:int, param8:int, param9:Array, param10:String, param11:String, param12:String, param13:int, param14:int)
        {
            this._type = param1;
            this._id = param2;
            this._name = param3;
            this.var_4973 = param4;
            this._revision = param5;
            this.var_4974 = param6;
            this.var_4975 = param7;
            this.var_4976 = param8;
            this.var_3187 = param9;
            this._title = param10;
            this.var_2867 = param11;
            this.var_4977 = param12;
            this.var_4978 = param13;
            this.var_3082 = param14;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get colourIndex():int
        {
            return (this.var_4973);
        }

        public function get revision():int
        {
            return (this._revision);
        }

        public function get tileSizeX():int
        {
            return (this.var_4974);
        }

        public function get tileSizeY():int
        {
            return (this.var_4975);
        }

        public function get tileSizeZ():int
        {
            return (this.var_4976);
        }

        public function get colours():Array
        {
            return (this.var_3187);
        }

        public function get title():String
        {
            return (this._title);
        }

        public function get description():String
        {
            return (this.var_2867);
        }

        public function get adUrl():String
        {
            return (this.var_4977);
        }

        public function get catalogPageId():int
        {
            return (this.var_4978);
        }

        public function get offerId():int
        {
            return (this.var_3082);
        }


    }
}