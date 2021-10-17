package com.sulake.habbo.catalog.viewer
{
    public interface IItemGrid 
    {

        function select(param1:IGridItem):void;
        function startDragAndDrop(param1:IGridItem):Boolean;
        function dispose():void;

    }
}