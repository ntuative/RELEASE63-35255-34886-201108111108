package com.sulake.habbo.catalog.navigation
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;

    public interface ICatalogNavigator 
    {

        function dispose():void;
        function get catalog():IHabboCatalog;
        function buildCatalogIndex(param1:NodeData):void;
        function activateNode(param1:ICatalogNode):void;
        function openPage(param1:String):void;
        function openPageById(param1:int, param2:int):void;
        function loadFrontPage():void;
        function loadNewAdditionsPage(param1:String):void;
        function isInitialized():Boolean;

    }
}