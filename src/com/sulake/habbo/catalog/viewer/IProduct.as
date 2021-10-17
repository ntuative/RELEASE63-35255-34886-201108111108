package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;

    public interface IProduct extends IGetImageListener, IDisposable 
    {

        function get productType():String;
        function get productClassId():int;
        function set extraParam(param1:String):void;
        function get extraParam():String;
        function get productCount():int;
        function get expiration():int;
        function get productData():IProductData;
        function get furnitureData():IFurnitureData;
        function initIcon(param1:IProductContainer, param2:IGetImageListener=null, param3:IPurchasableOffer=null, param4:IBitmapWrapperWindow=null, param5:Function=null):BitmapData;
        function set view(param1:IWindowContainer):void;
        function set grid(param1:IItemGrid):void;

    }
}