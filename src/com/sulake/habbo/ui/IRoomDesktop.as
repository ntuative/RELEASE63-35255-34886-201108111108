package com.sulake.habbo.ui
{
    import flash.events.IEventDispatcher;
    import flash.events.Event;

    public interface IRoomDesktop 
    {

        function get events():IEventDispatcher;
        function processEvent(param1:Event):void;

    }
}