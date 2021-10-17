package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowMessage extends WindowEvent 
    {

        private static const var_1273:String = "WE_MESSAGE";
        private static const POOL:Array = [];

        public var message:String;

        public function WindowMessage()
        {
            _type = var_1273;
        }

        public static function allocate(param1:String, param2:IWindow, param3:IWindow, param4:Boolean=false):WindowEvent
        {
            var _loc5_:WindowMessage = ((POOL.length > 0) ? POOL.pop() : new (WindowMessage)());
            _loc5_.message = param1;
            _loc5_._window = param2;
            _loc5_.var_2721 = param3;
            _loc5_.set = param4;
            _loc5_.var_2091 = false;
            _loc5_.var_2720 = POOL;
            return (_loc5_);
        }


        override public function clone():WindowEvent
        {
            return (allocate(this.message, window, related, cancelable));
        }

        override public function toString():String
        {
            return (((((((("WindowLinkEvent { type: " + _type) + " message: ") + this.message) + " cancelable: ") + set) + " window: ") + _window) + " }");
        }


    }
}