package com.sulake.habbo.window.utils
{
    import com.sulake.core.runtime.IDisposable;

    public interface IAlertDialog extends IDisposable 
    {

        function set title(param1:String):void;
        function get title():String;
        function set summary(param1:String):void;
        function get summary():String;
        function set callback(param1:Function):void;
        function get callback():Function;
        function getButtonCaption(param1:int):ICaption;
        function setButtonCaption(param1:int, param2:ICaption):void;

    }
}