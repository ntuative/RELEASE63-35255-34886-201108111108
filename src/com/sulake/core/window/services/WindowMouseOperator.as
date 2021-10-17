package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.DisplayObject;
    import com.sulake.core.window.WindowController;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import com.sulake.core.window.events.WindowEvent;

    public class WindowMouseOperator implements IDisposable 
    {

        protected var _root:DisplayObject;
        protected var _window:WindowController;
        protected var _working:Boolean;
        protected var _offset:Point;
        protected var _mouse:Point;
        protected var var_2494:Point;
        protected var var_2492:uint;
        private var _disposed:Boolean = false;

        public function WindowMouseOperator(param1:DisplayObject)
        {
            this._root = param1;
            this.var_2494 = new Point();
            this._mouse = new Point();
            this._offset = new Point();
            this._working = false;
            this.var_2492 = 0;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            this.end(this._window);
            this._offset = null;
            this._mouse = null;
            this.var_2494 = null;
            this._root = null;
            this._disposed = true;
        }

        public function begin(param1:IWindow, param2:uint=0):IWindow
        {
            this.var_2492 = param2;
            var _loc3_:IWindow = this._window;
            if (this._window != null)
            {
                this.end(this._window);
            };
            if (((param1) && (!(param1.disposed))))
            {
                this._root.addEventListener(MouseEvent.MOUSE_DOWN, this.handler, false);
                this._root.addEventListener(MouseEvent.MOUSE_UP, this.handler, false);
                this._root.addEventListener(Event.ENTER_FRAME, this.handler);
                this._mouse.x = this._root.mouseX;
                this._mouse.y = this._root.mouseY;
                this._window = WindowController(param1);
                this.getMousePositionRelativeTo(param1, this._mouse, this._offset);
                this._window.addEventListener(WindowEvent.var_562, this.clientWindowDestroyed);
                this._working = true;
            };
            return (_loc3_);
        }

        public function end(param1:IWindow):IWindow
        {
            var _loc2_:IWindow = this._window;
            if (this._working)
            {
                if (this._window == param1)
                {
                    this._root.removeEventListener(MouseEvent.MOUSE_DOWN, this.handler, false);
                    this._root.removeEventListener(MouseEvent.MOUSE_UP, this.handler, false);
                    this._root.removeEventListener(Event.ENTER_FRAME, this.handler);
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

        protected function handler(param1:Event):void
        {
            var _loc2_:MouseEvent;
            if (this._working)
            {
                if (param1.type == Event.ENTER_FRAME)
                {
                    if (this._window.disposed)
                    {
                        this.end(this._window);
                    }
                    else
                    {
                        if (((!(this._mouse.x == this._root.mouseX)) || (!(this._mouse.y == this._root.mouseY))))
                        {
                            this.operate(this._root.mouseX, this._root.mouseY);
                            this._mouse.x = this._root.mouseX;
                            this._mouse.y = this._root.mouseY;
                        };
                    };
                    return;
                };
                _loc2_ = (param1 as MouseEvent);
                if (_loc2_ != null)
                {
                    switch (_loc2_.type)
                    {
                        case MouseEvent.MOUSE_UP:
                            this.end(this._window);
                            return;
                    };
                };
            };
        }

        public function operate(param1:int, param2:int):void
        {
            this._mouse.x = param1;
            this._mouse.y = param2;
            this.getMousePositionRelativeTo(this._window, this._mouse, this.var_2494);
            this._window.offset((this.var_2494.x - this._offset.x), (this.var_2494.y - this._offset.y));
        }

        private function clientWindowDestroyed(param1:WindowEvent):void
        {
            this.end(this._window);
        }

        protected function getMousePositionRelativeTo(param1:IWindow, param2:Point, param3:Point):void
        {
            param1.getGlobalPosition(param3);
            param3.x = (param2.x - param3.x);
            param3.y = (param2.y - param3.y);
        }


    }
}