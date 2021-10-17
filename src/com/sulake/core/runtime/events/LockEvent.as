package com.sulake.core.runtime.events
{
    import flash.events.Event;
    import com.sulake.core.runtime.IUnknown;

    public class LockEvent extends Event 
    {

        public var unknown:IUnknown;

        public function LockEvent(param1:String, param2:IUnknown)
        {
            this.unknown = param2;
            super(param1);
        }

    }
}