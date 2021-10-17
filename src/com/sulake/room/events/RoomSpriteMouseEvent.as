package com.sulake.room.events
{
    public class RoomSpriteMouseEvent 
    {

        private var _type:String = "";
        private var var_5502:String = "";
        private var var_4637:String = "";
        private var var_5507:String = "";
        private var var_5508:Number = 0;
        private var var_5509:Number = 0;
        private var var_3534:Number = 0;
        private var var_3535:Number = 0;
        private var var_5504:Boolean = false;
        private var var_5503:Boolean = false;
        private var var_5505:Boolean = false;
        private var var_5506:Boolean = false;

        public function RoomSpriteMouseEvent(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:Number, param7:Number=0, param8:Number=0, param9:Boolean=false, param10:Boolean=false, param11:Boolean=false, param12:Boolean=false)
        {
            this._type = param1;
            this.var_5502 = param2;
            this.var_4637 = param3;
            this.var_5507 = param4;
            this.var_5508 = param5;
            this.var_5509 = param6;
            this.var_3534 = param7;
            this.var_3535 = param8;
            this.var_5504 = param9;
            this.var_5503 = param10;
            this.var_5505 = param11;
            this.var_5506 = param12;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get eventId():String
        {
            return (this.var_5502);
        }

        public function get canvasId():String
        {
            return (this.var_4637);
        }

        public function get spriteTag():String
        {
            return (this.var_5507);
        }

        public function get screenX():Number
        {
            return (this.var_5508);
        }

        public function get screenY():Number
        {
            return (this.var_5509);
        }

        public function get localX():Number
        {
            return (this.var_3534);
        }

        public function get localY():Number
        {
            return (this.var_3535);
        }

        public function get ctrlKey():Boolean
        {
            return (this.var_5504);
        }

        public function get altKey():Boolean
        {
            return (this.var_5503);
        }

        public function get shiftKey():Boolean
        {
            return (this.var_5505);
        }

        public function get buttonDown():Boolean
        {
            return (this.var_5506);
        }


    }
}