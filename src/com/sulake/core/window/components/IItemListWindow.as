package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.IIterable;

    public interface IItemListWindow extends IWindow, IScrollableWindow, IIterable 
    {

        function get spacing():int;
        function set spacing(param1:int):void;
        function get scaleToFitItems():Boolean;
        function set scaleToFitItems(param1:Boolean):void;
        function get autoArrangeItems():Boolean;
        function set autoArrangeItems(param1:Boolean):void;
        function get resizeOnItemUpdate():Boolean;
        function set resizeOnItemUpdate(param1:Boolean):void;
        function get numListItems():int;
        function addListItem(param1:IWindow):IWindow;
        function addListItemAt(param1:IWindow, param2:uint):IWindow;
        function getListItemAt(param1:uint):IWindow;
        function getListItemByID(param1:uint):IWindow;
        function getListItemByName(param1:String):IWindow;
        function getListItemByTag(param1:String):IWindow;
        function getListItemIndex(param1:IWindow):int;
        function removeListItem(param1:IWindow):IWindow;
        function removeListItemAt(param1:int):IWindow;
        function setListItemIndex(param1:IWindow, param2:int):void;
        function swapListItems(param1:IWindow, param2:IWindow):void;
        function groupListItemsWithID(param1:uint, param2:Array, param3:Boolean=false):uint;
        function groupListItemsWithTag(param1:String, param2:Array, param3:Boolean=false):uint;
        function swapListItemsAt(param1:int, param2:int):void;
        function removeListItems():void;
        function destroyListItems():void;
        function arrangeListItems():void;
        function populate(param1:Array):void;

    }
}