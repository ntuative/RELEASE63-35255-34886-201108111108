package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.utils.IMargins;

    public interface IBubbleWindow extends IWindowContainer 
    {

        function get direction():String;
        function set direction(param1:String):void;
        function get pointerOffset():int;
        function set pointerOffset(param1:int):void;
        function get margins():IMargins;
        function get content():IWindowContainer;

    }
}