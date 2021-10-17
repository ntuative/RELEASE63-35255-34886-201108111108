package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowEvent 
    {

        public static const var_561:String = "WE_DESTROY";
        public static const var_562:String = "WE_DESTROYED";
        public static const var_563:String = "WE_OPEN";
        public static const var_564:String = "WE_OPENED";
        public static const var_565:String = "WE_CLOSE";
        public static const var_566:String = "WE_CLOSED";
        public static const var_567:String = "WE_FOCUS";
        public static const var_568:String = "WE_FOCUSED";
        public static const var_569:String = "WE_UNFOCUS";
        public static const var_570:String = "WE_UNFOCUSED";
        public static const var_571:String = "WE_ACTIVATE";
        public static const var_572:String = "WE_ACTIVATED";
        public static const var_573:String = "WE_DEACTIVATE";
        public static const var_574:String = "WE_DEACTIVATED";
        public static const var_575:String = "WE_SELECT";
        public static const var_576:String = "WE_SELECTED";
        public static const var_577:String = "WE_UNSELECT";
        public static const var_578:String = "WE_UNSELECTED";
        public static const var_579:String = "WE_LOCK";
        public static const var_580:String = "WE_LOCKED";
        public static const var_581:String = "WE_UNLOCK";
        public static const var_582:String = "WE_UNLOCKED";
        public static const var_583:String = "WE_ENABLE";
        public static const var_584:String = "WE_ENABLED";
        public static const var_585:String = "WE_DISABLE";
        public static const var_586:String = "WE_DISABLED";
        public static const WINDOW_EVENT_RELOCATE:String = "WE_RELOCATE";
        public static const var_587:String = "WE_RELOCATED";
        public static const var_588:String = "WE_RESIZE";
        public static const var_589:String = "WE_RESIZED";
        public static const var_590:String = "WE_MINIMIZE";
        public static const var_591:String = "WE_MINIMIZED";
        public static const var_592:String = "WE_MAXIMIZE";
        public static const var_593:String = "WE_MAXIMIZED";
        public static const var_594:String = "WE_RESTORE";
        public static const var_595:String = "WE_RESTORED";
        public static const var_596:String = "WE_CHILD_ADDED";
        public static const var_597:String = "WE_CHILD_REMOVED";
        public static const var_598:String = "WE_CHILD_RELOCATED";
        public static const var_599:String = "WE_CHILD_RESIZED";
        public static const var_600:String = "WE_CHILD_ACTIVATED";
        public static const var_601:String = "WE_PARENT_ADDED";
        public static const var_602:String = "WE_PARENT_REMOVED";
        public static const var_603:String = "WE_PARENT_RELOCATED";
        public static const var_604:String = "WE_PARENT_RESIZED";
        public static const var_605:String = "WE_PARENT_ACTIVATED";
        public static const var_131:String = "WE_OK";
        public static const var_132:String = "WE_CANCEL";
        public static const var_606:String = "WE_CHANGE";
        public static const var_607:String = "WE_SCROLL";
        public static const var_608:String = "";
        private static const POOL:Array = [];

        protected var _type:String;
        protected var _window:IWindow;
        protected var var_2721:IWindow;
        protected var var_2722:Boolean;
        protected var set:Boolean;
        protected var var_2091:Boolean;
        protected var var_2720:Array;


        public static function allocate(param1:String, param2:IWindow, param3:IWindow, param4:Boolean=false):WindowEvent
        {
            var _loc5_:WindowEvent = ((POOL.length > 0) ? POOL.pop() : new (WindowEvent)());
            _loc5_._type = param1;
            _loc5_._window = param2;
            _loc5_.var_2721 = param3;
            _loc5_.set = param4;
            _loc5_.var_2091 = false;
            _loc5_.var_2720 = POOL;
            return (_loc5_);
        }


        public function get type():String
        {
            return (this._type);
        }

        public function get target():IWindow
        {
            return (this._window);
        }

        public function get window():IWindow
        {
            return (this._window);
        }

        public function get related():IWindow
        {
            return (this.var_2721);
        }

        public function get cancelable():Boolean
        {
            return (this.set);
        }

        public function recycle():void
        {
            if (this.var_2091)
            {
                throw (new Error("Event already recycled!"));
            };
            this._window = (this.var_2721 = null);
            this.var_2091 = true;
            this.var_2722 = false;
            this.var_2720.push(this);
        }

        public function clone():WindowEvent
        {
            return (allocate(this._type, this.window, this.related, this.cancelable));
        }

        public function preventDefault():void
        {
            this.preventWindowOperation();
        }

        public function isDefaultPrevented():Boolean
        {
            return (this.var_2722);
        }

        public function preventWindowOperation():void
        {
            if (this.cancelable)
            {
                this.var_2722 = true;
            }
            else
            {
                throw (new Error("Attempted to prevent window operation that is not cancelable!"));
            };
        }

        public function isWindowOperationPrevented():Boolean
        {
            return (this.var_2722);
        }

        public function stopPropagation():void
        {
            this.var_2722 = true;
        }

        public function stopImmediatePropagation():void
        {
            this.var_2722 = true;
        }

        public function toString():String
        {
            return (((((("WindowEvent { type: " + this._type) + " cancelable: ") + this.set) + " window: ") + this._window) + " }");
        }


    }
}