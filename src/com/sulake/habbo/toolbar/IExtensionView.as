package com.sulake.habbo.toolbar
{
    import com.sulake.core.window.IWindow;

    public interface IExtensionView 
    {

        function get screenHeight():uint;
        function attachExtension(param1:String, param2:IWindow, param3:int=-1):void;
        function detachExtension(param1:String):void;

    }
}