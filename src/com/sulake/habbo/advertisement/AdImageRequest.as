package com.sulake.habbo.advertisement
{
    public class AdImageRequest 
    {

        private var _roomId:int;
        private var _roomCategory:int;
        private var var_1678:int;
        private var var_2823:int;
        private var var_2825:String;
        private var var_2824:String;

        public function AdImageRequest(param1:int, param2:int, param3:String=null, param4:String=null, param5:int=-1, param6:int=-1)
        {
            this._roomId = param1;
            this._roomCategory = param2;
            this.var_1678 = param5;
            this.var_2823 = param6;
            this.var_2825 = param3;
            this.var_2824 = param4;
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get objectId():int
        {
            return (this.var_1678);
        }

        public function get objectCategory():int
        {
            return (this.var_2823);
        }

        public function get imageURL():String
        {
            return (this.var_2825);
        }

        public function get clickURL():String
        {
            return (this.var_2824);
        }


    }
}