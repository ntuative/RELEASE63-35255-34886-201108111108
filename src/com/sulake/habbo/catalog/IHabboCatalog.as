package com.sulake.habbo.catalog
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.purse.IPurse;
    import com.sulake.habbo.catalog.recycler.IRecycler;
    import com.sulake.habbo.catalog.marketplace.IMarketPlace;

    public interface IHabboCatalog extends IUnknown 
    {

        function redeemVoucher(param1:String):void;
        function loadCatalogPage(param1:int, param2:int):void;
        function getRecyclerStatus():void;
        function getRecyclerPrizes():void;
        function sendRecycleItems(param1:Array):void;
        function get assets():IAssetLibrary;
        function get windowManager():IHabboWindowManager;
        function get configuration():IHabboConfigurationManager;
        function get events():IEventDispatcher;
        function get localization():ICoreLocalizationManager;
        function get connection():IConnection;
        function openCatalog():void;
        function openCatalogPage(param1:String, param2:Boolean=false):void;
        function openCatalogPageById(param1:int, param2:int):void;
        function openInventoryCategory(param1:String):void;
        function openCreditsHabblet():void;
        function setupInventoryForRecycler(param1:Boolean):void;
        function requestInventoryFurniToRecycler():int;
        function returnInventoryFurniFromRecycler(param1:int):Boolean;
        function get privateRoomSessionActive():Boolean;
        function get tradingActive():Boolean;
        function getProductData(param1:String):IProductData;
        function getFurnitureData(param1:int, param2:String):IFurnitureData;
        function getPixelEffectIcon(param1:int):BitmapData;
        function getSubscriptionProductIcon(param1:int):BitmapData;
        function getPurse():IPurse;
        function getRecycler():IRecycler;
        function getMarketPlace():IMarketPlace;
        function getPublicMarketPlaceOffers(param1:int, param2:int, param3:String, param4:int):void;
        function getOwnMarketPlaceOffers():void;
        function buyMarketPlaceOffer(param1:int):void;
        function redeemSoldMarketPlaceOffers():void;
        function redeemExpiredMarketPlaceOffer(param1:int):void;
        function getMarketplaceItemStats(param1:int, param2:int):void;
        function showNotEnoughCreditsAlert():void;
        function getHabboClubOffers():void;

    }
}