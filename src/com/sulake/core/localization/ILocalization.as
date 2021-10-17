package com.sulake.core.localization
{
    public interface ILocalization 
    {

        function get isInitialized():Boolean;
        function get key():String;
        function get value():String;
        function get raw():String;

    }
}