package com.sulake.habbo.inventory.common
{
    import flash.display.BitmapData;

    public interface IThumbListDrawableItem 
    {

        function set iconImage(param1:BitmapData):void;
        function get iconImage():BitmapData;
        function set isSelected(param1:Boolean):void;
        function get isSelected():Boolean;

    }
}