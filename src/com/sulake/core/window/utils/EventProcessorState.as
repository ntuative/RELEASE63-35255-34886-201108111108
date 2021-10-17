package com.sulake.core.window.utils
{
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.IWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindowContextStateListener;

    public class EventProcessorState 
    {

        public var renderer:IWindowRenderer;
        public var desktop:IDesktopWindow;
        public var var_1974:IWindow;
        public var var_1975:IWindow;
        public var var_1976:Vector.<IWindowContextStateListener>;

        public function EventProcessorState(param1:IWindowRenderer, param2:IDesktopWindow, param3:IWindow, param4:IWindow, param5:Vector.<IWindowContextStateListener>)
        {
            this.renderer = param1;
            this.desktop = param2;
            this.var_1974 = param3;
            this.var_1975 = param4;
            this.var_1976 = param5;
        }

    }
}