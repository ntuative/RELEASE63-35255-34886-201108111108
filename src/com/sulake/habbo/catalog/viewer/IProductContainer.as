package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.IWindowContainer;

    public interface IProductContainer extends IDisposable 
    {

        function initProductIcon(param1:IRoomEngine):void;
        function activate():void;
        function deActivate():void;
        function get products():Array;
        function get firstProduct():IProduct;
        function set view(param1:IWindowContainer):void;
        function get view():IWindowContainer;
        function set grid(param1:IItemGrid):void;
        function setClubIconLevel(param1:int):void;

    }
}