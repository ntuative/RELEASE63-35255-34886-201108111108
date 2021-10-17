package com.sulake.core.window
{
    import com.sulake.core.window.services.IInternalWindowServices;
    import com.sulake.core.window.utils.IWindowParser;
    import com.sulake.core.window.components.IDesktopWindow;
    import flash.geom.Rectangle;

    public interface IWindowContext 
    {

        function getWindowServices():IInternalWindowServices;
        function getWindowParser():IWindowParser;
        function getDesktopWindow():IDesktopWindow;
        function registerLocalizationListener(param1:String, param2:IWindow):void;
        function removeLocalizationListener(param1:String, param2:IWindow):void;
        function findWindowByName(param1:String):IWindow;
        function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:Rectangle, param7:Function, param8:IWindow, param9:uint, param10:Array=null, param11:Array=null):IWindow;
        function destroy(param1:IWindow):Boolean;
        function invalidate(param1:IWindow, param2:Rectangle, param3:uint):void;
        function getLastError():Error;
        function getLastErrorCode():int;
        function flushError():void;
        function addMouseEventTracker(param1:IWindowContextStateListener):void;
        function removeMouseEventTracker(param1:IWindowContextStateListener):void;

    }
}