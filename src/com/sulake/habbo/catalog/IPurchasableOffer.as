package com.sulake.habbo.catalog
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.viewer.IProductContainer;

    public interface IPurchasableOffer extends IDisposable 
    {

        function get offerId():int;
        function get priceInActivityPoints():int;
        function get activityPointType():int;
        function get priceInCredits():int;
        function get page():ICatalogPage;
        function get priceType():String;
        function get productContainer():IProductContainer;
        function get localizationId():String;

    }
}