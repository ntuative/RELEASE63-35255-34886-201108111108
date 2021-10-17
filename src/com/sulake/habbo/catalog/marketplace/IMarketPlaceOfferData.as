package com.sulake.habbo.catalog.marketplace
{
    import flash.display.BitmapData;

    public interface IMarketPlaceOfferData 
    {

        function get offerId():int;
        function get furniId():int;
        function get furniType():int;
        function get stuffData():String;
        function get price():int;
        function get averagePrice():int;
        function get image():BitmapData;
        function set image(param1:BitmapData):void;
        function set imageCallback(param1:int):void;
        function get imageCallback():int;
        function get status():int;
        function get timeLeftMinutes():int;
        function set timeLeftMinutes(param1:int):void;
        function set price(param1:int):void;
        function set offerId(param1:int):void;
        function get offerCount():int;
        function set offerCount(param1:int):void;

    }
}