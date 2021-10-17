package com.sulake.core.window.events
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.runtime.events.EventListenerStruct;

    public class WindowEventDispatcher implements IDisposable 
    {

        private static const EVENT_RESULT_TRUE:uint = 0;
        private static const EVENT_RESULT_FALSE:uint = 1;
        private static const EVENT_RESULT_ERROR:uint = 2;

        protected var _disposed:Boolean = false;
        private var _eventListenerTable:Dictionary = new Dictionary();
        private var _result:uint;
        private var _error:Error;

        public function WindowEventDispatcher(param1:IWindow)
        {
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get error():Error
        {
            return (this._error);
        }

        public function addEventListener(param1:String, param2:Function, param3:int=0):void
        {
            var _loc6_:EventListenerStruct;
            var _loc4_:Array = this._eventListenerTable[param1];
            var _loc5_:EventListenerStruct = new EventListenerStruct(param2, false, param3);
            if (!_loc4_)
            {
                _loc4_ = [_loc5_];
                this._eventListenerTable[param1] = _loc4_;
            }
            else
            {
                for each (_loc6_ in _loc4_)
                {
                    if (_loc6_.callback == param2)
                    {
                        return;
                    };
                    if (param3 > _loc6_.priority)
                    {
                        _loc4_.splice(_loc4_.indexOf(_loc6_), 0, _loc5_);
                        return;
                    };
                };
                _loc4_.push(_loc5_);
            };
        }

        public function removeEventListener(param1:String, param2:Function):void
        {
            var _loc3_:Array;
            var _loc4_:uint;
            var _loc5_:EventListenerStruct;
            if (!this._disposed)
            {
                _loc3_ = this._eventListenerTable[param1];
                if (_loc3_)
                {
                    _loc4_ = 0;
                    for each (_loc5_ in _loc3_)
                    {
                        if (_loc5_.callback == param2)
                        {
                            _loc3_.splice(_loc4_, 1);
                            _loc5_.callback = null;
                            if (_loc3_.length == 0)
                            {
                                delete this._eventListenerTable[param1];
                            };
                            return;
                        };
                        _loc4_++;
                    };
                };
            };
        }

        public function dispatchEvent(param1:WindowEvent):Boolean
        {
            var _loc2_:Array;
            var _loc3_:Array;
            var _loc4_:Function;
            var _loc5_:EventListenerStruct;
            if (!this._disposed)
            {
                this._result = EVENT_RESULT_TRUE;
                _loc2_ = this._eventListenerTable[param1.type];
                if (_loc2_)
                {
                    _loc3_ = [];
                    for each (_loc5_ in _loc2_)
                    {
                        _loc3_.push(_loc5_.callback);
                    };
                    while (_loc3_.length > 0)
                    {
                        _loc4_ = _loc3_.shift();
                        (_loc4_(param1));
                    };
                };
                this._result = ((param1.isDefaultPrevented()) ? EVENT_RESULT_FALSE : EVENT_RESULT_TRUE);
                return (this._result == EVENT_RESULT_TRUE);
            };
            return (false);
        }

        public function hasEventListener(param1:String):Boolean
        {
            return ((this._disposed) ? false : (!(this._eventListenerTable[param1] == null)));
        }

        public function dispose():void
        {
            var _loc1_:Object;
            var _loc2_:Array;
            var _loc3_:EventListenerStruct;
            if (!this._disposed)
            {
                for (_loc1_ in this._eventListenerTable)
                {
                    _loc2_ = (this._eventListenerTable[_loc1_] as Array);
                    for each (_loc3_ in _loc2_)
                    {
                        _loc3_.callback = null;
                    };
                    delete this._eventListenerTable[_loc1_];
                };
                this._eventListenerTable = null;
                this._disposed = true;
            };
        }


    }
}