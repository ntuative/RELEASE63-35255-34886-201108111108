package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindow;
    import flash.utils.Timer;
    import com.sulake.core.window.events.WindowEvent;
    import flash.events.TimerEvent;

    public class GestureAgentService implements IGestureAgentService, IDisposable 
    {

        private var _disposed:Boolean = false;
        protected var _working:Boolean;
        protected var _window:IWindow;
        protected var var_2486:Timer;
        protected var var_2492:uint = 0;
        protected var var_1166:Function;
        protected var var_2761:int;
        protected var var_2762:int;


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            this.end(this._window);
            this._disposed = true;
        }

        public function begin(param1:IWindow, param2:Function, param3:uint, param4:int, param5:int):IWindow
        {
            this.var_2492 = param3;
            var _loc6_:IWindow = this._window;
            if (this._window != null)
            {
                this.end(this._window);
            };
            if (((param1) && (!(param1.disposed))))
            {
                this._window = param1;
                this._window.addEventListener(WindowEvent.var_562, this.clientWindowDestroyed);
                this.var_1166 = param2;
                this._working = true;
                this.var_2761 = param4;
                this.var_2762 = param5;
                this.var_2486 = new Timer(40, 0);
                this.var_2486.addEventListener(TimerEvent.TIMER, this.operate);
                this.var_2486.start();
            };
            return (_loc6_);
        }

        protected function operate(param1:TimerEvent):void
        {
            this.var_2761 = (this.var_2761 * 0.75);
            this.var_2762 = (this.var_2762 * 0.75);
            if (((Math.abs(this.var_2761) <= 1) && (Math.abs(this.var_2762) <= 1)))
            {
                this.end(this._window);
            }
            else
            {
                if (this.var_1166 != null)
                {
                    this.var_1166(this.var_2761, this.var_2762);
                };
            };
        }

        public function end(param1:IWindow):IWindow
        {
            var _loc2_:IWindow = this._window;
            if (this.var_2486)
            {
                this.var_2486.stop();
                this.var_2486.removeEventListener(TimerEvent.TIMER, this.operate);
                this.var_2486 = null;
            };
            if (this._working)
            {
                if (this._window == param1)
                {
                    if (!this._window.disposed)
                    {
                        this._window.removeEventListener(WindowEvent.var_562, this.clientWindowDestroyed);
                    };
                    this._window = null;
                    this._working = false;
                };
            };
            return (_loc2_);
        }

        private function clientWindowDestroyed(param1:WindowEvent):void
        {
            this.end(this._window);
        }


    }
}