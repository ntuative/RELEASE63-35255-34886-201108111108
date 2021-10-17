package com.sulake.habbo.tracking
{
    import com.sulake.habbo.configuration.IHabboConfigurationManager;

    public class FramerateTracker 
    {

        private var var_5124:int;
        private var var_5125:int;
        private var var_5126:int;
        private var var_5127:Number;
        private var var_5128:Boolean;
        private var var_5129:int;
        private var var_5130:int;


        public function get frameRate():int
        {
            return (Math.round((1000 / this.var_5127)));
        }

        public function configure(param1:IHabboConfigurationManager):void
        {
            this.var_5125 = (int(param1.getKey("tracking.framerate.reportInterval.seconds", "300")) * 1000);
            this.var_5129 = int(param1.getKey("tracking.framerate.maximumEvents", "5"));
            this.var_5128 = true;
        }

        public function trackUpdate(param1:uint, param2:IHabboTracking, param3:int):void
        {
            var _loc4_:Number;
            this.var_5126++;
            if (this.var_5126 == 1)
            {
                this.var_5127 = param1;
                this.var_5124 = param3;
            }
            else
            {
                _loc4_ = Number(this.var_5126);
                this.var_5127 = (((this.var_5127 * (_loc4_ - 1)) / _loc4_) + (Number(param1) / _loc4_));
            };
            if (((this.var_5128) && ((param3 - this.var_5124) >= this.var_5125)))
            {
                this.var_5126 = 0;
                if (this.var_5130 < this.var_5129)
                {
                    param2.trackGoogle("performance", "averageFramerate", this.frameRate);
                    this.var_5130++;
                    this.var_5124 = param3;
                };
            };
        }

        public function dispose():void
        {
        }


    }
}