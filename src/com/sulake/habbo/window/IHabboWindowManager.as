package com.sulake.habbo.window
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.window.ICoreWindowManager;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.window.utils.IAlertDialogWithLink;
    import com.sulake.habbo.window.utils.IConfirmDialog;
    import com.sulake.core.window.IWindowContextStateListener;

    public interface IHabboWindowManager extends IUnknown, ICoreWindowManager 
    {

        function createWindow(param1:String, param2:String="", param3:uint=0, param4:uint=0, param5:uint=0, param6:Rectangle=null, param7:Function=null, param8:uint=0, param9:uint=1):IWindow;
        function removeWindow(param1:String, param2:uint=1):void;
        function getWindowByName(param1:String, param2:uint=1):IWindow;
        function getActiveWindow(param1:uint=1):IWindow;
        function getWindowContext(param1:uint):IWindowContext;
        function alert(param1:String, param2:String, param3:uint, param4:Function):IAlertDialog;
        function alertWithLink(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:Function):IAlertDialogWithLink;
        function confirm(param1:String, param2:String, param3:uint, param4:Function):IConfirmDialog;
        function registerLocalizationParameter(param1:String, param2:String, param3:String, param4:String="%"):void;
        function addMouseEventTracker(param1:IWindowContextStateListener):void;
        function removeMouseEventTracker(param1:IWindowContextStateListener):void;

    }
}