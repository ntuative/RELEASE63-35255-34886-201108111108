package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.Map;

    public interface IWindowParser extends IDisposable 
    {

        function parseAndConstruct(param1:XML, param2:IWindow, param3:Map):IWindow;
        function windowToXMLString(param1:IWindow):String;

    }
}