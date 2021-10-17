package com.sulake.habbo.roomevents
{
    import com.sulake.core.runtime.IUnknown;

    public interface IHabboUserDefinedRoomEvents extends IUnknown 
    {

        function stuffSelected(param1:int, param2:String):void;

    }
}