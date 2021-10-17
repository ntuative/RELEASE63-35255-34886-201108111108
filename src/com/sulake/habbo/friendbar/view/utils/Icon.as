package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.utils.Timer;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import flash.events.TimerEvent;

    public class Icon implements IDisposable 
    {

        protected static const var_3930:int = 0;
        protected static const var_2106:int = 1;
        protected static const var_2109:int = 2;
        protected static const var_2108:int = 3;
        protected static const var_2225:int = 4;
        protected static const var_2107:int = 8;
        protected static const var_2111:int = 18;
        protected static const var_2110:int = 18;

        private var _disposed:Boolean = false;
        private var var_3931:Boolean = false;
        protected var var_1033:BitmapDataAsset;
        protected var var_2895:IBitmapWrapperWindow;
        private var var_3932:uint = (var_2106 | var_2107);
        protected var var_2486:Timer;
        protected var _frame:int = 0;
        private var var_3933:Point = new Point();
        protected var var_2113:Boolean = false;
        protected var _hover:Boolean = false;


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get disabled():Boolean
        {
            return (this.var_3931);
        }

        protected function set image(param1:BitmapDataAsset):void
        {
            this.var_1033 = param1;
            this.redraw();
        }

        protected function get image():BitmapDataAsset
        {
            return (this.var_1033);
        }

        protected function set canvas(param1:IBitmapWrapperWindow):void
        {
            this.var_2895 = param1;
            this.redraw();
        }

        protected function get canvas():IBitmapWrapperWindow
        {
            return (this.var_2895);
        }

        protected function set alignment(param1:uint):void
        {
            this.var_3932 = param1;
            this.redraw();
        }

        protected function get alignment():uint
        {
            return (this.var_3932);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this.toggleTimer(false, 0);
                this.image = null;
                this.canvas = null;
                this._disposed = true;
            };
        }

        public function notify(param1:Boolean):void
        {
            this.var_2113 = param1;
            if (((this.var_2113) && (this.var_3931)))
            {
                this.enable(true);
            };
        }

        public function hover(param1:Boolean):void
        {
            this._hover = param1;
        }

        public function enable(param1:Boolean):void
        {
            this.var_3931 = (!(param1));
        }

        protected function redraw():void
        {
            var _loc1_:BitmapData;
            if (((this.var_2895) && (!(this.var_2895.disposed))))
            {
                if (!this.var_2895.bitmap)
                {
                    this.var_2895.bitmap = new BitmapData(this.var_2895.width, this.var_2895.height, true, 0);
                }
                else
                {
                    this.var_2895.bitmap.fillRect(this.var_2895.bitmap.rect, 0);
                };
                if (((this.var_1033) && (!(this.var_1033.disposed))))
                {
                    this.var_3933.x = (this.var_3933.y = 0);
                    _loc1_ = (this.var_1033.content as BitmapData);
                    switch ((this.var_3932 & var_2108))
                    {
                        case var_2106:
                            this.var_3933.x = ((this.var_2895.bitmap.width / 2) - (_loc1_.width / 2));
                            break;
                        case var_2109:
                            this.var_3933.x = (this.var_2895.bitmap.width - _loc1_.width);
                            break;
                    };
                    switch ((this.var_3932 & var_2110))
                    {
                        case var_2107:
                            this.var_3933.y = ((this.var_2895.bitmap.height / 2) - (_loc1_.height / 2));
                            break;
                        case var_2111:
                            this.var_3933.y = (this.var_2895.bitmap.height - _loc1_.height);
                            break;
                    };
                    this.var_2895.bitmap.copyPixels(_loc1_, _loc1_.rect, this.var_3933);
                    this.var_2895.invalidate();
                };
            };
        }

        protected function toggleTimer(param1:Boolean, param2:int):void
        {
            if (param1)
            {
                if (!this.var_2486)
                {
                    this.var_2486 = new Timer(param2, 0);
                    this.var_2486.addEventListener(TimerEvent.TIMER, this.onTimerEvent);
                    this.var_2486.start();
                    this.onTimerEvent(null);
                };
                this.var_2486.delay = param2;
            }
            else
            {
                this._frame = 0;
                if (this.var_2486)
                {
                    this.var_2486.reset();
                    this.var_2486.removeEventListener(TimerEvent.TIMER, this.onTimerEvent);
                    this.var_2486 = null;
                };
            };
        }

        protected function onTimerEvent(param1:TimerEvent):void
        {
        }


    }
}