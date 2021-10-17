package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowDisposeEvent extends WindowEvent 
    {

        public static const var_1195:String = "WINDOW_DISPOSE_EVENT";
        private static const POOL:Array = [];

        public function WindowDisposeEvent()
        {
            _type = var_1195;
        }

        public static function allocate(param1:IWindow):WindowDisposeEvent
        {
            var _loc2_:WindowDisposeEvent = ((POOL.length > 0) ? POOL.pop() : new (WindowDisposeEvent)());
            _loc2_._window = param1;
            _loc2_.var_2091 = false;
            _loc2_.var_2720 = POOL;
            return (_loc2_);
        }


        override public function clone():WindowEvent
        {
            return (allocate(window));
        }

        override public function toString():String
        {
            return (((("WindowDisposeEvent { type: " + _type) + " window: ") + _window) + " }");
        }


    }
}