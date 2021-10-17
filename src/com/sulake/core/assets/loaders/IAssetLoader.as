package com.sulake.core.assets.loaders
{
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.net.URLRequest;

    public interface IAssetLoader extends IEventDispatcher, IDisposable 
    {

        function get url():String;
        function get ready():Boolean;
        function get content():Object;
        function get mimeType():String;
        function get bytesLoaded():uint;
        function get bytesTotal():uint;
        function get errorCode():uint;
        function load(param1:URLRequest):void;

    }
}