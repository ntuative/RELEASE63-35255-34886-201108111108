package com.sulake.core.window.components
{
    public interface IScrollableListWindow extends IItemListWindow 
    {

        function set autoHideScrollBar(param1:Boolean):void;
        function get autoHideScrollBar():Boolean;

    }
}