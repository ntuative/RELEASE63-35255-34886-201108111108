package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;

    public interface IGridItem extends IDisposable 
    {

        function get view():IWindowContainer;
        function set view(param1:IWindowContainer):void;
        function set grid(param1:IItemGrid):void;
        function setDraggable(param1:Boolean):void;
        function activate():void;
        function deActivate():void;

    }
}