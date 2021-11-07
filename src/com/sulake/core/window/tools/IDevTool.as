﻿package com.sulake.core.window.tools
{
    import com.sulake.core.runtime.IDisposable;

    public interface IDevTool extends IDisposable 
    {

        function get caption():String;
        function set visible(param1:Boolean):void;
        function get visible():Boolean;

    }
}