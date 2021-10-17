package com.sulake.core.window.services
{
    import com.sulake.core.window.enum.MouseListenerType;
    import flash.display.DisplayObject;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;
    import flash.events.Event;

    public class WindowMouseListener extends WindowMouseOperator implements IMouseListenerService 
    {

        private var var_2771:Array = new Array();
        private var var_2772:uint = MouseListenerType.var_1274;

        public function WindowMouseListener(param1:DisplayObject)
        {
            super(param1);
        }

        public function get eventTypes():Array
        {
            return (this.var_2771);
        }

        public function get areaLimit():uint
        {
            return (this.var_2772);
        }

        public function set areaLimit(param1:uint):void
        {
            this.var_2772 = param1;
        }

        override public function end(param1:IWindow):IWindow
        {
            var _loc2_:int = this.var_2771.length;
            while (_loc2_ > 0)
            {
                this.var_2771.pop();
                _loc2_--;
            };
            return (super.end(param1));
        }

        override protected function handler(param1:Event):void
        {
            var _loc2_:Boolean;
            if (((_working) && (!(_window.disposed))))
            {
                if (this.var_2771.indexOf(param1.type) >= 0)
                {
                    if ((param1 is WindowMouseEvent))
                    {
                        _loc2_ = _window.hitTestGlobalPoint(new Point(WindowMouseEvent(param1).stageX, WindowMouseEvent(param1).stageY));
                        if (((this.var_2772 == MouseListenerType.var_1275) && (!(_loc2_))))
                        {
                            return;
                        };
                        if (((this.var_2772 == MouseListenerType.var_1215) && (_loc2_)))
                        {
                            return;
                        };
                    };
                    _window.update(null, WindowMouseEvent(param1));
                };
            };
        }

        override public function operate(param1:int, param2:int):void
        {
        }


    }
}