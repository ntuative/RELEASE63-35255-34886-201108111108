package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;
    import flash.events.IEventDispatcher;
    import flash.events.Event;

    public class GenericEventQueue implements IEventQueue, IDisposable 
    {

        protected var _disposed:Boolean = false;
        protected var _eventDispatcher:IEventDispatcher;
        protected var var_1977:Array;
        protected var _index:uint = 0;

        public function GenericEventQueue(param1:IEventDispatcher)
        {
            this.var_1977 = new Array();
            this._eventDispatcher = param1;
        }

        public function get length():uint
        {
            return (this.var_1977.length);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._eventDispatcher = null;
                this.var_1977 = [];
                this._disposed = true;
            };
        }

        public function begin():void
        {
            this._index = 0;
        }

        public function next():Event
        {
            var _loc1_:Event;
            if (this._index < this.var_1977.length)
            {
                _loc1_ = this.var_1977[this._index];
                this._index++;
            };
            return (_loc1_);
        }

        public function remove():void
        {
            this.var_1977.splice((this._index - 1), 1);
            if (this._index > 0)
            {
                this._index--;
            };
        }

        public function end():void
        {
            this._index = 0;
        }

        public function flush():void
        {
            this.var_1977.splice(0, this.var_1977.length);
            this._index = 0;
        }

        protected function eventListener(param1:Event):void
        {
            this.var_1977.push(param1);
        }


    }
}