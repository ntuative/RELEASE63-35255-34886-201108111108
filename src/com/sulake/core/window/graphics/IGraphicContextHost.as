package com.sulake.core.window.graphics
{
    public interface IGraphicContextHost 
    {

        function get name():String;
        function getGraphicContext(param1:Boolean):IGraphicContext;
        function hasGraphicsContext():Boolean;

    }
}