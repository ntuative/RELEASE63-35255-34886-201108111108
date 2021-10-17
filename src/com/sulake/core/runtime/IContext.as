package com.sulake.core.runtime
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObjectContainer;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import com.sulake.core.utils.LibraryLoader;
    import flash.system.ApplicationDomain;

    public interface IContext extends IUnknown 
    {

        function get assets():IAssetLibrary;
        function get events():IEventDispatcher;
        function get root():IContext;
        function error(param1:String, param2:Boolean, param3:int=-1, param4:Error=null):void;
        function getLastErrorMessage():String;
        function debug(param1:String):void;
        function getLastDebugMessage():String;
        function warning(param1:String):void;
        function getLastWarningMessage():String;
        function get displayObjectContainer():DisplayObjectContainer;
        function loadFromFile(param1:URLRequest, param2:LoaderContext):LibraryLoader;
        function attachComponent(param1:Component, param2:Array):void;
        function detachComponent(param1:Component):void;
        function prepareComponent(param1:Class, param2:uint=0, param3:ApplicationDomain=null):IUnknown;
        function prepareAssetLibrary(param1:XML, param2:Class):Boolean;
        function registerUpdateReceiver(param1:IUpdateReceiver, param2:uint):void;
        function removeUpdateReceiver(param1:IUpdateReceiver):void;
        function toXMLString(param1:uint=0):String;

    }
}