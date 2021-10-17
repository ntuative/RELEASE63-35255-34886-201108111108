package com.sulake.core.runtime.events
{
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.core.Core;
    import flash.utils.getQualifiedClassName;
    import flash.events.Event;

    public class EventDispatcher implements IEventDispatcher, IDisposable 
    {

        private static const EVENT_RESULT_TRUE:uint = 0;
        private static const EVENT_RESULT_FALSE:uint = 1;
        private static const EVENT_RESULT_ERROR:uint = 2;

        protected var _disposed:Boolean = false;
        private var _eventDispatcher:flash.events.EventDispatcher;
        private var _eventListenerTable:Dictionary = new Dictionary();
        private var _result:uint;
        private var _error:Error;

        public function EventDispatcher(param1:IEventDispatcher=null)
        {
            this._eventDispatcher = new flash.events.EventDispatcher(((param1) ? param1 : this));
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get error():Error
        {
            return (this._error);
        }

        public function addEventListener(param1:String, param2:Function, param3:Boolean=false, param4:int=0, param5:Boolean=false):void
        {
            var _loc8_:EventListenerStruct;
            var _loc6_:Array = this._eventListenerTable[param1];
            var _loc7_:EventListenerStruct = new EventListenerStruct(param2, param3, param4, param5);
            if (!_loc6_)
            {
                _loc6_ = [_loc7_];
                this._eventListenerTable[param1] = _loc6_;
                this._eventDispatcher.addEventListener(param1, this.eventProcessor);
            }
            else
            {
                for each (_loc8_ in _loc6_)
                {
                    if (((_loc8_.callback == param2) && (_loc8_.var_92 == param3)))
                    {
                        return;
                    };
                    if (param4 > _loc8_.priority)
                    {
                        _loc6_.splice(_loc6_.indexOf(_loc8_), 0, _loc7_);
                        return;
                    };
                };
                _loc6_.push(_loc7_);
            };
        }

        public function removeEventListener(param1:String, param2:Function, param3:Boolean=false):void
        {
            var _loc4_:Array;
            var _loc5_:uint;
            var _loc6_:EventListenerStruct;
            if (!this._disposed)
            {
                _loc4_ = this._eventListenerTable[param1];
                if (_loc4_)
                {
                    _loc5_ = 0;
                    for each (_loc6_ in _loc4_)
                    {
                        if (((_loc6_.callback == param2) && (_loc6_.var_92 == param3)))
                        {
                            _loc4_.splice(_loc5_, 1);
                            _loc6_.callback = null;
                            if (_loc4_.length == 0)
                            {
                                delete this._eventListenerTable[param1];
                            };
                            return;
                        };
                        _loc5_++;
                    };
                };
            };
        }

        public function dispatchEvent(param1:Event):Boolean
        {
            if (!this._disposed)
            {
                this._result = EVENT_RESULT_TRUE;
                this._eventDispatcher.dispatchEvent(param1);
                if (this._result == EVENT_RESULT_ERROR)
                {
                    if (this._error != null)
                    {
                        Core.crash(((("Error caught when handling " + getQualifiedClassName(param1)) + ": ") + this._error.message), this._error.errorID, this._error);
                    }
                    else
                    {
                        Core.crash((("Error caught when handling " + getQualifiedClassName(param1)) + ". No error data available!"), 0, this._error);
                    };
                };
                return (this._result == EVENT_RESULT_TRUE);
            };
            return (false);
        }

        public function hasEventListener(param1:String):Boolean
        {
            return ((this._disposed) ? false : (!(this._eventListenerTable[param1] == null)));
        }

        public function callEventListeners(param1:String):void
        {
            var _loc3_:EventListenerStruct;
            var _loc2_:Array = this._eventListenerTable[param1];
            if (_loc2_)
            {
                for each (_loc3_ in _loc2_)
                {
                    _loc3_.callback(null);
                };
            };
        }

        public function willTrigger(param1:String):Boolean
        {
            return ((this._disposed) ? false : (!(this._eventListenerTable[param1] == null)));
        }

        private function eventProcessor(event:Event):void
        {
            var callbacks:Array;
            var callback:Function;
            var struct:EventListenerStruct;
            var array:Array = this._eventListenerTable[event.type];
            if (array)
            {
                callbacks = [];
                for each (struct in array)
                {
                    callbacks.push(struct.callback);
                };
                while (callbacks.length > 0)
                {
                    try
                    {
                        callback = callbacks.shift();
                        (callback(event));
                    }
                    catch(e:Error)
                    {
                        Logger.log(e.getStackTrace());
                        _result = EVENT_RESULT_ERROR;
                        _error = e;
                        return;
                    };
                };
            };
            this._result = ((event.isDefaultPrevented()) ? EVENT_RESULT_FALSE : EVENT_RESULT_TRUE);
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
                this._eventDispatcher = null;
                this._disposed = true;
            };
        }


    }
}