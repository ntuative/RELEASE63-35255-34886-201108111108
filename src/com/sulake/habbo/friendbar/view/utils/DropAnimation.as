package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Timer;
    import com.sulake.core.window.IWindow;
    import flash.utils.getTimer;
    import flash.events.TimerEvent;

    public class DropAnimation implements IDisposable 
    {

        private var var_2486:Timer;
        private var _window:IWindow;
        private var var_3424:int;
        private var _height:int;
        private var _offset:int;
        private var var_3928:int;
        private var var_3929:int;

        public function DropAnimation(param1:IWindow, param2:int, param3:int)
        {
            this._window = param1;
            this.var_3424 = param2;
            this._height = param3;
            this._offset = this._window.y;
            this._window.y = (this._offset - param3);
            this.var_3928 = getTimer();
            this.var_3929 = this.var_3928;
            this.var_2486 = new Timer((1000 / 24), 0);
            this.var_2486.addEventListener(TimerEvent.TIMER, this.onTimerEvent);
            this.var_2486.start();
        }

        public function get disposed():Boolean
        {
            return (this.var_2486 == null);
        }

        public function dispose():void
        {
            if (this.var_2486)
            {
                this.var_2486.stop();
                this.var_2486.removeEventListener(TimerEvent.TIMER, this.onTimerEvent);
                this.var_2486 = null;
            };
            if (((this._window) && (!(this._window.disposed))))
            {
                this._window.y = this._offset;
                this._window = null;
            };
        }

        private function onTimerEvent(param1:TimerEvent):void
        {
            if (((!(this._window)) || (this._window.disposed)))
            {
                this.dispose();
                return;
            };
            this.var_3928 = getTimer();
            var _loc2_:Number = (Number((this.var_3928 - this.var_3929)) / Number(this.var_3424));
            this._window.y = ((this._offset - this._height) + (this.getBounceOffset(_loc2_) * this._height));
            if (_loc2_ >= 1)
            {
                this.dispose();
            };
        }

        protected function getBounceOffset(param1:Number):Number
        {
            if (param1 < (1 / 2.75))
            {
                return ((7.5625 * param1) * param1);
            };
            if (param1 < (2 / 2.75))
            {
                param1 = (param1 - (1.5 / 2.75));
                return (((7.5625 * param1) * param1) + 0.75);
            };
            if (param1 < (2.5 / 2.75))
            {
                param1 = (param1 - (2.25 / 2.75));
                return (((7.5625 * param1) * param1) + 0.9375);
            };
            param1 = (param1 - (2.625 / 2.75));
            return (((7.5625 * param1) * param1) + 0.984375);
        }


    }
}