package com.sulake.core.window.components
{
    public interface IScrollbarWindow extends IInteractiveWindow 
    {

        function get scrollH():Number;
        function get scrollV():Number;
        function get scrollable():IScrollableWindow;
        function set scrollH(param1:Number):void;
        function set scrollV(param1:Number):void;
        function set scrollable(param1:IScrollableWindow):void;
        function get vertical():Boolean;
        function get horizontal():Boolean;

    }
}