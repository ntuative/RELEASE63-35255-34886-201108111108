package com.sulake.core.utils.profiler
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.utils.getQualifiedClassName;

    public class ProfilerAgent extends ProfilerAgentTask implements IDisposable 
    {

        protected var _receiver:IUpdateReceiver;

        public function ProfilerAgent(param1:IUpdateReceiver)
        {
            this._receiver = param1;
            var _loc2_:String = getQualifiedClassName(this._receiver);
            super(_loc2_.slice((_loc2_.lastIndexOf(":") + 1), _loc2_.length));
        }

        public function get receiver():IUpdateReceiver
        {
            return (this._receiver);
        }

        override public function dispose():void
        {
            this._receiver = null;
            super.dispose();
        }

        public function update(param1:int):void
        {
            super.start();
            this._receiver.update(param1);
            super.stop();
        }


    }
}