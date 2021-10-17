package com.sulake.core.assets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.LibraryLoader;
    import flash.net.URLRequest;

    public interface IAssetLibrary extends IDisposable 
    {

        function get url():String;
        function get name():String;
        function get isReady():Boolean;
        function get numAssets():uint;
        function get manifest():XML;
        function get nameArray():Array;
        function loadFromFile(param1:LibraryLoader, param2:Boolean=true):void;
        function loadFromResource(param1:XML, param2:Class):Boolean;
        function unload():void;
        function loadAssetFromFile(param1:String, param2:URLRequest, param3:String=null):AssetLoaderStruct;
        function getAssetByName(param1:String):IAsset;
        function getAssetByContent(param1:Object):IAsset;
        function getAssetByIndex(param1:uint):IAsset;
        function getAssetIndex(param1:IAsset):int;
        function hasAsset(param1:String):Boolean;
        function setAsset(param1:String, param2:IAsset, param3:Boolean=true):Boolean;
        function createAsset(param1:String, param2:AssetTypeDeclaration):IAsset;
        function removeAsset(param1:IAsset):IAsset;
        function registerAssetTypeDeclaration(param1:AssetTypeDeclaration, param2:Boolean=true):Boolean;
        function getAssetTypeDeclarationByMimeType(param1:String, param2:Boolean=true):AssetTypeDeclaration;
        function getAssetTypeDeclarationByClass(param1:Class, param2:Boolean=true):AssetTypeDeclaration;
        function getAssetTypeDeclarationByFileName(param1:String, param2:Boolean=true):AssetTypeDeclaration;

    }
}