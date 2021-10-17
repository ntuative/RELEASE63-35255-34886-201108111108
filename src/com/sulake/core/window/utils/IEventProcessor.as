package com.sulake.core.window.utils
{
    public interface IEventProcessor 
    {

        function process(param1:EventProcessorState, param2:IEventQueue):void;

    }
}