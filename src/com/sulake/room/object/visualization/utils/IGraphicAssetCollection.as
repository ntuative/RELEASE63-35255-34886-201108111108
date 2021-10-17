package com.sulake.room.object.visualization.utils
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;

    public interface IGraphicAssetCollection 
    {

        function dispose():void;
        function set assetLibrary(param1:IAssetLibrary):void;
        function addReference():void;
        function removeReference():void;
        function define(param1:XML):Boolean;
        function getAsset(param1:String):IGraphicAsset;
        function getAssetWithPalette(param1:String, param2:String):IGraphicAsset;
        function getPaletteNames():Array;
        function getPaletteColors(param1:String):Array;
        function addAsset(param1:String, param2:BitmapData, param3:Boolean, param4:int=0, param5:int=0, param6:Boolean=false, param7:Boolean=false):Boolean;
        function disposeAsset(param1:String):void;

    }
}