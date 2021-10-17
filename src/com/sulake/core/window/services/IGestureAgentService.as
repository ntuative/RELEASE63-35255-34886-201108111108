package com.sulake.core.window.services
{
    import com.sulake.core.window.IWindow;

    public interface IGestureAgentService 
    {

        function dispose():void;
        function begin(param1:IWindow, param2:Function, param3:uint, param4:int, param5:int):IWindow;
        function end(param1:IWindow):IWindow;

    }
}