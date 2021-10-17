package com.sulake.habbo.sound.music
{
    import flash.utils.getTimer;

    public class SongStartRequestData 
    {

        private var var_1932:int;
        private var var_5044:Number;
        private var var_5045:Number;
        private var var_5046:int;
        private var var_5047:Number;
        private var var_5048:Number;

        public function SongStartRequestData(param1:int, param2:Number, param3:Number, param4:Number=2, param5:Number=1)
        {
            this.var_1932 = param1;
            this.var_5044 = param2;
            this.var_5045 = param3;
            this.var_5047 = param4;
            this.var_5048 = param5;
            this.var_5046 = getTimer();
        }

        public function get songId():int
        {
            return (this.var_1932);
        }

        public function get startPos():Number
        {
            if (this.var_5044 < 0)
            {
                return (0);
            };
            return (this.var_5044 + ((getTimer() - this.var_5046) / 1000));
        }

        public function get playLength():Number
        {
            return (this.var_5045);
        }

        public function get fadeInSeconds():Number
        {
            return (this.var_5047);
        }

        public function get fadeOutSeconds():Number
        {
            return (this.var_5048);
        }


    }
}