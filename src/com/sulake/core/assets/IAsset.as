package com.sulake.core.assets
{
    import com.sulake.core.runtime.IDisposable;

    public interface IAsset extends IDisposable 
    {

        function get url():String;
        function get content():Object;
        function get declaration():AssetTypeDeclaration;
        function setUnknownContent(param1:Object):void;
        function setFromOtherAsset(param1:IAsset):void;
        function setParamsDesc(param1:XMLList):void;

    }
}