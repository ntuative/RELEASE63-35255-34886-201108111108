package com.sulake.habbo.toolbar
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public interface IHabboToolbar extends IUnknown 
    {

        function get events():IEventDispatcher;
        function getIconVerticalLocation(param1:String):int;
        function setUnseenItemCount(param1:String, param2:int):void;
        function setToolbarState(param1:String):void;
        function setIconBitmap(param1:String, param2:BitmapData):void;
        function getRect():Rectangle;
        function get extensionView():IExtensionView;

    }
}