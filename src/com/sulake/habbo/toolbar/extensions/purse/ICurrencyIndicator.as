package com.sulake.habbo.toolbar.extensions.purse
{
    import com.sulake.core.window.IWindowContainer;
    import flash.events.IEventDispatcher;

    public interface ICurrencyIndicator 
    {

        function dispose():void;
        function get view():IWindowContainer;
        function registerUpdateEvents(param1:IEventDispatcher):void;

    }
}