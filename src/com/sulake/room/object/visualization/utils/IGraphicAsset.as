﻿package com.sulake.room.object.visualization.utils
{
    import com.sulake.core.assets.IAsset;

    public interface IGraphicAsset 
    {

        function get flipV():Boolean;
        function get flipH():Boolean;
        function get width():int;
        function get height():int;
        function get asset():IAsset;
        function get assetName():String;
        function get libraryAssetName():String;
        function get offsetX():int;
        function get offsetY():int;
        function get originalOffsetX():int;
        function get originalOffsetY():int;
        function get usesPalette():Boolean;

    }
}