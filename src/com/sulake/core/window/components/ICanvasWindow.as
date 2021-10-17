package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;

    public interface ICanvasWindow extends IWindow 
    {

        function retrieveDrawBuffer(param1:Point, param2:Rectangle):BitmapData;

    }
}