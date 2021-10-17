package com.sulake.habbo.window.utils
{
    public interface ICaption 
    {

        function get text():String;
        function set text(param1:String):void;
        function get toolTip():String;
        function set toolTip(param1:String):void;
        function get visible():Boolean;
        function set visible(param1:Boolean):void;

    }
}