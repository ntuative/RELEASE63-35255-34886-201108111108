package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.components.IDesktopWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindowContextStateListener;
    import com.sulake.core.window.enum.MouseCursorType;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.events.MouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.components.IInteractiveWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.enum.*;

    public class MouseEventProcessor implements IEventProcessor, IDisposable 
    {

        protected static var var_1978:Array;
        protected static var var_1979:Array;
        protected static var var_1980:Point = new Point();

        protected var var_2790:Point;
        protected var var_1983:WindowController;
        protected var var_1982:WindowController;
        protected var var_1112:IWindowRenderer;
        protected var var_1981:IDesktopWindow;
        protected var var_1984:Vector.<IWindowContextStateListener>;
        private var _disposed:Boolean = false;

        public function MouseEventProcessor()
        {
            this.var_2790 = new Point();
            if (var_1978 == null)
            {
                var_1978 = new Array();
                var_1978[0] = MouseCursorType.var_1172;
                var_1978[1] = MouseCursorType.var_613;
                var_1978[2] = MouseCursorType.var_1172;
                var_1978[3] = MouseCursorType.var_1172;
                var_1978[4] = MouseCursorType.var_1172;
                var_1978[5] = MouseCursorType.var_613;
                var_1978[6] = MouseCursorType.var_1172;
            };
            if (var_1979 == null)
            {
                var_1979 = new Array();
                var_1979[0] = WindowState.var_743;
                var_1979[1] = WindowState.var_1188;
                var_1979[2] = WindowState.var_1187;
                var_1979[3] = WindowState.var_1183;
                var_1979[4] = WindowState.var_1186;
                var_1979[5] = WindowState.var_1185;
                var_1979[6] = WindowState.var_1184;
            };
        }

        public static function setMouseCursorByState(param1:uint, param2:uint):void
        {
            var _loc3_:int = var_1979.indexOf(param1);
            if (_loc3_ > -1)
            {
                var_1978[_loc3_] = param2;
            };
        }

        public static function getMouseCursorByState(param1:uint):uint
        {
            var _loc2_:uint = var_1979.length;
            while (_loc2_-- > 0)
            {
                if ((param1 & var_1979[_loc2_]) > 0)
                {
                    return (var_1978[_loc2_]);
                };
            };
            return (MouseCursorType.var_613);
        }

        protected static function convertMouseEventType(param1:MouseEvent, param2:IWindow, param3:IWindow):WindowMouseEvent
        {
            var _loc4_:String;
            var _loc5_:Point;
            var _loc6_:Boolean;
            _loc5_ = new Point(param1.stageX, param1.stageY);
            param2.convertPointFromGlobalToLocalSpace(_loc5_);
            switch (param1.type)
            {
                case MouseEvent.MOUSE_MOVE:
                    _loc4_ = WindowMouseEvent.var_654;
                    break;
                case MouseEvent.MOUSE_OVER:
                    _loc4_ = WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER;
                    break;
                case MouseEvent.MOUSE_OUT:
                    _loc4_ = WindowMouseEvent.var_624;
                    break;
                case MouseEvent.ROLL_OUT:
                    _loc4_ = WindowMouseEvent.var_661;
                    break;
                case MouseEvent.ROLL_OVER:
                    _loc4_ = WindowMouseEvent.var_662;
                    break;
                case MouseEvent.CLICK:
                    _loc4_ = WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK;
                    break;
                case MouseEvent.DOUBLE_CLICK:
                    _loc4_ = WindowMouseEvent.var_649;
                    break;
                case MouseEvent.MOUSE_DOWN:
                    _loc4_ = WindowMouseEvent.var_650;
                    break;
                case MouseEvent.MOUSE_UP:
                    _loc6_ = ((((_loc5_.x > -1) && (_loc5_.y > -1)) && (_loc5_.x < param2.width)) && (_loc5_.y < param2.height));
                    _loc4_ = ((_loc6_) ? WindowMouseEvent.var_655 : WindowMouseEvent.var_656);
                    break;
                case MouseEvent.MOUSE_WHEEL:
                    _loc4_ = WindowMouseEvent.var_657;
                    break;
                default:
                    _loc4_ = WindowEvent.var_608;
            };
            return (WindowMouseEvent.allocate(_loc4_, param2, param3, _loc5_.x, _loc5_.y, param1.stageX, param1.stageY, param1.altKey, param1.ctrlKey, param1.shiftKey, param1.buttonDown, param1.delta));
        }


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
            };
        }

        public function process(state:EventProcessorState, eventQueue:IEventQueue):void
        {
            var event:MouseEvent;
            var index:int;
            var child:WindowController;
            var array:Array;
            var tempWindowEvent:WindowEvent;
            var window:IWindow;
            var temp:IWindow;
            var tracker:IWindowContextStateListener;
            if (eventQueue.length == 0)
            {
                return;
            };
            this.var_1981 = state.desktop;
            this.var_1982 = (state.var_1974 as WindowController);
            this.var_1983 = (state.var_1975 as WindowController);
            this.var_1112 = state.renderer;
            this.var_1984 = state.var_1976;
            eventQueue.begin();
            this.var_2790.x = -1;
            this.var_2790.y = -1;
            var mouseCursorType:int = MouseCursorType.var_613;
            while (true)
            {
                event = (eventQueue.next() as MouseEvent);
                if (event == null) break;
                if (((!(event.stageX == this.var_2790.x)) || (!(event.stageY == this.var_2790.y))))
                {
                    this.var_2790.x = event.stageX;
                    this.var_2790.y = event.stageY;
                    array = new Array();
                    this.var_1981.groupParameterFilteredChildrenUnderPoint(this.var_2790, array, WindowParam.var_609);
                };
                index = ((array != null) ? array.length : 0);
                if (index == 0)
                {
                    switch (event.type)
                    {
                        case MouseEvent.MOUSE_MOVE:
                            if (((!(this.var_1982 == this.var_1981)) && (!(this.var_1982.disposed))))
                            {
                                this.var_1982.getGlobalPosition(var_1980);
                                tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.var_624, this.var_1982, null, (event.stageX - var_1980.x), (event.stageY - var_1980.y), event.stageX, event.stageY, event.altKey, event.ctrlKey, event.shiftKey, event.buttonDown, event.delta);
                                this.var_1982.update(this.var_1982, tempWindowEvent);
                                this.var_1982 = WindowController(this.var_1981);
                                tempWindowEvent.recycle();
                            };
                            break;
                        case MouseEvent.MOUSE_DOWN:
                            window = this.var_1981.getActiveWindow();
                            if (window)
                            {
                                window.deactivate();
                            };
                            break;
                        case MouseEvent.MOUSE_UP:
                            if (this.var_1983)
                            {
                                array.push(this.var_1983);
                                index = (index + 1);
                            };
                            break;
                    };
                };
                while (--index > -1)
                {
                    child = this.passMouseEvent(WindowController(array[index]), event);
                    if (((!(child == null)) && (child.visible)))
                    {
                        if (event.type == MouseEvent.MOUSE_MOVE)
                        {
                            if (child != this.var_1982)
                            {
                                if (!this.var_1982.disposed)
                                {
                                    this.var_1982.getGlobalPosition(var_1980);
                                    tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.var_624, this.var_1982, child, (event.stageX - var_1980.x), (event.stageY - var_1980.y), event.stageX, event.stageY, event.altKey, event.ctrlKey, event.shiftKey, event.buttonDown, event.delta);
                                    this.var_1982.update(this.var_1982, tempWindowEvent);
                                    tempWindowEvent.recycle();
                                };
                                if (!child.disposed)
                                {
                                    child.getGlobalPosition(var_1980);
                                    tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, child, null, (event.stageX - var_1980.x), (event.stageY - var_1980.y), event.stageX, event.stageY, event.altKey, event.ctrlKey, event.shiftKey, event.buttonDown, event.delta);
                                    child.update(child, tempWindowEvent);
                                    tempWindowEvent.recycle();
                                };
                                if (!child.disposed)
                                {
                                    this.var_1982 = child;
                                };
                            };
                        }
                        else
                        {
                            if ((((event.type == MouseEvent.MOUSE_UP) || (event.type == MouseEvent.CLICK)) || (event.type == MouseEvent.MOUSE_DOWN)))
                            {
                                if (((this.var_1982) && (!(this.var_1982.disposed))))
                                {
                                    if (this.var_1984 != null)
                                    {
                                        for each (tracker in this.var_1984)
                                        {
                                            tracker.mouseEventReceived(event.type, this.var_1982);
                                        };
                                    };
                                };
                            };
                        };
                        temp = child.parent;
                        while (((temp) && (!(temp.disposed))))
                        {
                            if ((temp is IInputProcessorRoot))
                            {
                                tempWindowEvent = convertMouseEventType(event, temp, child);
                                IInputProcessorRoot(temp).process(tempWindowEvent);
                                tempWindowEvent.recycle();
                                break;
                            };
                            temp = temp.parent;
                        };
                        if (event.altKey)
                        {
                            if (this.var_1982)
                            {
                                Logger.log(("HOVER: " + this.var_1982.name));
                            };
                        };
                        if ((this.var_1982 is IInteractiveWindow))
                        {
                            try
                            {
                                mouseCursorType = IInteractiveWindow(this.var_1982).getMouseCursorByState(this.var_1982.state);
                                if (mouseCursorType == MouseCursorType.var_613)
                                {
                                    mouseCursorType = getMouseCursorByState(this.var_1982.state);
                                };
                            }
                            catch(e:Error)
                            {
                                mouseCursorType = MouseCursorType.var_613;
                            };
                        };
                        if (child != this.var_1981)
                        {
                            event.stopPropagation();
                            eventQueue.remove();
                        };
                        break;
                    };
                };
            };
            eventQueue.end();
            MouseCursorControl.type = mouseCursorType;
            state.desktop = this.var_1981;
            state.var_1974 = this.var_1982;
            state.var_1975 = this.var_1983;
            state.renderer = this.var_1112;
            state.var_1976 = this.var_1984;
        }

        private function passMouseEvent(param1:WindowController, param2:MouseEvent, param3:Boolean=false):WindowController
        {
            var _loc9_:BitmapData;
            if (param1.disposed)
            {
                return (null);
            };
            if (param1.testStateFlag(WindowState.var_1184))
            {
                return (null);
            };
            var _loc4_:Boolean;
            var _loc5_:Point = new Point(param2.stageX, param2.stageY);
            param1.convertPointFromGlobalToLocalSpace(_loc5_);
            if (param2.type == MouseEvent.MOUSE_UP)
            {
                if (param1 != this.var_1983)
                {
                    if (((this.var_1983) && (!(this.var_1983.disposed))))
                    {
                        this.var_1983.update(this.var_1983, convertMouseEventType(new MouseEvent(MouseEvent.MOUSE_UP, false, true, param2.localX, param2.localY, null, param2.ctrlKey, param2.altKey, param2.shiftKey, param2.buttonDown, param2.delta), this.var_1983, param1));
                        this.var_1983 = null;
                        if (param1.disposed)
                        {
                            return (null);
                        };
                    };
                }
                else
                {
                    _loc4_ = (!(param1.hitTestLocalPoint(_loc5_)));
                };
            };
            if (!_loc4_)
            {
                _loc9_ = this.var_1112.getDrawBufferForRenderable(param1);
                if (!param1.validateLocalPointIntersection(_loc5_, _loc9_))
                {
                    return (null);
                };
            };
            if (param1.testParamFlag(WindowParam.var_712))
            {
                if (param1.parent != null)
                {
                    return (this.passMouseEvent(WindowController(param1.parent), param2));
                };
            };
            if (!param3)
            {
                switch (param2.type)
                {
                    case MouseEvent.MOUSE_DOWN:
                        this.var_1983 = param1;
                        break;
                    case MouseEvent.CLICK:
                        if (this.var_1983 != param1)
                        {
                            return (null);
                        };
                        this.var_1983 = null;
                        break;
                    case MouseEvent.DOUBLE_CLICK:
                        if (this.var_1983 != param1)
                        {
                            return (null);
                        };
                        this.var_1983 = null;
                        break;
                };
            };
            var _loc6_:IWindow;
            var _loc7_:WindowMouseEvent = convertMouseEventType(param2, param1, _loc6_);
            var _loc8_:Boolean = param1.update(param1, _loc7_);
            _loc7_.recycle();
            if (((!(_loc8_)) && (!(param3))))
            {
                if (param1.parent)
                {
                    return (this.passMouseEvent(WindowController(param1.parent), param2));
                };
            };
            return (param1);
        }


    }
}