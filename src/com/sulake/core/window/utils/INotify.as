package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;

    public interface INotify extends IDisposable 
    {

        function set title(param1:String):void;
        function get title():String;
        function set summary(param1:String):void;
        function get summary():String;
        function set callback(param1:Function):void;
        function get callback():Function;

    }
}