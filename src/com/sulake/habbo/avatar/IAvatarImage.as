package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.animation.IAvatarDataContainer;

    public interface IAvatarImage extends IDisposable 
    {

        function getCroppedImage(param1:String):BitmapData;
        function getImage(param1:String, param2:Boolean):BitmapData;
        function setDirection(param1:String, param2:int):void;
        function setDirectionAngle(param1:String, param2:int):void;
        function updateAnimationByFrames(param1:int=1):void;
        function getScale():String;
        function getSubType():int;
        function getSprites():Array;
        function getLayerData(param1:ISpriteDataContainer):IAnimationLayerData;
        function getAsset(param1:String):BitmapDataAsset;
        function getDirection():int;
        function getFigure():IAvatarFigureContainer;
        function getPartColor(param1:String):IPartColor;
        function isAnimating():Boolean;
        function getCanvasOffsets():Array;
        function get petType():int;
        function get petBreed():int;
        function initActionAppends():void;
        function endActionAppends():void;
        function appendAction(param1:String, ... _args):Boolean;
        function get avatarSpriteData():IAvatarDataContainer;
        function isPlaceholder():Boolean;
        function forceActionUpdate():void;

    }
}