package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFocusWindow;

    public interface IFocusManagerService extends IDisposable 
    {

        function registerFocusWindow(param1:IFocusWindow):void;
        function removeFocusWindow(param1:IFocusWindow):void;

    }
}