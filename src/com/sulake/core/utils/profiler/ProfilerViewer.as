package com.sulake.core.utils.profiler
{
    import flash.text.TextField;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IProfiler;
    import flash.text.TextFormat;

    public class ProfilerViewer extends TextField implements IDisposable 
    {

        protected var _disposed:Boolean = false;
        private var var_2624:IProfiler;

        public function ProfilerViewer(param1:IProfiler)
        {
            var _loc2_:TextFormat = new TextFormat("Courier New", 8);
            defaultTextFormat = _loc2_;
            setTextFormat(_loc2_);
            textColor = 0xFFFFFF;
            width = 10;
            height = 10;
            autoSize = "left";
            mouseEnabled = false;
            selectable = false;
            super();
            if (param1)
            {
                this.var_2624 = param1;
                this.var_2624.addStopEventListener(this.refresh);
            };
        }

        private static function padAlign(param1:String, param2:int, param3:String=" ", param4:Boolean=false):String
        {
            var _loc5_:int = (param2 - param1.length);
            if (_loc5_ <= 0)
            {
                return (param1.substring(0, param2));
            };
            var _loc6_:String = "";
            var _loc7_:int;
            while (_loc7_ < _loc5_)
            {
                _loc6_ = (_loc6_ + param3);
                _loc7_++;
            };
            return ((param4) ? (_loc6_ + param1) : (param1 + _loc6_));
        }


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function set profiler(param1:IProfiler):void
        {
            if (((!(this.var_2624)) && (param1)))
            {
                this.var_2624 = param1;
                this.var_2624.addStopEventListener(this.refresh);
            };
        }

        public function get profiler():IProfiler
        {
            return (this.var_2624);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                if (parent != null)
                {
                    parent.removeChild(this);
                };
                if (this.var_2624)
                {
                    this.var_2624.removeStopEventListener(this.refresh);
                    this.var_2624 = null;
                };
                this._disposed = true;
            };
        }

        public function refresh():void
        {
            text = (((((((((((((((((((padAlign("task", 30) + "|") + padAlign("#rounds", 10, " ", true)) + "|") + padAlign("latest ms", 10, " ", true)) + "|") + padAlign("average ms", 10, " ", true)) + "|") + padAlign("total ms", 10, " ", true)) + "|\r") + padAlign("", 30, "-")) + "|") + padAlign("", 10, "-")) + "|") + padAlign("", 10, "-")) + "|") + padAlign("", 10, "-")) + "|") + padAlign("", 10, "-")) + "|\r");
            var _loc1_:Array = this.var_2624.getProfilerAgentsInArray();
            while (_loc1_.length > 0)
            {
                this.recursiveUpdate(_loc1_.pop(), 0);
            };
            if (parent)
            {
                parent.swapChildren(this, parent.getChildAt((parent.numChildren - 1)));
            };
        }

        private function recursiveUpdate(param1:ProfilerAgentTask, param2:uint):void
        {
            text = (text + (((((((((padAlign(String(param1.name), 30) + "|") + padAlign(String(param1.rounds), 10)) + "|") + padAlign(String(param1.latest), 10)) + "|") + padAlign(String(param1.average), 10)) + "|") + padAlign(String(param1.total), 10)) + "|\r"));
            var _loc3_:uint;
            while (_loc3_ < param1.numSubTasks)
            {
                this.recursiveUpdate(param1.getSubTaskAt(_loc3_), (param2 + 1));
                _loc3_++;
            };
        }


    }
}