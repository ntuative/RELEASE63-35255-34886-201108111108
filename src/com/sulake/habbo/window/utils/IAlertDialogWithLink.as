package com.sulake.habbo.window.utils
{
    public interface IAlertDialogWithLink extends IAlertDialog 
    {

        function set linkTitle(param1:String):void;
        function get linkTitle():String;
        function set linkUrl(param1:String):void;
        function get linkUrl():String;

    }
}