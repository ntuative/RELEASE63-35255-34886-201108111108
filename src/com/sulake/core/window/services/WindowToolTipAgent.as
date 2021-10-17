package com.sulake.core.window.services
{
    import com.sulake.core.window.components.IToolTipWindow;
    import flash.utils.Timer;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import com.sulake.core.window.components.IInteractiveWindow;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowParam;

    public class WindowToolTipAgent extends WindowMouseOperator implements IToolTipAgentService 
    {

        protected var var_2677:String;
        protected var var_2773:IToolTipWindow;
        protected var var_2774:Timer;

        protected var var_2665:Point = new Point();
        protected var var_2775:Point = new Point(20, 20);
        protected var var_2678:uint = 500;

        public function WindowToolTipAgent(param1:DisplayObject)
        {
            super(param1);
        }

        override public function begin(param1:IWindow, param2:uint=0):IWindow
        {
            if (((param1) && (!(param1.disposed))))
            {
                if ((param1 is IInteractiveWindow))
                {
                    this.var_2677 = IInteractiveWindow(param1).toolTipCaption;
                    this.var_2678 = IInteractiveWindow(param1).toolTipDelay;
                }
                else
                {
                    this.var_2677 = param1.caption;
                    this.var_2678 = 500;
                };
                _mouse.x = _root.mouseX;
                _mouse.y = _root.mouseY;
                getMousePositionRelativeTo(param1, _mouse, this.var_2665);
                if (((!(this.var_2677 == null)) && (!(this.var_2677 == ""))))
                {
                    if (this.var_2774 == null)
                    {
                        this.var_2774 = new Timer(this.var_2678, 1);
                        this.var_2774.addEventListener(TimerEvent.TIMER, this.showToolTip);
                    };
                    this.var_2774.reset();
                    this.var_2774.start();
                };
            };
            return (super.begin(param1, param2));
        }

        override public function end(param1:IWindow):IWindow
        {
            if (this.var_2774 != null)
            {
                this.var_2774.stop();
                this.var_2774.removeEventListener(TimerEvent.TIMER, this.showToolTip);
                this.var_2774 = null;
            };
            this.hideToolTip();
            return (super.end(param1));
        }

        override public function operate(param1:int, param2:int):void
        {
            if (((_window) && (!(_window.disposed))))
            {
                _mouse.x = param1;
                _mouse.y = param2;
                getMousePositionRelativeTo(_window, _mouse, this.var_2665);
                if (((!(this.var_2773 == null)) && (!(this.var_2773.disposed))))
                {
                    this.var_2773.x = (param1 + this.var_2775.x);
                    this.var_2773.y = (param2 + this.var_2775.y);
                };
            };
        }

        protected function showToolTip(param1:TimerEvent):void
        {
            var _loc2_:Point;
            if (this.var_2774 != null)
            {
                this.var_2774.reset();
            };
            if (((_window) && (!(_window.disposed))))
            {
                if (((this.var_2773 == null) || (this.var_2773.disposed)))
                {
                    this.var_2773 = (_window.context.create((_window.name + "::ToolTip"), this.var_2677, WindowType.var_241, _window.style, (WindowParam.var_711 | WindowParam.var_714), null, null, null, 0, null, null) as IToolTipWindow);
                };
                _loc2_ = new Point();
                _window.getGlobalPosition(_loc2_);
                this.var_2773.x = ((_loc2_.x + this.var_2665.x) + this.var_2775.x);
                this.var_2773.y = ((_loc2_.y + this.var_2665.y) + this.var_2775.y);
            };
        }

        protected function hideToolTip():void
        {
            if (((!(this.var_2773 == null)) && (!(this.var_2773.disposed))))
            {
                this.var_2773.destroy();
                this.var_2773 = null;
            };
        }


    }
}