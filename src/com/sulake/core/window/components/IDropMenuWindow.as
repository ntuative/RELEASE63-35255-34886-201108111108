package com.sulake.core.window.components
{
    public interface IDropMenuWindow extends IInteractiveWindow 
    {

        function get selection():int;
        function set selection(param1:int):void;
        function populate(param1:Array):void;
        function enumerateSelection():Array;

    }
}