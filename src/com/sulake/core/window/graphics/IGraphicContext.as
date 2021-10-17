package com.sulake.core.window.graphics
{
    import flash.display.IBitmapDrawable;
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public interface IGraphicContext extends IBitmapDrawable, IEventDispatcher, IDisposable 
    {

        function get parent():DisplayObjectContainer;
        function set parent(param1:DisplayObjectContainer):void;
        function get filters():Array;
        function set filters(param1:Array):void;
        function get visible():Boolean;
        function set visible(param1:Boolean):void;
        function get blend():Number;
        function set blend(param1:Number):void;
        function get mouse():Boolean;
        function set mouse(param1:Boolean):void;
        function getDrawRegion():Rectangle;
        function setDrawRegion(param1:Rectangle, param2:Boolean, param3:Rectangle):void;
        function getDisplayObject():DisplayObject;
        function setDisplayObject(param1:DisplayObject):DisplayObject;
        function getAbsoluteMousePosition(param1:Point):void;
        function getRelativeMousePosition(param1:Point):void;
        function fetchDrawBuffer():IBitmapDrawable;
        function showRedrawRegion(param1:Rectangle):void;
        function get numChildContexts():int;
        function addChildContext(param1:IGraphicContext):IGraphicContext;
        function addChildContextAt(param1:IGraphicContext, param2:int):IGraphicContext;
        function getChildContextAt(param1:int):IGraphicContext;
        function getChildContextIndex(param1:IGraphicContext):int;
        function removeChildContext(param1:IGraphicContext):IGraphicContext;
        function removeChildContextAt(param1:int):IGraphicContext;
        function setChildContextIndex(param1:IGraphicContext, param2:int):void;
        function swapChildContexts(param1:IGraphicContext, param2:IGraphicContext):void;
        function swapChildContextsAt(param1:int, param2:int):void;

    }
}