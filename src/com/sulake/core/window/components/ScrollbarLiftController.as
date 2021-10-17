package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;

    public class ScrollbarLiftController extends InteractiveController implements IDragBarWindow 
    {

        protected var _offsetX:Number = 0;
        protected var var_2703:Number = 0;
        protected var _scrollBar:ScrollbarController;

        public function ScrollbarLiftController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            param4 = (param4 | WindowParam.var_711);
            param4 = (param4 | WindowParam.var_137);
            param4 = (param4 | WindowParam.var_692);
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            var _loc12_:IWindow = param7;
            while (_loc12_ != null)
            {
                if ((_loc12_ is IScrollbarWindow))
                {
                    this._scrollBar = ScrollbarController(_loc12_);
                    _loc12_ = null;
                }
                else
                {
                    _loc12_ = _loc12_.parent;
                };
            };
            if (this._scrollBar.horizontal)
            {
                limits.minWidth = width;
            }
            else
            {
                limits.minHeight = height;
            };
        }

        public function get offsetX():Number
        {
            return (this._offsetX);
        }

        public function get offsetY():Number
        {
            return (this.var_2703);
        }

        public function set offsetX(param1:Number):void
        {
        }

        public function set offsetY(param1:Number):void
        {
        }

        override public function update(param1:WindowController, param2:WindowEvent):Boolean
        {
            var _loc3_:WindowEvent;
            if (param2.type == WindowEvent.var_587)
            {
                this._offsetX = ((x != 0) ? (x / Number((_parent.width - width))) : 0);
                this.var_2703 = ((y != 0) ? (y / Number((_parent.height - height))) : 0);
                if (_parent != this._scrollBar)
                {
                    _loc3_ = WindowEvent.allocate(WindowEvent.var_598, this, null);
                    this._scrollBar.update(this, _loc3_);
                    _loc3_.recycle();
                };
            };
            return (super.update(param1, param2));
        }


    }
}