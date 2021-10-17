package com.sulake.habbo.session
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.product.IProductDataListener;
    import com.sulake.habbo.session.furniture.IFurniDataListener;

    public interface ISessionDataManager extends IUnknown 
    {

        function get events():IEventDispatcher;
        function get systemOpen():Boolean;
        function get systemShutDown():Boolean;
        function hasSecurity(param1:int):Boolean;
        function hasUserRight(param1:String, param2:int):Boolean;
        function get clubLevel():int;
        function get userId():int;
        function get userName():String;
        function get realName():String;
        function get figure():String;
        function get gender():String;
        function get isAnyRoomController():Boolean;
        function getUserTags(param1:int):Array;
        function getBadgeImage(param1:String):BitmapData;
        function requestBadgeImage(param1:String):BitmapData;
        function getBadgeImageWithInfo(param1:String):BadgeInfo;
        function getGroupBadgeId(param1:int):String;
        function getGroupBadgeImage(param1:String):BitmapData;
        function isIgnored(param1:String):Boolean;
        function ignoreUser(param1:String):void;
        function unignoreUser(param1:String):void;
        function get respectLeft():int;
        function get petRespectLeft():int;
        function giveRespect(param1:int):void;
        function givePetRespect(param1:int):void;
        function getProductData(param1:String):IProductData;
        function getFloorItemData(param1:int):IFurnitureData;
        function getWallItemData(param1:int):IFurnitureData;
        function getFloorItemDataByName(param1:String, param2:int=0):IFurnitureData;
        function getWallItemDataByName(param1:String, param2:int=0):IFurnitureData;
        function openHabboHomePage(param1:int):void;
        function showGroupBadgeInfo(param1:int):void;
        function pickAllFurniture(param1:int, param2:int):void;
        function loadProductData(param1:IProductDataListener=null):Boolean;
        function getFurniData(param1:IFurniDataListener):Array;

    }
}