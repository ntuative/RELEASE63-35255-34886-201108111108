package com.sulake.habbo.tracking
{
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.incoming.tracking.LatencyPingResponseMessageEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingRequestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingReportMessageComposer;
    import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class LatencyTracker 
    {

        private var _state:Boolean = false;
        private var _configuration:IHabboConfigurationManager;
        private var _communication:IHabboCommunicationManager;
        private var _connection:IConnection;
        private var var_5146:int = 0;
        private var var_5147:int = 0;
        private var var_5148:int = 0;
        private var var_5149:int = 0;
        private var var_5150:int = 0;
        private var var_5151:int = 0;
        private var var_5152:Array;
        private var var_5153:Map;


        public function set configuration(param1:IHabboConfigurationManager):void
        {
            this._configuration = param1;
        }

        public function set communication(param1:IHabboCommunicationManager):void
        {
            this._communication = param1;
        }

        public function set connection(param1:IConnection):void
        {
            this._connection = param1;
        }

        public function dispose():void
        {
            this._state = false;
            this._configuration = null;
            this._communication = null;
            this._connection = null;
            if (this.var_5153 != null)
            {
                this.var_5153.dispose();
                this.var_5153 = null;
            };
            this.var_5152 = null;
        }

        public function init():void
        {
            if ((((this._configuration == null) || (this._communication == null)) || (this._connection == null)))
            {
                return;
            };
            this.var_5147 = int(this._configuration.getKey("latencytest.interval"));
            this.var_5148 = int(this._configuration.getKey("latencytest.report.index"));
            this.var_5149 = int(this._configuration.getKey("latencytest.report.delta"));
            this._communication.addHabboConnectionMessageEvent(new LatencyPingResponseMessageEvent(this.onPingResponse));
            if (this.var_5147 < 1)
            {
                return;
            };
            this.var_5153 = new Map();
            this.var_5152 = new Array();
            this._state = true;
        }

        public function update(param1:uint, param2:int):void
        {
            if (!this._state)
            {
                return;
            };
            if ((param2 - this.var_5150) > this.var_5147)
            {
                this.testLatency();
            };
        }

        private function testLatency():void
        {
            this.var_5150 = getTimer();
            this.var_5153.add(this.var_5146, this.var_5150);
            this._connection.send(new LatencyPingRequestMessageComposer(this.var_5146));
            this.var_5146++;
        }

        private function onPingResponse(param1:IMessageEvent):void
        {
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:LatencyPingReportMessageComposer;
            if (((this.var_5153 == null) || (this.var_5152 == null)))
            {
                return;
            };
            var _loc2_:LatencyPingResponseMessageParser = (param1 as LatencyPingResponseMessageEvent).getParser();
            var _loc3_:int = this.var_5153.getValue(_loc2_.requestId);
            this.var_5153.remove(_loc2_.requestId);
            var _loc4_:int = (getTimer() - _loc3_);
            this.var_5152.push(_loc4_);
            if (((this.var_5152.length == this.var_5148) && (this.var_5148 > 0)))
            {
                _loc5_ = 0;
                _loc6_ = 0;
                _loc7_ = 0;
                _loc8_ = 0;
                while (_loc8_ < this.var_5152.length)
                {
                    _loc5_ = (_loc5_ + this.var_5152[_loc8_]);
                    _loc8_++;
                };
                _loc9_ = int((_loc5_ / this.var_5152.length));
                _loc8_ = 0;
                while (_loc8_ < this.var_5152.length)
                {
                    if (this.var_5152[_loc8_] < (_loc9_ * 2))
                    {
                        _loc6_ = (_loc6_ + this.var_5152[_loc8_]);
                        _loc7_++;
                    };
                    _loc8_++;
                };
                if (_loc7_ == 0)
                {
                    this.var_5152 = [];
                    return;
                };
                _loc10_ = int((_loc6_ / _loc7_));
                if (((Math.abs((_loc9_ - this.var_5151)) > this.var_5149) || (this.var_5151 == 0)))
                {
                    this.var_5151 = _loc9_;
                    _loc11_ = new LatencyPingReportMessageComposer(_loc9_, _loc10_, this.var_5152.length);
                    this._connection.send(_loc11_);
                };
                this.var_5152 = [];
            };
        }


    }
}