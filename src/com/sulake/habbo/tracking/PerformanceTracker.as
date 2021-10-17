package com.sulake.habbo.tracking
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.utils.debug.GarbageMonitor;
    import flash.system.Capabilities;
    import flash.external.ExternalInterface;
    import flash.utils.getTimer;
    import flash.system.System;
    import com.sulake.habbo.communication.messages.outgoing.tracking.PerformanceLogMessageComposer;

    public class PerformanceTracker 
    {

        private var _connection:IConnection = null;
        private var _configuration:IHabboConfigurationManager = null;
        private var var_1094:int = 0;
        private var var_5127:Number = 0;
        private var var_5154:Array = [];
        private var var_3624:String = "";
        private var var_3625:String = "";
        private var var_3626:String = "";
        private var var_3627:String = "";
        private var var_3628:Boolean = false;
        private var var_5155:GarbageMonitor = null;
        private var var_3631:int = 0;
        private var var_5156:Boolean;
        private var var_5157:int = 1000;
        private var var_3633:int = 0;
        private var _reportInterval:int = 60;
        private var var_5124:int = 0;
        private var var_5158:int = 10;
        private var var_5159:int = 0;
        private var var_5160:Number = 0.15;
        private var var_5161:Boolean = true;
        private var var_5162:Number = 0;

        public function PerformanceTracker()
        {
            this.var_3625 = Capabilities.version;
            this.var_3626 = Capabilities.os;
            this.var_3628 = Capabilities.isDebugger;
            this.var_3624 = ((ExternalInterface.available) ? ExternalInterface.call("window.navigator.userAgent.toString") : "unknown");
            if (this.var_3624 == null)
            {
                this.var_3624 = "unknown";
            };
            this.var_5155 = new GarbageMonitor();
            this.updateGarbageMonitor();
            this.var_5124 = getTimer();
        }

        public function get flashVersion():String
        {
            return (this.var_3625);
        }

        public function get averageUpdateInterval():int
        {
            return (this.var_5127);
        }

        public function set slowUpdateLimit(param1:int):void
        {
            this.var_5157 = param1;
        }

        public function set reportInterval(param1:int):void
        {
            this._reportInterval = param1;
        }

        public function set reportLimit(param1:int):void
        {
            this.var_5158 = param1;
        }

        public function set connection(param1:IConnection):void
        {
            this._connection = param1;
        }

        public function set configuration(param1:IHabboConfigurationManager):void
        {
            this._configuration = param1;
            this._reportInterval = int(this._configuration.getKey("performancetest.interval", "60"));
            this.var_5157 = int(this._configuration.getKey("performancetest.slowupdatelimit", "1000"));
            this.var_5158 = int(this._configuration.getKey("performancetest.reportlimit", "10"));
            this.var_5160 = Number(this._configuration.getKey("performancetest.distribution.deviancelimit.percent", "10"));
            this.var_5161 = Boolean(int(this._configuration.getKey("performancetest.distribution.enabled", "1")));
            this.var_5156 = Boolean((this._configuration.getKey("monitor.garbage.collection", "0") == "1"));
        }

        public function dispose():void
        {
        }

        private function updateGarbageMonitor():Object
        {
            var _loc2_:Object;
            var _loc1_:Array = this.var_5155.list;
            if (((_loc1_ == null) || (_loc1_.length == 0)))
            {
                _loc2_ = new GarbageTester("tester");
                this.var_5155.insert(_loc2_, "tester");
                return (_loc2_);
            };
            return (null);
        }

        public function update(param1:uint, param2:int):void
        {
            var _loc4_:Object;
            var _loc5_:Number;
            var _loc6_:uint;
            var _loc7_:Boolean;
            var _loc8_:Number;
            if (this.var_5156)
            {
                _loc4_ = this.updateGarbageMonitor();
                if (_loc4_ != null)
                {
                    this.var_3631++;
                    Logger.log("Garbage collection");
                };
            };
            var _loc3_:Boolean;
            if (param1 > this.var_5157)
            {
                this.var_3633++;
                _loc3_ = true;
            }
            else
            {
                this.var_1094++;
                if (this.var_1094 <= 1)
                {
                    this.var_5127 = param1;
                }
                else
                {
                    _loc5_ = Number(this.var_1094);
                    this.var_5127 = (((this.var_5127 * (_loc5_ - 1)) / _loc5_) + (Number(param1) / _loc5_));
                };
            };
            if ((((param2 - this.var_5124) > (this._reportInterval * 1000)) && (this.var_5159 < this.var_5158)))
            {
                _loc6_ = System.totalMemory;
                Logger.log((((("*** Performance tracker: average frame rate " + (1000 / this.var_5127)) + "/s, system memory usage : ") + _loc6_) + " bytes"));
                _loc7_ = true;
                if (((this.var_5161) && (this.var_5159 > 0)))
                {
                    _loc8_ = this.differenceInPercents(this.var_5162, this.var_5127);
                    if (_loc8_ < this.var_5160)
                    {
                        _loc7_ = false;
                    };
                };
                this.var_5124 = param2;
                if (((_loc7_) || (_loc3_)))
                {
                    this.var_5162 = this.var_5127;
                    if (this.sendReport(param2))
                    {
                        this.var_5159++;
                    };
                };
            };
        }

        private function sendReport(param1:int):Boolean
        {
            var _loc2_:PerformanceLogMessageComposer;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int;
            if (this._connection != null)
            {
                _loc2_ = null;
                _loc3_ = int((param1 / 1000));
                _loc4_ = -1;
                _loc5_ = int((System.totalMemory / 0x0400));
                _loc2_ = new PerformanceLogMessageComposer(_loc3_, this.var_3624, this.var_3625, this.var_3626, this.var_3627, this.var_3628, _loc5_, _loc4_, this.var_3631, this.var_5127, this.var_3633);
                this._connection.send(_loc2_);
                this.var_3631 = 0;
                this.var_5127 = 0;
                this.var_1094 = 0;
                this.var_3633 = 0;
                return (true);
            };
            return (false);
        }

        private function differenceInPercents(param1:Number, param2:Number):Number
        {
            if (param1 == param2)
            {
                return (0);
            };
            var _loc3_:Number = param1;
            var _loc4_:Number = param2;
            if (param2 > param1)
            {
                _loc3_ = param2;
                _loc4_ = param1;
            };
            return (100 * (1 - (_loc4_ / _loc3_)));
        }


    }
}