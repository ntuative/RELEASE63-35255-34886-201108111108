package com.sulake.habbo.catalog.navigation
{
    import flash.display.BitmapData;

    public interface ICatalogNode 
    {

        function dispose():void;
        function get isOpen():Boolean;
        function get depth():int;
        function get isBranch():Boolean;
        function get isLeaf():Boolean;
        function get isNavigateable():Boolean;
        function get localization():String;
        function get pageId():int;
        function get color():uint;
        function get icon():BitmapData;
        function get children():Array;
        function activate():void;
        function deActivate():void;
        function hasChild(param1:ICatalogNode):Boolean;
        function addChild(param1:ICatalogNode):void;
        function open():void;
        function close():void;
        function get parent():ICatalogNode;
        function set parent(param1:ICatalogNode):void;

    }
}