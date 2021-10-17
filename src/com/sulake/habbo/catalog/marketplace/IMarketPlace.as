package com.sulake.habbo.catalog.marketplace
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.utils.Map;

    public interface IMarketPlace 
    {

        function get windowManager():IHabboWindowManager;
        function get localization():ICoreLocalizationManager;
        function registerVisualization(param1:IMarketPlaceVisualization=null):void;
        function onOffers(param1:IMessageEvent):void;
        function onOwnOffers(param1:IMessageEvent):void;
        function onBuyResult(param1:IMessageEvent):void;
        function onCancelResult(param1:IMessageEvent):void;
        function requestOffersByName(param1:String):void;
        function requestOffersByPrice(param1:int):void;
        function requestOffers(param1:int, param2:int, param3:String, param4:int):void;
        function refreshOffers():void;
        function requestOwnItems():void;
        function requestItemStats(param1:int, param2:int):void;
        function buyOffer(param1:int):void;
        function redeemExpiredOffer(param1:int):void;
        function redeemSoldOffers():void;
        function latestOffers():Map;
        function latestOwnOffers():Map;
        function totalItemsFound():int;
        function set itemStats(param1:MarketplaceItemStats):void;
        function get itemStats():MarketplaceItemStats;
        function get creditsWaiting():int;
        function get averagePricePeriod():int;
        function set averagePricePeriod(param1:int):void;
        function getNameLocalizationKey(param1:IMarketPlaceOfferData):String;
        function getDescriptionLocalizationKey(param1:IMarketPlaceOfferData):String;

    }
}