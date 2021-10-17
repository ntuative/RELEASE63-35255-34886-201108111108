package com.sulake.core.window.services
{
    import com.sulake.core.window.IWindow;

    public interface IMouseScalingService 
    {

        function dispose():void;
        function begin(param1:IWindow, param2:uint=0):IWindow;
        function end(param1:IWindow):IWindow;

    }
}